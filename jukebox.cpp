#include "jukebox.h"

Jukebox::Jukebox(QObject *parent) : QObject(parent){
    timer = new QTimer(this);
    connect(timer, SIGNAL (timeout()), this, SLOT (setPlayer()));
    timer->start(1000);
    this->exit = false;
}

QString Jukebox::getVoteTitle(int index){
    return this->votes[index].title;
}

QString Jukebox::getTotalTime(){
    return this->total.toString("mm:ss");
}

QString Jukebox::getElapsedTime(){
    return this->elapsed.toString("mm:ss");
}

QString Jukebox::getSong() {
    return this->song;
}

int Jukebox::getVoteIndex(int index) {
    return this->votes[index].index;
}

int Jukebox::getVoteCount(int index) {
    return this->votes[index].count;
}

int Jukebox::getVotesLength() {
    return this->votes.length();
}


int Jukebox::getTotalVotes() {
    return this->totalVotes;
}

double Jukebox::getPlayerVal() {
    double playerVal = (double)QTime(0, 0, 0).secsTo(this->elapsed) / QTime(0, 0, 0).secsTo(this->total);
    return (playerVal < 1.0) ? playerVal : 1.0;
}

void Jukebox::vote(int index) {
    emit disableVoters();
    write(fd, QString::number(index + 200).toStdString().c_str(), 3);
}

void Jukebox::connectToServer(QString ip) {
    addrinfo hints {};
    hints.ai_family = AF_INET;
    hints.ai_protocol = IPPROTO_TCP;
    addrinfo *resolved;

    if(int err = getaddrinfo(ip.toStdString().c_str(), "12333", &hints, &resolved)) {
        emit connectFail();
        return;
    }

    this->fd = socket(resolved->ai_family, resolved->ai_socktype, resolved->ai_protocol);
    if(::connect(this->fd, resolved->ai_addr, resolved->ai_addrlen)){
        emit connectFail();
        freeaddrinfo(resolved);
        return;
    }

    freeaddrinfo(resolved);
    emit connectSuccess();
}

void Jukebox::setPlayer() {
    this->elapsed = this->elapsed.addSecs(1);
    if(this->elapsed == this->total) {
        loadData();
        emit updatePlayer();
        emit resetVoters();
    } else if (this->elapsed.addSecs(10) >= this->total) emit disableVoters();
    emit updatePlayer();
}

void Jukebox::countVotes() {
    int sum = 0;
    foreach (Vote item, this->votes) {
        sum += item.count;
    }
    this->totalVotes = sum;
}

void Jukebox::receiveData() {
    while(!exit){
       char header[10];
       read(fd, header,10);
       QStringList data = QString(header).split("::");
       if(data.length() == 2){
           char *info = new char[data[1].toInt()];
           read(fd, info, data[1].toInt());
           parseMessage(data[0].toInt(), QString(info));
           delete [] info;
       }
    }
}

void Jukebox::setExit(bool exit) {
    this->exit = exit;
}

void Jukebox::parseMessage(int code, QString msg) {
    switch (code / 100) {
    case 1:
        switch (code % 100) {
        case 0:
            this->votes.erase(this->votes.begin(), this->votes.end());
            loadData();
            emit resetVoters();
            break;
        case 1:
            this->song = msg;
            break;
        case 2:
            this->elapsed = QTime(0,0,0).addSecs(msg.toInt());
            break;
        case 3:
            if(msg.toInt()==-1){
                usleep(200);
                write(fd, QString::number(103).toStdString().c_str(), 3);
            } else
                this->total = QTime(0,0,0).addSecs(msg.toInt());
            break;
        }
        emit updatePlayer();
        break;
    case 3:
    {
        int index = code % 100;
        int voteIndex = findVote(index);

        QString msgTitle = msg.split("::")[0];
        int msgCount = msg.split("::")[1].toInt();

        if(voteIndex == -1){
            this->votes.append({index, msgTitle, msgCount});
            countVotes();
            emit resetVoters();
        } else {
            this->votes[voteIndex] = {index, msgTitle, msgCount};
            countVotes();
            emit updateVoters();
        }
        break;
    }
    }
}

int Jukebox::findVote(int index) {
    for(int i=0; i< votes.length(); i++){
        if(votes[i].index == index) return i;
    }
    return -1;
}

void Jukebox::loadData() {
    write(fd, QString::number(101).toStdString().c_str(), 3);
    write(fd, QString::number(102).toStdString().c_str(), 3);
    write(fd, QString::number(103).toStdString().c_str(), 3);
    write(fd, QString::number(300).toStdString().c_str(), 3);
}


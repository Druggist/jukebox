#include "jukebox.h"

Jukebox::Jukebox(QObject *parent) {
    this->votes.append({0,"Lorem ipsum",10});
    this->votes.append({1,"Lorem ipsum",10});
    this->votes.append({2,"Lorem ipsum",10});
    this->votes.append({3,"Lorem ipsum",10});
    this->song = "Bracia Banolec POLE POLE";
    this->elapsed = QTime(0,0,0);
    this->total = QTime(0,1,2);


    timer = new QTimer(this);
    connect(timer, SIGNAL (timeout()), this, SLOT (setPlayer()));

    //SET START ON LOAD
    timer->start(1000);
    countVotes();
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
    //VOTING IMPLEMENTATION

    emit updateVoters();
}

void Jukebox::connectToServer(QString ip) {
    QHostAddress ipCheck;
    if(ipCheck.setAddress(ip)) {
       //CONNECT TO SERVER
            emit connectSuccess();
            return;
    }
    emit connectFail();
}

void Jukebox::setPlayer() {
    this->elapsed = this->elapsed.addSecs(1);
    if(this->elapsed == this->total) timer->stop();
    else if (this->elapsed.addSecs(10) == this->total) emit disableVoters();
    emit updatePlayer();
}

void Jukebox::countVotes() {
    int sum = 0;
    foreach (Vote item, this->votes) {
        sum += item.count;
    }
    this->totalVotes = sum;
}

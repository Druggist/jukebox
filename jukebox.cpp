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
    count_votes();
}

QString Jukebox::get_vote_title(int index){
    return this->votes[index].title;
}

QString Jukebox::get_total_time(){
    return this->total.toString("mm:ss");
}

QString Jukebox::get_elapsed_time(){
    return this->elapsed.toString("mm:ss");
}

QString Jukebox::get_song() {
    return this->song;
}

int Jukebox::get_vote_index(int index) {
    return this->votes[index].index;
}

int Jukebox::get_vote_count(int index) {
    return this->votes[index].count;
}

int Jukebox::get_votes_length() {
    return this->votes.length();
}


int Jukebox::get_total_votes() {
    return this->total_votes;
}

double Jukebox::get_player_val() {
    double player_val = (double)QTime(0, 0, 0).secsTo(this->elapsed) / QTime(0, 0, 0).secsTo(this->total);
    return (player_val < 1.0) ? player_val : 1.0;
}

void Jukebox::vote(int) {
    emit disableVoters();
    //VOTING IMPLEMENTATION

    emit updateVoters();
}

void Jukebox::setPlayer() {
    this->elapsed = this->elapsed.addSecs(1);
    if(this->elapsed == this->total) timer->stop();
    emit updatePlayer();
}

void Jukebox::count_votes() {
    int sum = 0;
    foreach (Vote item, this->votes) {
        sum += item.count;
    }
    this->total_votes = sum;
}

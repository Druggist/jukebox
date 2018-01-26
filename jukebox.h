#ifndef JUKEBOX_H
#define JUKEBOX_H

#include <QObject>
#include <QString>
#include <QTime>
#include <QTimer>
#include <QVector>
#include <unistd.h>
#include <netdb.h>

#include <QDebug>

typedef struct Vote {
    int index;
    QString title;
    int count;
} Vote;

class Jukebox: public QObject {
    Q_OBJECT
public:
    explicit Jukebox(QObject *parent = 0);
    Q_INVOKABLE QString getVoteTitle(int);
    Q_INVOKABLE QString getTotalTime();
    Q_INVOKABLE QString getElapsedTime();
    Q_INVOKABLE QString getSong();
    Q_INVOKABLE int getVoteIndex(int);
    Q_INVOKABLE int getVoteCount(int);
    Q_INVOKABLE int getVotesLength();
    Q_INVOKABLE int getTotalVotes();
    Q_INVOKABLE double getPlayerVal();
    Q_INVOKABLE void vote(int);
    Q_INVOKABLE void connectToServer(QString);
    void receiveData();
    void loadData();
    void setExit(bool);

signals:
    void timerTick();
    void updatePlayer();
    void updateVoters();
    void disableVoters();
    void resetVoters();
    void connectFail();
    void connectSuccess();

public slots:
    void setPlayer();

private:
    void countVotes();
    void parseMessage(int, QString);
    int findVote(int);

    QVector<Vote> votes;
    QTime elapsed;
    QTime total;
    QTimer *timer;
    QString song;
    int totalVotes;

    int fd;
    bool exit;
};

#endif // JUKEBOX_H

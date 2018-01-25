#ifndef JUKEBOX_H
#define JUKEBOX_H

#include <QObject>
#include <QString>
#include <QTime>
#include <QTimer>
#include <QVector>

typedef struct Vote {
    int index;
    QString title;
    int count;
} Vote;

class Jukebox: public QObject {
    Q_OBJECT
public:
    explicit Jukebox(QObject *parent = 0);
    Q_INVOKABLE QString get_vote_title(int);
    Q_INVOKABLE QString get_total_time();
    Q_INVOKABLE QString get_elapsed_time();
    Q_INVOKABLE QString get_song();
    Q_INVOKABLE int get_vote_index(int);
    Q_INVOKABLE int get_vote_count(int);
    Q_INVOKABLE int get_votes_length();
    Q_INVOKABLE int get_total_votes();
    Q_INVOKABLE double get_player_val();
    Q_INVOKABLE void vote(int);

signals:
    void timerTick();
    void updatePlayer();
    void updateVoters();
    void disableVoters();
    void resetVoters();

public slots:
    void setPlayer();

private:
    void count_votes();

    QVector<Vote> votes;
    QTime elapsed;
    QTime total;
    QTimer *timer;
    QString song;
    int total_votes;
};

#endif // JUKEBOX_H

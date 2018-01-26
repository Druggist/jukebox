#include "handler.h"

Handler::Handler(QObject *parent) : QObject(parent) {
    jukebox = new(Jukebox);
    connect(jukebox, SIGNAL (connectSuccess()), this, SLOT (runConcurrent()));
}

void Handler::runConcurrent() {
    QFuture<void> future = QtConcurrent::run(jukebox, &Jukebox::receiveData);
    jukebox->loadData();
}

void Handler::closing() {
    jukebox->setExit(true);
}

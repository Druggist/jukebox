#ifndef HANDLER_H
#define HANDLER_H

#include "jukebox.h"
#include <QObject>
#include <QtConcurrent/QtConcurrent>

class Handler : public QObject
{
    Q_OBJECT
public:
    explicit Handler(QObject *parent = nullptr);
    Jukebox *jukebox;

signals:

public slots:
    void runConcurrent();
    void closing();
};

#endif // HANDLER_H

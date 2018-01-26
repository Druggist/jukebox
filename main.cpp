#include "handler.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtConcurrent/QtConcurrent>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    Handler handler;
    QObject::connect(&app, SIGNAL(aboutToQuit()), &handler, SLOT(closing()));


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("jukebox", handler.jukebox);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

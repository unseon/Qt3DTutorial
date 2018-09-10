#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <Qt3DQuick/QQmlAspectEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "bezierstroke.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

#ifdef Q_OS_WIN
    app.setAttribute(Qt::AA_UseDesktopOpenGL);
#endif

    qmlRegisterType<BezierStroke>("QtBezierStroke", 1, 0, "BezierStroke");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

// Using Qt3DQuickWindow
/*
#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

#ifdef Q_OS_WIN
    app.setAttribute(Qt::AA_UseDesktopOpenGL);
#endif

    qmlRegisterType<BezierStroke>("QtBezierStroke", 1, 0, "BezierStroke");

    Qt3DExtras::Quick::Qt3DQuickWindow view;
    view.setWidth(480);
    view.setHeight(480);

    view.setSource(QUrl("qrc:/Content3D.qml"));
    view.show();

    return app.exec();
}
*/

#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <Qt3DQuick/QQmlAspectEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QGuiApplication>

#include "beziercurvebuffer.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    Qt3DExtras::Quick::Qt3DQuickWindow view;
    view.setWidth(480);
    view.setHeight(480);

    BezierCurveBuffer buffer;
    view.engine()->qmlEngine()->rootContext()->setContextProperty("bezierCurveBuffer", &buffer);
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}

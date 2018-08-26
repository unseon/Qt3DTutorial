#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    Qt3DExtras::Quick::Qt3DQuickWindow view;
    view.setWidth(480);
    view.setHeight(480);
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}

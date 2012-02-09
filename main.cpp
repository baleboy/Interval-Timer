#include <QtGui/QApplication>
#include <QtDeclarative>


#include "qmlapplicationviewer.h"
#include "resourcehandler.h"
#include "settings.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    qmlRegisterType<ResourceHandler,1>("Policy", 1, 0, "ResourceHandler");
    qmlRegisterType<Settings,1>("Settings", 1, 0, "Settings");

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/circuittimer/main.qml"));
    viewer->showExpanded();

    return app->exec();
}

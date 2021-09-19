/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 08/07/2021                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Codigo principal del programa.                            */
/*************************************************************/

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "hmimanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl)
    {
        if ((!obj) && (url == objUrl))
        {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);

    // Registro del backend C++ en QML
    qmlRegisterType<HMIManager>("SCPA.HMIManager", 1, 0, "HMIManager");

    // Se carga el archivo QML
    engine.load(url);

    // Buble infinito
    return app.exec();
}

/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 09/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Entrada del programa para interfaz de usuario.            */
/*************************************************************/

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "guiscpamanager.h"

int main(int argc, char *argv[])
{
    // Importamos el modulo del teclado virtual
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    // Registramos el manejador al QML
    qmlRegisterType<GUISCPAManager>("GUISCPA", 1, 0, "GUISCPAManager");

    // Iniciamos la aplicacion
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}

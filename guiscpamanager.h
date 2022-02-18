/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 09/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Clase que maneja la lógica de datos del HMI y el modulo   */
/* de comunicación con el sistema de control.                */
/*************************************************************/

#ifndef GUISCPAMANAGER_H
#define GUISCPAMANAGER_H

#include <QObject>

#include <QThread>
#include <QDebug>

#include <qqml.h>

#include "hmiclientmanager.h"

class GUISCPAManager : public QObject
{
        Q_OBJECT
        QML_ELEMENT

    public:
        explicit GUISCPAManager(QObject *parent = nullptr);
        ~GUISCPAManager();

        // Conexion
        Q_INVOKABLE void connectToServer(const QString serverIP, const QString serverPort);
        Q_INVOKABLE void disconnectToServer();

        Q_INVOKABLE void loginToServer(const QString user, const QString password);
        Q_INVOKABLE void forceLoginToServer(bool confirm);

        // Simulacion
        Q_INVOKABLE void setParam(hmiprotocoldata::SimulationSensor sensor, float value);

    signals:
        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(bool confirm);

        void sendSetParam(hmiprotocoldata::SimulationSensor sensor, float value);

        // Señales para QML
        // Conexion
        void clientConnected(); // Conexion
        void clientErrorConnected();    // Error al conectar
        void clientDisconnected();  // Desconexion
        void clientErrorDisconnected();    // Error al desconectar

        // Login
        void loginError(); // Error de usuario o contraseña
        void loginForceRequired(); // Ya hay un usuario conectado
        void loginCorrect(); // Logeo exitoso

        // Desconexiones de parte del servidor
        void loginTimeOut();    // Tiempo de conexion excedido
        void otherUserLogin();  // Otro usuario inicio sesión

    private:
        // Hilo de administración de cliente
        QThread *hmiClientThread = nullptr;
        HMIClientManager *hmiClientManager = nullptr;
};

#endif // GUISCPAMANAGER_H

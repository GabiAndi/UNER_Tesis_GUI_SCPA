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

#include <qqml.h>

#include "hmiclientmanager.h"

class GUISCPAManager : public QObject
{
        Q_OBJECT
        QML_ELEMENT

    public:
        explicit GUISCPAManager(QObject *parent = nullptr);
        ~GUISCPAManager();

        Q_INVOKABLE void connectToServer(const QString serverIP, const QString serverPort);
        Q_INVOKABLE void disconnectToServer();

        Q_INVOKABLE void loginToServer(const QString user, const QString password);
        Q_INVOKABLE void forceLoginToServer(const QString user, const QString password, bool confirm);

    signals:
        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(const QString user, const QString password, bool confirm);

        // Señales para QML
        // Conexion
        void clientConnected(); // Conexion realizada
        void clientFailConnected(); // Error de red en la conexion
        void clientLoginConnected(); // La conexion fue exitosa
        void clientErrorConnected();    // Error de nombre de usuario o contraseña
        void clientBusyConnected(); // Un usuario ya esta conectado
        void clientPassConnected(); // Se decidio dejar la sesion actual activa
        void clientUndefinedErrorConnected();   // Error no esperado
        void clientDisconnected();  // Desconexion

    private:
        // Hilo de administración de cliente
        QThread *hmiClientThread = nullptr;
        HMIClientManager *hmiClientManager = nullptr;
};

#endif // GUISCPAMANAGER_H

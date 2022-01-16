/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 11/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Clase que maneja la interacción del cliente HMI con       */
/* el servidor y sistema de control.                         */
/*************************************************************/

#ifndef HMICLIENTMANAGER_H
#define HMICLIENTMANAGER_H

#include <QObject>

#include <QTcpSocket>
#include <QTimer>

#include "hmiprotocol.h"
#include "hmiprotocoldata.h"

using namespace hmiprotocoldata;

class HMIClientManager : public QObject
{
        Q_OBJECT

    public:
        explicit HMIClientManager(QObject *parent = nullptr);
        ~HMIClientManager();

    signals:
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

    public slots:
        void init();

        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(const QString user, const QString password, bool confirm);
        void sendAlive();

    private:
        // Conexion
        QTcpSocket *serverSocket = nullptr;

        // Protocolo
        HMIProtocol *hmiProtocol = nullptr;

    private slots:
        // Eventos
        void clientConnection();
        void clientErrorConnection(QAbstractSocket::SocketError error);
        void clientDisconnection();

        // Slot que analiza los comandos
        void newPackage(const uint8_t cmd, const QByteArray payload);
};

#endif // HMICLIENTMANAGER_H

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

#include "hmiprotocolmanager.h"

class HMIClientManager : public QObject
{
        Q_OBJECT

    public:
        explicit HMIClientManager(QObject *parent = nullptr);
        ~HMIClientManager();

    signals:
        void readData(const QByteArray data);
        void writeData(const QByteArray cmd, const QByteArray payload);

    public slots:
        void init();

        void hmiConnect(const QString serverIP, const QString serverPort);

    private:
        // Conexion
        QTcpSocket *serverSocket = nullptr;

        // Protocolo
        HMIProtocolManager *protocolManager = nullptr;

    private slots:
        // Eventos
        void clientConnection();
        void clientErrorConnection(QAbstractSocket::SocketError error);
        void clientDisconnection();
};

#endif // HMICLIENTMANAGER_H

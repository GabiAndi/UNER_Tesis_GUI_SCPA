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
#include <QThread>

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

        void sendAlive();
        void userLogin(const QString user, const QString password);

    public slots:
        void init();

        void hmiConnect(const QString serverIP, const QString serverPort,
                        const QString user, const QString password);

    private:
        // Conexion
        QTcpSocket *serverSocket = nullptr;

        QString *user = nullptr;
        QString *password = nullptr;

        // Protocolo
        QThread *protocolThread = nullptr;
        HMIProtocolManager *protocolManager = nullptr;

    private slots:
        // Eventos
        void hmiConnected();
        void hmiErrorOccurred(QAbstractSocket::SocketError error);
        void hmiDisconnected();

        void userConnected();
};

#endif // HMICLIENTMANAGER_H

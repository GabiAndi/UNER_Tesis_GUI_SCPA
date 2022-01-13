/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 11/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Gestiona el protocolo de comunicacion desarrollado para   */
/* el sistema.                                               */
/*************************************************************/

#ifndef HMIPROTOCOLMANAGER_H
#define HMIPROTOCOLMANAGER_H

#include <QObject>

#include <QTimer>

#include "hmiprotocol.h"

class HMIProtocolManager : public QObject
{
        Q_OBJECT

    public:
        explicit HMIProtocolManager(QObject *parent = nullptr);
        ~HMIProtocolManager();

    signals:
        void readyWrite(const QByteArray package);

    public slots:
        void init();

        void readData(const QByteArray package);

        void sendAlive();
        void userLogin(const QString user, const QString password);

    private:
        enum Command : uint8_t
        {
            ALIVE = 0xA0,
            LOGIN = 0xA1
        };

        HMIProtocol *hmiProtocol = nullptr;

    private slots:
        void newPackage(const uint8_t cmd, const QByteArray payload);
};

#endif // HMIPROTOCOLMANAGER_H

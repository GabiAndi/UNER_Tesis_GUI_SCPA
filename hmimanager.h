/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 08/07/2021                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Codigo controlador del HMI.                               */
/*************************************************************/

#ifndef HMIMANAGER_H
#define HMIMANAGER_H

#include <QObject>
#include <QDebug>
#include <QTcpSocket>

class HMIManager : public QObject
{
        Q_OBJECT

    public:
        explicit HMIManager(QObject *parent = nullptr);

        Q_INVOKABLE void serverConnect(const QString ip, const QString port);
        Q_INVOKABLE void serverDisconnect();
        Q_INVOKABLE void serverSendData(const QString data);

    private:
        QTcpSocket *server = nullptr;

        QString hmiServerIP;
        QString hmiServerPort;
};

#endif // HMIMANAGER_H

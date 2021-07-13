#include "hmimanager.h"

HMIManager::HMIManager(QObject *parent) : QObject(parent)
{
    // Se inicia el cliente TCP
    server = new QTcpSocket();
}

void HMIManager::serverConnect(const QString ip, const QString port)
{
    server->connectToHost(ip, port.toInt());
}

void HMIManager::serverDisconnect()
{
    server->disconnectFromHost();
}

void HMIManager::serverSendData(const QString data)
{
    server->write(data.toLatin1());
}

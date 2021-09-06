#include "hmimanager.h"

HMIManager::HMIManager(QObject *parent) : QObject(parent)
{
    // Se inicia el cliente TCP
    server = new QTcpSocket();
}

HMIManager::~HMIManager()
{
    delete server;
}

void HMIManager::serverConnect(const QString ip, const QString port)
{
    server->connectToHost(ip, port.toInt());
}

void HMIManager::serverDisconnect()
{
    server->disconnectFromHost();
}

#include "hmimanager.h"

HMIManager::HMIManager(QObject *parent) : QObject(parent)
{
    // Se inicia el cliente TCP
    server = new QTcpSocket;
}

void HMIManager::serverConnect(const QString ip, const QString port)
{
    //server->connectToHost(ip, port.toInt());

    qDebug() << "Me apretarooon.";
}

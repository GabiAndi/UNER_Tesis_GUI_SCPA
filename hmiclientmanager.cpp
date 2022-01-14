#include "hmiclientmanager.h"

HMIClientManager::HMIClientManager(QObject *parent)
    : QObject{parent}
{

}

HMIClientManager::~HMIClientManager()
{
    // Protocolo
    delete protocolManager;

    delete serverSocket;
}

void HMIClientManager::init()
{
    // Conexion
    serverSocket = new QTcpSocket(this);

    serverSocket->setSocketOption(QAbstractSocket::KeepAliveOption, 1);

    connect(serverSocket, &QTcpSocket::connected, this, &HMIClientManager::clientConnection);
    connect(serverSocket, &QTcpSocket::errorOccurred, this, &HMIClientManager::clientErrorConnection);
    connect(serverSocket, &QTcpSocket::disconnected, this, &HMIClientManager::clientDisconnection);

    // Protocolo
    protocolManager = new HMIProtocolManager();

    connect(serverSocket, &QTcpSocket::readyRead, this, [this]()
    {
        protocolManager->readData(serverSocket->readAll());
    });

    connect(protocolManager, &HMIProtocolManager::readyWrite, this, [this](const QByteArray package)
    {
        serverSocket->write(package);
    });
}

void HMIClientManager::hmiConnect(const QString serverIP, const QString serverPort)
{
    serverSocket->connectToHost(serverIP, serverPort.toInt());
}

void HMIClientManager::clientConnection()
{

}

void HMIClientManager::clientErrorConnection(QAbstractSocket::SocketError error)
{

}

void HMIClientManager::clientDisconnection()
{

}


#include "hmiclientmanager.h"

HMIClientManager::HMIClientManager(QObject *parent)
    : QObject{parent}
{

}

HMIClientManager::~HMIClientManager()
{
    // Protocolo
    protocolThread->quit();
    protocolThread->wait();

    delete protocolManager;
    delete protocolThread;

    delete serverSocket;

    delete user;
    delete password;
}

void HMIClientManager::init()
{
    // Conexion
    serverSocket = new QTcpSocket(this);

    connect(serverSocket, &QTcpSocket::connected, this, &HMIClientManager::hmiConnected);
    connect(serverSocket, &QTcpSocket::errorOccurred, this, &HMIClientManager::hmiErrorOccurred);
    connect(serverSocket, &QTcpSocket::disconnected, this, &HMIClientManager::hmiDisconnected);

    connect(serverSocket, &QTcpSocket::readyRead, this, [this]()
    {
        emit readData(serverSocket->readAll());
    });

    // Protocolo
    protocolThread = new QThread(this);
    protocolManager = new HMIProtocolManager();

    protocolManager->moveToThread(protocolThread);

    connect(protocolThread, &QThread::started, protocolManager, &HMIProtocolManager::init);

    connect(this, &HMIClientManager::readData, protocolManager, &HMIProtocolManager::readData);

    connect(protocolManager, &HMIProtocolManager::readyWrite, this, [this](const QByteArray package)
    {
        serverSocket->write(package);
    });

    connect(this, &HMIClientManager::sendAlive, protocolManager, &HMIProtocolManager::sendAlive);
    connect(this, &HMIClientManager::userLogin, protocolManager, &HMIProtocolManager::userLogin);

    protocolThread->start();

    // Usuario y contraseña
    user = new QString();
    password = new QString();
}

void HMIClientManager::hmiConnect(const QString serverIP, const QString serverPort,
                                  const QString user, const QString password)
{
    *this->user = user;
    *this->password = password;

    serverSocket->connectToHost(QHostAddress(serverIP), serverPort.toInt());
}

void HMIClientManager::hmiConnected()
{
    emit userLogin(*user, *password);
}

void HMIClientManager::hmiErrorOccurred(QAbstractSocket::SocketError error)
{

}

void HMIClientManager::hmiDisconnected()
{

}

void HMIClientManager::userConnected()
{

}

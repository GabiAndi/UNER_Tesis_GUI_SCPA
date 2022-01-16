#include "hmiclientmanager.h"

HMIClientManager::HMIClientManager(QObject *parent)
    : QObject{parent}
{

}

HMIClientManager::~HMIClientManager()
{
    // Protocolo
    delete hmiProtocol;

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
    hmiProtocol = new HMIProtocol(this);

    connect(serverSocket, &QTcpSocket::readyRead, this, [this]()
    {
        hmiProtocol->read(serverSocket->readAll());
    });

    connect(hmiProtocol, &HMIProtocol::readyWrite, this, [this](const QByteArray package)
    {
        serverSocket->write(package);
    });

    connect(hmiProtocol, &HMIProtocol::readyRead, this, &HMIClientManager::newPackage);
}

void HMIClientManager::hmiConnect(const QString serverIP, const QString serverPort)
{
    serverSocket->connectToHost(serverIP, serverPort.toInt());
}

void HMIClientManager::hmiDisconnect()
{
    serverSocket->disconnectFromHost();
}

void HMIClientManager::sendLogin(const QString user, const QString password)
{
    QByteArray payload;

    payload.append((uint8_t)(user.length()));
    payload.append(user.toUtf8());
    payload.append((uint8_t)(password.length()));
    payload.append(password.toUtf8());

    hmiProtocol->write(Command::LOGIN, payload);
}

void HMIClientManager::sendForceLogin(const QString user, const QString password, bool confirm)
{
    QByteArray payload;

    payload.append(confirm);
    payload.append((uint8_t)(user.length()));
    payload.append(user.toUtf8());
    payload.append((uint8_t)(password.length()));
    payload.append(password.toUtf8());

    hmiProtocol->write(Command::FORCE_LOGIN, payload);
}

void HMIClientManager::sendAlive()
{
    hmiProtocol->write(Command::ALIVE, QByteArray().append(Payload::PAYLOAD_OK));
}

void HMIClientManager::clientConnection()
{
    // Informamos que se establecio una conexion
    emit clientConnected();
}

void HMIClientManager::clientErrorConnection(QAbstractSocket::SocketError error)
{
    // Informamos que hubo un error
    emit clientFailConnected();
}

void HMIClientManager::clientDisconnection()
{
    // Informamos que se cerro una conexion
    emit clientDisconnected();
}

void HMIClientManager::newPackage(const uint8_t cmd, const QByteArray payload)
{
    // Se analiza el comando recibido
    switch (cmd)
    {
        // Alive
        case Command::ALIVE:
        {
            if ((uint8_t)(payload.at(0)) != Payload::PAYLOAD_OK)
                break;

            break;
        }

        // Login request
        case Command::LOGIN_REQUEST:
        {
            switch ((uint8_t)(payload.at(0)))
            {
                case LoginRequest::LOGIN_OK:
                    emit clientLoginConnected();
                    break;

                case LoginRequest::LOGIN_ERROR:
                    emit clientErrorConnected();
                    break;

                case LoginRequest::LOGIN_BUSY:
                    emit clientBusyConnected();
                    break;

                case LoginRequest::LOGIN_PASS:
                    emit clientPassConnected();
                    break;

                default:
                    emit clientUndefinedErrorConnected();
                    break;
            }

            break;
        }

        // Comando no valido
        default:
        {
            break;
        }
    }
}

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

    serverSocket->setSocketOption(QAbstractSocket::SocketOption::KeepAliveOption, 1);

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

void HMIClientManager::sendForceLogin(bool confirm)
{
    hmiProtocol->write(Command::FORCE_LOGIN, confirm ?
                           QByteArray().append(ForceLogin::FORCE_CONNECT) :
                           QByteArray().append(ForceLogin::NO_FORCE_CONNECT)
                           );
}

void HMIClientManager::sendAlive()
{
    hmiProtocol->write(Command::KEEP_ALIVE, QByteArray().append(KeepAliveMode::REPLY));
}

void HMIClientManager::clientConnection()
{
    // Informamos que se establecio una conexion
    emit clientConnected();
}

void HMIClientManager::clientErrorConnection(QAbstractSocket::SocketError error)
{
    // Informamos que hubo un error
    emit clientErrorConnected();
}

void HMIClientManager::clientDisconnection()
{
    // Informamos que se cerro una conexion
    emit clientDisconnected();
}

void HMIClientManager::newPackage(const uint8_t cmd, const QByteArray payload)
{
    // Se analiza el comando recibido
    switch ((Command)(cmd))
    {
        /*
         * ALIVE
         *
         * Si recibimos un alive lo devolvemos automaticamente
         * sin informar al client manager.
         */
        case Command::KEEP_ALIVE:
        {
            if ((uint8_t)(payload.at(0)) == KeepAliveMode::REPLY)
            {
                hmiProtocol->write(Command::KEEP_ALIVE, QByteArray().append(KeepAliveMode::REQUEST));
            }

            else if ((uint8_t)(payload.at(0)) == KeepAliveMode::REQUEST)
            {

            }

            break;
        }

        // Login request
        case Command::LOGIN_REQUEST:
        {
            switch ((LoginRequest)(payload.at(0)))
            {
                case LoginRequest::LOGIN_CORRECT:
                    emit loginCorrect();
                    break;

                case LoginRequest::LOGIN_FORCE_REQUIRED:
                    emit loginForceRequired();
                    break;

                case LoginRequest::LOGIN_ERROR:
                    emit loginError();
                    break;
            }

            break;
        }

        // Informe de desconexión
        case Command::DISCONNECT_CODE:
        {
            switch ((DisconnectCode)(payload.at(0)))
            {
                case DisconnectCode::LOGIN_TIMEOUT:
                    emit loginTimeOut();
                    break;

                case DisconnectCode::OTHER_USER_LOGIN:
                    emit otherUserLogin();
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

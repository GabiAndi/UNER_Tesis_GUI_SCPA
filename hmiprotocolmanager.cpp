#include "hmiprotocolmanager.h"

HMIProtocolManager::HMIProtocolManager(QObject *parent)
    : QObject{parent}
{

}

HMIProtocolManager::~HMIProtocolManager()
{
    delete hmiProtocol;
}

void HMIProtocolManager::init()
{
    // Protocolo
    hmiProtocol = new HMIProtocol(this);

    connect(hmiProtocol, &HMIProtocol::readyRead, this, &HMIProtocolManager::newPackage);
    connect(hmiProtocol, &HMIProtocol::readyWrite,this, &HMIProtocolManager::readyWrite);
}

void HMIProtocolManager::readData(const QByteArray package)
{
    hmiProtocol->read(package);
}

void HMIProtocolManager::sendAlive()
{
    uint8_t cmd = Command::ALIVE;

    QByteArray payload;

    payload.append((uint8_t)(0xFF));

    hmiProtocol->write(cmd, payload);
}

void HMIProtocolManager::userLogin(const QString user, const QString password)
{
    uint8_t cmd = Command::LOGIN;

    QByteArray payload;

    payload.append((uint8_t)(user.length()));
    payload.append(user.toUtf8());
    payload.append((uint8_t)(password.length()));
    payload.append(password.toUtf8());

    hmiProtocol->write(cmd, payload);
}

void HMIProtocolManager::newPackage(const uint8_t cmd, const QByteArray payload)
{
    // Se analiza el comando recibido
    switch (cmd)
    {
        // Alive
        case Command::ALIVE:

            break;

        // Login
        case Command::LOGIN:
            if (payload.length() != 1)
                break;

            if ((uint8_t)(payload.at(0)) != (uint8_t)(0xFF))
                break;

            break;
    }
}

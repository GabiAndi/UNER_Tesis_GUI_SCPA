#include "guiscpamanager.h"

GUISCPAManager::GUISCPAManager(QObject *parent)
    : QObject{parent}
{
    // Creamos los hilos
    hmiClientThread = new QThread(this);
    hmiClientManager = new HMIClientManager();

    hmiClientManager->moveToThread(hmiClientThread);

    connect(hmiClientThread, &QThread::started, hmiClientManager, &HMIClientManager::init);

    // Señales al hilo del administrador de cliente
    connect(this, &GUISCPAManager::hmiConnect, hmiClientManager, &HMIClientManager::hmiConnect);
    connect(this, &GUISCPAManager::hmiDisconnect, hmiClientManager, &HMIClientManager::hmiDisconnect);

    connect(this, &GUISCPAManager::sendLogin, hmiClientManager, &HMIClientManager::sendLogin);
    connect(this, &GUISCPAManager::sendForceLogin, hmiClientManager, &HMIClientManager::sendForceLogin);

    // Eventos del hilo de cliente a QML
    // Conexion
    connect(hmiClientManager, &HMIClientManager::clientConnected, this, &GUISCPAManager::clientConnected);
    connect(hmiClientManager, &HMIClientManager::clientErrorConnected, this, &GUISCPAManager::clientErrorConnected);
    connect(hmiClientManager, &HMIClientManager::clientDisconnected, this, &GUISCPAManager::clientDisconnected);
    connect(hmiClientManager, &HMIClientManager::clientErrorDisconnected, this, &GUISCPAManager::clientErrorDisconnected);

    // Login
    connect(hmiClientManager, &HMIClientManager::loginError, this, &GUISCPAManager::loginError);
    connect(hmiClientManager, &HMIClientManager::loginForceRequired, this, &GUISCPAManager::loginForceRequired);
    connect(hmiClientManager, &HMIClientManager::loginCorrect, this, &GUISCPAManager::loginCorrect);

    // Desconexiones de parte del servidor
    connect(hmiClientManager, &HMIClientManager::loginTimeOut, this, &GUISCPAManager::loginTimeOut);
    connect(hmiClientManager, &HMIClientManager::otherUserLogin, this, &GUISCPAManager::otherUserLogin);

    // Comandos
    connect(this, &GUISCPAManager::sendSetParam, hmiClientManager, &HMIClientManager::sendSetParam);

    hmiClientThread->start();
}

GUISCPAManager::~GUISCPAManager()
{
    hmiClientThread->quit();
    hmiClientThread->wait();

    delete hmiClientManager;
    delete hmiClientThread;
}

void GUISCPAManager::connectToServer(const QString serverIP, const QString serverPort)
{
    emit hmiConnect(serverIP, serverPort);
}

void GUISCPAManager::disconnectToServer()
{
    emit hmiDisconnect();
}

void GUISCPAManager::loginToServer(const QString user, const QString password)
{
    emit sendLogin(user, password);
}

void GUISCPAManager::forceLoginToServer(bool confirm)
{
    emit sendForceLogin(confirm);
}

void GUISCPAManager::setParam(SimulationSensor sensor, float value)
{
    emit sendSetParam(sensor, value);
}

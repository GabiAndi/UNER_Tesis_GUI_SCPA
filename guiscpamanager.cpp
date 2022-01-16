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
    connect(hmiClientManager, &HMIClientManager::clientConnected, this, &GUISCPAManager::clientConnected);
    connect(hmiClientManager, &HMIClientManager::clientFailConnected, this, &GUISCPAManager::clientFailConnected);
    connect(hmiClientManager, &HMIClientManager::clientLoginConnected, this, &GUISCPAManager::clientLoginConnected);
    connect(hmiClientManager, &HMIClientManager::clientErrorConnected, this, &GUISCPAManager::clientErrorConnected);
    connect(hmiClientManager, &HMIClientManager::clientBusyConnected, this, &GUISCPAManager::clientBusyConnected);
    connect(hmiClientManager, &HMIClientManager::clientPassConnected, this, &GUISCPAManager::clientPassConnected);
    connect(hmiClientManager, &HMIClientManager::clientUndefinedErrorConnected, this, &GUISCPAManager::clientUndefinedErrorConnected);
    connect(hmiClientManager, &HMIClientManager::clientDisconnected, this, &GUISCPAManager::clientDisconnected);

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

void GUISCPAManager::forceLoginToServer(const QString user, const QString password, bool confirm)
{
    emit sendForceLogin(user, password, confirm);
}

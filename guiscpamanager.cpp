#include "guiscpamanager.h"

GUISCPAManager::GUISCPAManager(QObject *parent)
    : QObject{parent}
{
    // Creamos los hilos
    hmiClientThread = new QThread(this);
    hmiClientManager = new HMIClientManager();

    hmiClientManager->moveToThread(hmiClientThread);

    connect(hmiClientThread, &QThread::started, hmiClientManager, &HMIClientManager::init);

    connect(this, &GUISCPAManager::hmiConnect, hmiClientManager, &HMIClientManager::hmiConnect);
    connect(this, &GUISCPAManager::sendLogin, hmiClientManager, &HMIClientManager::sendLogin);

    connect(hmiClientManager, &HMIClientManager::hmiConnected, this, &GUISCPAManager::hmiConnected);

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

void GUISCPAManager::loginToServer(const QString user, const QString password)
{
    emit sendLogin(user, password);
}


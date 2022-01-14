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

#include "guiscpamanager.h"

GUISCPAManager::GUISCPAManager(QObject *parent)
    : QObject{parent}
{
    _serverIP = "XD";
}

QString GUISCPAManager::getServerIP()
{
    return _serverIP;
}

void GUISCPAManager::setServerIP(const QString &serverIP)
{
    _serverIP = serverIP;

    emit serverIPChanged();
}

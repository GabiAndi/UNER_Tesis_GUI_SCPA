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

    // Parametros
    connect(hmiClientManager, &HMIClientManager::setLvFoso, this, &GUISCPAManager::setLvFoso);
    connect(hmiClientManager, &HMIClientManager::setLvLodo, this, &GUISCPAManager::setLvLodo);
    connect(hmiClientManager, &HMIClientManager::setTemp, this, &GUISCPAManager::setTemp);
    connect(hmiClientManager, &HMIClientManager::setOD, this, &GUISCPAManager::setOD);
    connect(hmiClientManager, &HMIClientManager::setPhAnox, this, &GUISCPAManager::setPhAnox);
    connect(hmiClientManager, &HMIClientManager::setPhAireacion, this, &GUISCPAManager::setPhAireacion);

    connect(hmiClientManager, &HMIClientManager::setMotorCurrent, this, &GUISCPAManager::setMotorCurrent);
    connect(hmiClientManager, &HMIClientManager::setMotorVoltaje, this, &GUISCPAManager::setMotorVoltaje);
    connect(hmiClientManager, &HMIClientManager::setMotorTemp, this, &GUISCPAManager::setMotorTemp);
    connect(hmiClientManager, &HMIClientManager::setMotorVelocity, this, &GUISCPAManager::setMotorVelocity);

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

void GUISCPAManager::setParam(Sensor sensor, float value)
{
    emit sendSetParam(sensor, value);
}

float GUISCPAManager::getLvFoso()
{
    return lvFoso;
}

void GUISCPAManager::setLvFoso(float newLvFoso)
{
    lvFoso = newLvFoso;

    emit lvFosoChanged();
}

float GUISCPAManager::getLvLodo()
{
    return lvLodo;
}

void GUISCPAManager::setLvLodo(float newLvLodo)
{
    lvLodo = newLvLodo;

    emit lvLodoChanged();
}

float GUISCPAManager::getTemp()
{
    return temp;
}

void GUISCPAManager::setTemp(float newTemp)
{
    temp = newTemp;

    emit tempChanged();
}

float GUISCPAManager::getOD()
{
    return od;
}

void GUISCPAManager::setOD(float newOD)
{
    od = newOD;

    emit odChanged();
}

float GUISCPAManager::getPhAnox()
{
    return phAnox;
}

void GUISCPAManager::setPhAnox(float newPhAnox)
{
    phAnox = newPhAnox;

    emit phAnoxChanged();
}

float GUISCPAManager::getPhAireacion()
{
    return phAireacion;
}

void GUISCPAManager::setPhAireacion(float newPhAireacion)
{
    phAireacion = newPhAireacion;

    emit phAireacionChanged();
}

float GUISCPAManager::getMotorCurrent()
{
    return motorCurrent;
}

void GUISCPAManager::setMotorCurrent(float newMotorCurrent)
{
    motorCurrent = newMotorCurrent;

    emit motorCurrentChanged();
}

float GUISCPAManager::getMotorVoltaje()
{
    return motorVoltaje;
}

void GUISCPAManager::setMotorVoltaje(float newMotorVoltaje)
{
    motorVoltaje = newMotorVoltaje;

    emit motorVoltajeChanged();
}

float GUISCPAManager::getMotorTemp()
{
    return motorTemp;
}

void GUISCPAManager::setMotorTemp(float newMotorTemp)
{
    motorTemp = newMotorTemp;

    emit motorTempChanged();
}

float GUISCPAManager::getMotorVelocity()
{
    return motorVelocity;
}

void GUISCPAManager::setMotorVelocity(float newMotorVelocity)
{
    motorVelocity = newMotorVelocity;

    emit motorVelocityChanged();
}

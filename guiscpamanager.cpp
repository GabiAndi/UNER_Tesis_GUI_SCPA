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
    connect(this, &GUISCPAManager::sendSetSensorValue, hmiClientManager, &HMIClientManager::sendSetSensorValue);
    connect(this, &GUISCPAManager::sendSetSystemState, hmiClientManager, &HMIClientManager::sendSetSystemState);

    // Parametros
    connect(hmiClientManager, &HMIClientManager::getSensorValue, this, &GUISCPAManager::getSensorValue);
    connect(hmiClientManager, &HMIClientManager::getSystemState, this, &GUISCPAManager::getSystemState);

    hmiClientThread->start();
}

GUISCPAManager::~GUISCPAManager()
{
    hmiClientThread->quit();
    hmiClientThread->wait();

    delete hmiClientManager;
    delete hmiClientThread;
}

float GUISCPAManager::getSensorLvFoso()
{
    return sensorLvFoso;
}

float GUISCPAManager::getSensorLvLodo()
{
    return sensorLvLodo;
}

float GUISCPAManager::getSensorTemp()
{
    return sensorTemp;
}

float GUISCPAManager::getSensorOD()
{
    return sensorOD;
}

float GUISCPAManager::getSensorPhAnox()
{
    return sensorPhAnox;
}

float GUISCPAManager::getSensorPhAireacion()
{
    return sensorPhAireacion;
}

float GUISCPAManager::getSensorMotorCurrent()
{
    return sensorMotorCurrent;
}

float GUISCPAManager::getSensorMotorVoltaje()
{
    return sensorMotorVoltaje;
}

float GUISCPAManager::getSensorMotorTemp()
{
    return sensorMotorTemp;
}

float GUISCPAManager::getSensorMotorVelocity()
{
    return sensorMotorVelocity;
}

bool GUISCPAManager::getStateSystemActive()
{
    return stateSystemActive;
}

float GUISCPAManager::getStateSetpointOD()
{
    return stateSetpointOD;
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

void GUISCPAManager::setLvFoso(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_LV_FOSO, value);
}

void GUISCPAManager::setLvLodo(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_LV_LODO, value);
}

void GUISCPAManager::setTemp(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_TEMP, value);
}

void GUISCPAManager::setOD(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_OD, value);
}

void GUISCPAManager::setPhAnox(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_PH_ANOX, value);
}

void GUISCPAManager::setPhAireacion(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_PH_AIREACION, value);
}

void GUISCPAManager::setMotorCurrent(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_MOTOR_CURRENT, value);
}

void GUISCPAManager::setMotorVoltaje(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_MOTOR_VOLTAJE, value);
}

void GUISCPAManager::setMotorTemp(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_MOTOR_TEMP, value);
}

void GUISCPAManager::setMotorVelocity(float value)
{
    emit sendSetSensorValue(Sensor::SENSOR_MOTOR_VELOCITY, value);
}

void GUISCPAManager::initSystem()
{
    emit sendSetSystemState(SystemState::CONTROL_SYSTEM, true);
}

void GUISCPAManager::stopSystem()
{
    emit sendSetSystemState(SystemState::CONTROL_SYSTEM, false);
}

void GUISCPAManager::setSetPointOD(float value)
{
    emit sendSetSystemState(SystemState::SETPOINT_OD, value);
}

void GUISCPAManager::getSensorValue(Sensor sensor, float value)
{
    switch (sensor)
    {
        case Sensor::SENSOR_LV_FOSO:
            sensorLvFoso = value;

            break;

        case Sensor::SENSOR_LV_LODO:
            sensorLvLodo = value;

            break;

        case Sensor::SENSOR_TEMP:
            sensorTemp = value;

            break;

        case Sensor::SENSOR_OD:
            sensorOD = value;

            break;

        case Sensor::SENSOR_PH_ANOX:
            sensorPhAnox = value;

            break;

        case Sensor::SENSOR_PH_AIREACION:
            sensorPhAireacion = value;

            break;

        case Sensor::SENSOR_MOTOR_CURRENT:
            sensorMotorCurrent = value;

            break;

        case Sensor::SENSOR_MOTOR_VOLTAJE:
            sensorMotorVoltaje = value;

            break;

        case Sensor::SENSOR_MOTOR_TEMP:
            sensorMotorTemp = value;

            break;

        case Sensor::SENSOR_MOTOR_VELOCITY:
            sensorMotorVelocity = value;

            break;
    }
}

void GUISCPAManager::getSystemState(SystemState state, float value)
{
    switch (state)
    {
        case SystemState::CONTROL_SYSTEM:
            stateSystemActive = value;

            break;

        case SystemState::SETPOINT_OD:
            stateSetpointOD = value;

            break;
    }
}

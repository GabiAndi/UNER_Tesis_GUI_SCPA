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

void GUISCPAManager::setSensorLvFoso(float sensorLvFoso)
{
    this->sensorLvFoso = sensorLvFoso;

    emit sensorLvFosoChanged();
}

float GUISCPAManager::getSensorLvFoso()
{
    return sensorLvFoso;
}

void GUISCPAManager::setSensorLvLodo(float sensorLvLodo)
{
    this->sensorLvLodo = sensorLvLodo;

    emit sensorLvLodoChanged();
}

float GUISCPAManager::getSensorLvLodo()
{
    return sensorLvLodo;
}

void GUISCPAManager::setSensorTemp(float sensorTemp)
{
    this->sensorTemp = sensorTemp;

    emit sensorTempChanged();
}

float GUISCPAManager::getSensorTemp()
{
    return sensorTemp;
}

void GUISCPAManager::setSensorOD(float sensorOD)
{
    this->sensorOD = sensorOD;

    emit sensorODChanged();
}

float GUISCPAManager::getSensorOD()
{
    return sensorOD;
}

void GUISCPAManager::setSensorPhAnox(float sensorPhAnox)
{
    this->sensorPhAnox = sensorPhAnox;

    emit sensorPhAnoxChanged();
}

float GUISCPAManager::getSensorPhAnox()
{
    return sensorPhAnox;
}

void GUISCPAManager::setSensorPhAireacion(float sensorPhAireacion)
{
    this->sensorPhAireacion = sensorPhAireacion;

    emit sensorPhAireacionChanged();
}

float GUISCPAManager::getSensorPhAireacion()
{
    return sensorPhAireacion;
}

void GUISCPAManager::setSensorMotorCurrent(float sensorMotorCurrent)
{
    this->sensorMotorCurrent = sensorMotorCurrent;

    emit sensorMotorCurrentChanged();
}

float GUISCPAManager::getSensorMotorCurrent()
{
    return sensorMotorCurrent;
}

void GUISCPAManager::setSensorMotorVoltaje(float sensorMotorVoltaje)
{
    this->sensorMotorVoltaje = sensorMotorVoltaje;

    emit sensorMotorVoltajeChanged();
}

float GUISCPAManager::getSensorMotorVoltaje()
{
    return sensorMotorVoltaje;
}

void GUISCPAManager::setSensorMotorTemp(float sensorMotorTemp)
{
    this->sensorMotorTemp = sensorMotorTemp;

    emit sensorMotorTempChanged();
}

float GUISCPAManager::getSensorMotorTemp()
{
    return sensorMotorTemp;
}

void GUISCPAManager::setSensorMotorVelocity(float sensorMotorVelocity)
{
    this->sensorMotorVelocity = sensorMotorVelocity;

    emit sensorMotorVelocityChanged();
}

float GUISCPAManager::getSensorMotorVelocity()
{
    return sensorMotorVelocity;
}

void GUISCPAManager::setStateSystemActive(float stateSystemActive)
{
    this->stateSystemActive = stateSystemActive;

    emit stateSystemActiveChanged();
}

bool GUISCPAManager::getStateSystemActive()
{
    return stateSystemActive;
}

void GUISCPAManager::setStateSetpointOD(float stateSetpointOD)
{
    this->stateSetpointOD = stateSetpointOD;

    emit stateSetpointODChanged();
}

float GUISCPAManager::getStateSetpointOD()
{
    return stateSetpointOD;
}

void GUISCPAManager::setStateError(float error)
{
    this->stateError = error;

    emit stateErrorChanged();
}

float GUISCPAManager::getStateError()
{
    return stateError;
}

void GUISCPAManager::setStateKp(float kp)
{
    this->stateKp = kp;

    emit stateKpChanged();
}

float GUISCPAManager::getStateKp()
{
    return stateKp;
}

void GUISCPAManager::setStateRPMKp(float rpmKp)
{
    this->stateRPMKp = rpmKp;

    emit stateRPMKpChanged();
}

float GUISCPAManager::getStateRPMKp()
{
    return stateKp;
}

void GUISCPAManager::setStateKd(float kd)
{
    this->stateKd = kd;

    emit stateKdChanged();
}

float GUISCPAManager::getStateKd()
{
    return stateKd;
}

void GUISCPAManager::setStateRPMKd(float rpmKd)
{
    this->stateRPMKd = rpmKd;

    emit stateRPMKdChanged();
}

float GUISCPAManager::getStateRPMKd()
{
    return stateKd;
}

void GUISCPAManager::setStateKi(float ki)
{
    this->stateKi = ki;

    emit stateKiChanged();
}

float GUISCPAManager::getStateKi()
{
    return stateKi;
}

void GUISCPAManager::setStateRPMKi(float rpmKi)
{
    this->stateRPMKi = rpmKi;

    emit stateRPMKiChanged();
}

float GUISCPAManager::getStateRPMKi()
{
    return stateKi;
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

void GUISCPAManager::setKp(float value)
{
    emit sendSetSystemState(SystemState::PID_KP, value);
}

void GUISCPAManager::setKd(float value)
{
    emit sendSetSystemState(SystemState::PID_KD, value);
}

void GUISCPAManager::setKi(float value)
{
    emit sendSetSystemState(SystemState::PID_KI, value);
}

void GUISCPAManager::chartUpdate(QLineSeries *lineSeriesOD, QLineSeries *lineSeriesRPM,
                                 QLineSeries *lineSeriesRPMKp, QLineSeries *lineSeriesRPMKd,
                                 QLineSeries *lineSeriesRPMKi)
{
    QVector<QPointF> pointsOD;
    QVector<QPointF> pointsRPM;

    QVector<QPointF> pointsRPMKp;
    QVector<QPointF> pointsRPMKd;
    QVector<QPointF> pointsRPMKi;

    int length;

    if (lineSeriesOD)
    {
        length = valuesOD.length();

        for (int i = 0 ; i < length ; i++)
            pointsOD.append(QPointF(i, valuesOD.at(i)));

        lineSeriesOD->replace(pointsOD);
    }

    if (lineSeriesRPM)
    {
        length = valuesRPM.length();

        for (int i = 0 ; i < length ; i++)
            pointsRPM.append(QPointF(i, valuesRPM.at(i)));

        lineSeriesRPM->replace(pointsRPM);
    }

    if (lineSeriesRPMKp)
    {
        length = valuesRPMKp.length();

        for (int i = 0 ; i < length ; i++)
            pointsRPMKp.append(QPointF(i, valuesRPMKp.at(i)));

        lineSeriesRPMKp->replace(pointsRPMKp);
    }

    if (lineSeriesRPMKd)
    {
        length = valuesRPMKd.length();

        for (int i = 0 ; i < length ; i++)
            pointsRPMKd.append(QPointF(i, valuesRPMKd.at(i)));

        lineSeriesRPMKd->replace(pointsRPMKd);
    }

    if (lineSeriesRPMKi)
    {
        length = valuesRPMKi.length();

        for (int i = 0 ; i < length ; i++)
            pointsRPMKi.append(QPointF(i, valuesRPMKi.at(i)));

        lineSeriesRPMKi->replace(pointsRPMKi);
    }
}

void GUISCPAManager::getSensorValue(Sensor sensor, float value)
{
    switch (sensor)
    {
        case Sensor::SENSOR_LV_FOSO:
            setSensorLvFoso(value);

            break;

        case Sensor::SENSOR_LV_LODO:
            setSensorLvLodo(value);

            break;

        case Sensor::SENSOR_TEMP:
            setSensorTemp(value);

            break;

        case Sensor::SENSOR_OD:
            setSensorOD(value);

            if (valuesOD.length() > 60)
                valuesOD.removeFirst();

            valuesOD.append(value);

            break;

        case Sensor::SENSOR_PH_ANOX:
            setSensorPhAnox(value);

            break;

        case Sensor::SENSOR_PH_AIREACION:
            setSensorPhAireacion(value);

            break;

        case Sensor::SENSOR_MOTOR_CURRENT:
            setSensorMotorCurrent(value);

            break;

        case Sensor::SENSOR_MOTOR_VOLTAJE:
            setSensorMotorVoltaje(value);

            break;

        case Sensor::SENSOR_MOTOR_TEMP:
            setSensorMotorTemp(value);

            break;

        case Sensor::SENSOR_MOTOR_VELOCITY:
            setSensorMotorVelocity(value);

            if (valuesRPM.length() > 60)
                valuesRPM.removeFirst();

            valuesRPM.append(value * 56);

            break;
    }
}

void GUISCPAManager::getSystemState(SystemState state, float value)
{
    switch (state)
    {
        case SystemState::CONTROL_SYSTEM:
            setStateSystemActive(value);

            break;

        case SystemState::SETPOINT_OD:
            setStateSetpointOD(value);

            break;

        case SystemState::PID_ERROR:
            setStateError(value);

            break;

        case SystemState::PID_KP:
            setStateKp(value);

            break;

        case SystemState::PID_RPM_KP:
            setStateRPMKp(value);

            if (valuesRPMKp.length() > 60)
                valuesRPMKp.removeFirst();

            valuesRPMKp.append(value * 56);

            break;

        case SystemState::PID_KD:
            setStateKd(value);

            break;

        case SystemState::PID_RPM_KD:
            setStateRPMKd(value);

            if (valuesRPMKd.length() > 60)
                valuesRPMKd.removeFirst();

            valuesRPMKd.append(value * 56);

            break;

        case SystemState::PID_KI:
            setStateKi(value);

            break;

        case SystemState::PID_RPM_KI:
            setStateRPMKi(value);

            if (valuesRPMKi.length() > 60)
                valuesRPMKi.removeFirst();

            valuesRPMKi.append(value * 56);

            break;
    }
}

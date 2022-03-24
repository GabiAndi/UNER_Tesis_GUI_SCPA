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

    delete hmiClientState;

    // Timer de captura
    delete timerData;
}

void HMIClientManager::init()
{
    // Estado
    hmiClientState = new hmi_client_state_t;

    hmiClientState->disconnectionCode = false;
    hmiClientState->connected = false;

    // Conexion
    serverSocket = new QTcpSocket(this);

    serverSocket->setSocketOption(QAbstractSocket::SocketOption::KeepAliveOption, 1);

    connect(serverSocket, &QTcpSocket::connected, this, &HMIClientManager::clientConnection);
    connect(serverSocket, &QTcpSocket::errorOccurred, this, &HMIClientManager::clientErrorOcurred);
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

    // Timer de estado
    timerData = new QTimer(this);

    connect(timerData, &QTimer::timeout, this, &HMIClientManager::sync);
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

void HMIClientManager::sync()
{
    // Enviamos la peticion de estado de cada sensor
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_LV_FOSO));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_LV_LODO));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_TEMP));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_OD));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_PH_ANOX));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_PH_AIREACION));

    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_MOTOR_CURRENT));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_MOTOR_VOLTAJE));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_MOTOR_TEMP));
    hmiProtocol->write(Command::GET_SENSOR, QByteArray().append(Sensor::SENSOR_MOTOR_VELOCITY));

    // Enviamos la petición del estado del sistema
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::CONTROL_SYSTEM));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::SETPOINT_OD));

    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_ERROR));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_KP));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_RPM_KP));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_KD));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_RPM_KD));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_KI));
    hmiProtocol->write(Command::GET_SYSTEM_STATE, QByteArray().append(SystemState::PID_RPM_KI));
}

void HMIClientManager::sendSetSensorValue(Sensor sensor, float value)
{
    DataConverter converter;

    converter.f[0] = value;

    QByteArray data;

    data.append(sensor);
    data.append(converter.u8[0]);
    data.append(converter.u8[1]);
    data.append(converter.u8[2]);
    data.append(converter.u8[3]);

    hmiProtocol->write(Command::SET_SENSOR, data);
}

void HMIClientManager::sendSetSystemState(SystemState state, float value)
{
    DataConverter converter;

    converter.f[0] = value;

    QByteArray data;

    data.append(state);
    data.append(converter.u8[0]);
    data.append(converter.u8[1]);
    data.append(converter.u8[2]);
    data.append(converter.u8[3]);

    hmiProtocol->write(Command::SET_SYSTEM_STATE, data);
}

void HMIClientManager::clientConnection()
{
    // Informamos que se establecio una conexion
    emit clientConnected();

    hmiClientState->disconnectionCode = false;
    hmiClientState->connected = true;

    timerData->start(1000);
}

void HMIClientManager::clientErrorOcurred(QAbstractSocket::SocketError error)
{
    // Informamos que hubo un error
    if (!hmiClientState->connected)
        emit clientErrorConnected();

    else if (!hmiClientState->disconnectionCode)
        emit clientErrorDisconnected();

    hmiClientState->connected = false;

    timerData->stop();
}

void HMIClientManager::clientDisconnection()
{
    // Informamos que se cerro una conexion
    if (hmiClientState->connected && !hmiClientState->disconnectionCode)
        emit clientDisconnected();

    hmiClientState->connected = false;

    timerData->stop();
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

        /*
         * LOGIN_REQUEST
         *
         * Recive el estado del intento de logueo
         */
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

        /*
         * DISCONNECT_CODE
         *
         * Recibe la causa de la desconexion
         */
        case Command::DISCONNECT_CODE:
        {
            hmiClientState->disconnectionCode = true;

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

        /*
         * REQUEST_GET_SENSOR
         *
         * Recibe la respuesta de valores de los sensores
         */
        case Command::REQUEST_GET_SENSOR:
        {
            DataConverter converter;

            converter.u8[0] = payload.at(1);
            converter.u8[1] = payload.at(2);
            converter.u8[2] = payload.at(3);
            converter.u8[3] = payload.at(4);

            emit getSensorValue((Sensor)(payload.at(0)), converter.f[0]);

            break;
        }

        /*
         * REQUEST_SET_SENSOR
         *
         * Recibe la respuesta del seteo de los valores de los sensores
         */
        case Command::REQUEST_SET_SENSOR:
        {


            break;
        }

        /*
         * REQUEST_GET_SYSTEM_STATE
         *
         * Recibe la respuesta del estado del sistema
         */
        case Command::REQUEST_GET_SYSTEM_STATE:
        {
            DataConverter converter;

            converter.u8[0] = payload.at(1);
            converter.u8[1] = payload.at(2);
            converter.u8[2] = payload.at(3);
            converter.u8[3] = payload.at(4);

            emit getSystemState((SystemState)(payload.at(0)), converter.f[0]);

            break;
        }

        /*
         * REQUEST_SET_SYSTEM_STATE
         *
         * Recibe la respuesta del seteo del estado del sistema
         */
        case Command::REQUEST_SET_SYSTEM_STATE:
        {


            break;
        }

        default:
        {
            break;
        }
    }
}

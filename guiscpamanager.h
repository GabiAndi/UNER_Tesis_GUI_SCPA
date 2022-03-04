/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 09/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Clase que maneja la lógica de datos del HMI y el modulo   */
/* de comunicación con el sistema de control.                */
/*************************************************************/

#ifndef GUISCPAMANAGER_H
#define GUISCPAMANAGER_H

#include <QObject>

#include <QThread>
#include <QDebug>

#include <qqml.h>

#include "hmiclientmanager.h"

class GUISCPAManager : public QObject
{
        Q_OBJECT
        QML_ELEMENT

    public:
        explicit GUISCPAManager(QObject *parent = nullptr);
        ~GUISCPAManager();

        // Variables visibles desde QML
        Q_PROPERTY(float sensorLvFoso READ getSensorLvFoso NOTIFY sensorLvFosoChanged);
        float getSensorLvFoso();

        Q_PROPERTY(float sensorLvLodo READ getSensorLvLodo NOTIFY sensorLvLodoChanged);
        float getSensorLvLodo();

        Q_PROPERTY(float sensorTemp READ getSensorTemp NOTIFY sensorTempChanged);
        float getSensorTemp();

        Q_PROPERTY(float sensorOD READ getSensorOD NOTIFY sensorODChanged);
        float getSensorOD();

        Q_PROPERTY(float sensorPhAnox READ getSensorPhAnox NOTIFY sensorPhAnoxChanged);
        float getSensorPhAnox();

        Q_PROPERTY(float sensorPhAireacion READ getSensorPhAireacion NOTIFY sensorPhAireacionChanged);
        float getSensorPhAireacion();

        Q_PROPERTY(float sensorMotorCurrent READ getSensorMotorCurrent NOTIFY sensorMotorCurrentChanged);
        float getSensorMotorCurrent();

        Q_PROPERTY(float sensorMotorVoltaje READ getSensorMotorVoltaje NOTIFY sensorMotorVoltajeChanged);
        float getSensorMotorVoltaje();

        Q_PROPERTY(float sensorMotorTemp READ getSensorMotorTemp NOTIFY sensorMotorTempChanged);
        float getSensorMotorTemp();

        Q_PROPERTY(float sensorMotorVelocity READ getSensorMotorVelocity NOTIFY sensorMotorVelocityChanged);
        float getSensorMotorVelocity();

        Q_PROPERTY(bool stateSystemActive READ getStateSystemActive NOTIFY stateSystemActiveChanged);
        bool getStateSystemActive();

        Q_PROPERTY(float stateSetpointOD READ getStateSetpointOD NOTIFY stateSetpointODChanged);
        float getStateSetpointOD();

        // Funciones invocables desde QML
        // Conexion
        Q_INVOKABLE void connectToServer(const QString serverIP, const QString serverPort);
        Q_INVOKABLE void disconnectToServer();

        Q_INVOKABLE void loginToServer(const QString user, const QString password);
        Q_INVOKABLE void forceLoginToServer(bool confirm);

        // Sensores
        Q_INVOKABLE void setLvFoso(float value);
        Q_INVOKABLE void setLvLodo(float value);
        Q_INVOKABLE void setTemp(float value);
        Q_INVOKABLE void setOD(float value);
        Q_INVOKABLE void setPhAnox(float value);
        Q_INVOKABLE void setPhAireacion(float value);

        Q_INVOKABLE void setMotorCurrent(float value);
        Q_INVOKABLE void setMotorVoltaje(float value);
        Q_INVOKABLE void setMotorTemp(float value);
        Q_INVOKABLE void setMotorVelocity(float value);

        // Estado del sistema
        Q_INVOKABLE void initSystem();
        Q_INVOKABLE void stopSystem();

        Q_INVOKABLE void setSetPointOD(float value);

    public slots:
        void getSensorValue(hmiprotocoldata::Sensor sensor, float value);
        void getSystemState(hmiprotocoldata::SystemState state, float value);

    signals:
        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(bool confirm);

        void sendSetSensorValue(hmiprotocoldata::Sensor sensor, float value);
        void sendSetSystemState(hmiprotocoldata::SystemState state, float value);

        // Señales para QML
        // Conexion
        void clientConnected(); // Conexion
        void clientErrorConnected();    // Error al conectar
        void clientDisconnected();  // Desconexion
        void clientErrorDisconnected();    // Error al desconectar

        // Login
        void loginError(); // Error de usuario o contraseña
        void loginForceRequired(); // Ya hay un usuario conectado
        void loginCorrect(); // Logeo exitoso

        // Desconexiones de parte del servidor
        void loginTimeOut();    // Tiempo de conexion excedido
        void otherUserLogin();  // Otro usuario inicio sesión

        // Señales para QML
        // Sensores
        void sensorLvFosoChanged();
        void sensorLvLodoChanged();
        void sensorTempChanged();
        void sensorODChanged();
        void sensorPhAnoxChanged();
        void sensorPhAireacionChanged();

        void sensorMotorCurrentChanged();
        void sensorMotorVoltajeChanged();
        void sensorMotorTempChanged();
        void sensorMotorVelocityChanged();

        void stateSystemActiveChanged();
        void stateSetpointODChanged();

    private:
        // Hilo de administración de cliente
        QThread *hmiClientThread = nullptr;
        HMIClientManager *hmiClientManager = nullptr;

        // Variables QML
        // Valores de los sensores
        float sensorLvFoso = 0;
        float sensorLvLodo = 0;
        float sensorTemp = 0;
        float sensorOD = 0;
        float sensorPhAnox = 0;
        float sensorPhAireacion = 0;

        float sensorMotorCurrent = 0;
        float sensorMotorVoltaje = 0;
        float sensorMotorTemp = 0;
        float sensorMotorVelocity = 0;

        // Estado del sistema
        bool stateSystemActive = false;

        float stateSetpointOD = 0;
};

#endif // GUISCPAMANAGER_H

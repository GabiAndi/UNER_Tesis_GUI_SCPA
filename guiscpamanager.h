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
#include <QLineSeries>

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
        Q_PROPERTY(float sensorLvFoso READ getSensorLvFoso WRITE setSensorLvFoso NOTIFY sensorLvFosoChanged);
        void setSensorLvFoso(float sensorLvFoso);
        float getSensorLvFoso();

        Q_PROPERTY(float sensorLvLodo READ getSensorLvLodo WRITE setSensorLvLodo NOTIFY sensorLvLodoChanged);
        void setSensorLvLodo(float sensorLvLodo);
        float getSensorLvLodo();

        Q_PROPERTY(float sensorTemp READ getSensorTemp WRITE setSensorTemp NOTIFY sensorTempChanged);
        void setSensorTemp(float sensorTemp);
        float getSensorTemp();

        Q_PROPERTY(float sensorOD READ getSensorOD WRITE setSensorOD NOTIFY sensorODChanged);
        void setSensorOD(float sensorOD);
        float getSensorOD();

        Q_PROPERTY(float sensorPhAnox READ getSensorPhAnox WRITE setSensorPhAnox NOTIFY sensorPhAnoxChanged);
        void setSensorPhAnox(float sensorPhAnox);
        float getSensorPhAnox();

        Q_PROPERTY(float sensorPhAireacion READ getSensorPhAireacion WRITE setSensorPhAireacion NOTIFY sensorPhAireacionChanged);
        void setSensorPhAireacion(float sensorPhAireacion);
        float getSensorPhAireacion();

        Q_PROPERTY(float sensorMotorCurrent READ getSensorMotorCurrent WRITE setSensorMotorCurrent NOTIFY sensorMotorCurrentChanged);
        void setSensorMotorCurrent(float sensorMotorCurrent);
        float getSensorMotorCurrent();

        Q_PROPERTY(float sensorMotorVoltaje READ getSensorMotorVoltaje WRITE setSensorMotorVoltaje NOTIFY sensorMotorVoltajeChanged);
        void setSensorMotorVoltaje(float sensorMotorVoltaje);
        float getSensorMotorVoltaje();

        Q_PROPERTY(float sensorMotorTemp READ getSensorMotorTemp WRITE setSensorMotorTemp NOTIFY sensorMotorTempChanged);
        void setSensorMotorTemp(float sensorMotorTemp);
        float getSensorMotorTemp();

        Q_PROPERTY(float sensorMotorVelocity READ getSensorMotorVelocity WRITE setSensorMotorVelocity NOTIFY sensorMotorVelocityChanged);
        void setSensorMotorVelocity(float sensorMotorVelocity);
        float getSensorMotorVelocity();

        Q_PROPERTY(bool stateSystemActive READ getStateSystemActive WRITE setStateSystemActive NOTIFY stateSystemActiveChanged);
        void setStateSystemActive(float stateSystemActive);
        bool getStateSystemActive();

        Q_PROPERTY(float stateSetpointOD READ getStateSetpointOD WRITE setStateSetpointOD NOTIFY stateSetpointODChanged);
        void setStateSetpointOD(float stateSetpointOD);
        float getStateSetpointOD();

        Q_PROPERTY(float stateError READ getStateError WRITE setStateError NOTIFY stateErrorChanged);
        void setStateError(float error);
        float getStateError();

        Q_PROPERTY(float stateKp READ getStateKp WRITE setStateKp NOTIFY stateKpChanged);
        void setStateKp(float kp);
        float getStateKp();

        Q_PROPERTY(float stateRPMKp READ getStateRPMKp WRITE setStateKp NOTIFY stateRPMKpChanged);
        void setStateRPMKp(float rpmKp);
        float getStateRPMKp();

        Q_PROPERTY(float stateKd READ getStateKd WRITE setStateKd NOTIFY stateKdChanged);
        void setStateKd(float kd);
        float getStateKd();

        Q_PROPERTY(float stateRPMKd READ getStateRPMKd WRITE setStateKd NOTIFY stateRPMKdChanged);
        void setStateRPMKd(float rpmKd);
        float getStateRPMKd();

        Q_PROPERTY(float stateKi READ getStateKi WRITE setStateKi NOTIFY stateKiChanged);
        void setStateKi(float ki);
        float getStateKi();

        Q_PROPERTY(float stateRPMKi READ getStateRPMKi WRITE setStateRPMKi NOTIFY stateRPMKiChanged);
        void setStateRPMKi(float rpmKi);
        float getStateRPMKi();

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

        Q_INVOKABLE void setKp(float value);
        Q_INVOKABLE void setKd(float value);
        Q_INVOKABLE void setKi(float value);

        // Valores de las ultimas 60 muestras
        Q_INVOKABLE void chartUpdate(QLineSeries *lineSeriesOD, QLineSeries *lineSeriesRPM,
                                     QLineSeries *lineSeriesRPMKp, QLineSeries *lineSeriesRPMKd,
                                     QLineSeries *lineSeriesRPMKi);

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

        void stateErrorChanged();
        void stateKpChanged();
        void stateRPMKpChanged();
        void stateKdChanged();
        void stateRPMKdChanged();
        void stateKiChanged();
        void stateRPMKiChanged();

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

        // PID
        float stateError = 0;
        float stateKp = 0;
        float stateRPMKp = 0;
        float stateKd = 0;
        float stateRPMKd = 0;
        float stateKi = 0;
        float stateRPMKi = 0;

        // Ultimos valores de muestra
        QList<float> valuesOD;
        QList<float> valuesRPM;

        QList<float> valuesRPMKp;
        QList<float> valuesRPMKd;
        QList<float> valuesRPMKi;
};

#endif // GUISCPAMANAGER_H

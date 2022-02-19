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

        // Conexion
        Q_INVOKABLE void connectToServer(const QString serverIP, const QString serverPort);
        Q_INVOKABLE void disconnectToServer();

        Q_INVOKABLE void loginToServer(const QString user, const QString password);
        Q_INVOKABLE void forceLoginToServer(bool confirm);

        // Simulacion
        Q_INVOKABLE void setParam(hmiprotocoldata::Sensor sensor, float value);

        // Datos de visualizacion
        Q_PROPERTY(float lvFoso READ getLvFoso WRITE setLvFoso NOTIFY lvFosoChanged);

        float getLvFoso();
        void setLvFoso(float newLvFoso);

        Q_PROPERTY(float lvLodo READ getLvLodo WRITE setLvLodo NOTIFY lvLodoChanged);

        float getLvLodo();
        void setLvLodo(float newLvLodo);

        Q_PROPERTY(float temp READ getTemp WRITE setTemp NOTIFY tempChanged);

        float getTemp();
        void setTemp(float newTemp);

        Q_PROPERTY(float od READ getOD WRITE setOD NOTIFY odChanged);

        float getOD();
        void setOD(float newOD);

        Q_PROPERTY(float phAnox READ getPhAnox WRITE setPhAnox NOTIFY phAnoxChanged);

        float getPhAnox();
        void setPhAnox(float newPhAnox);

        Q_PROPERTY(float phAireacion READ getPhAireacion WRITE setPhAireacion NOTIFY phAireacionChanged);

        float getPhAireacion();
        void setPhAireacion(float newPhAireacion);

        Q_PROPERTY(float motorCurrent READ getMotorCurrent WRITE setMotorCurrent NOTIFY motorCurrentChanged);

        float getMotorCurrent();
        void setMotorCurrent(float newMotorCurrent);

        Q_PROPERTY(float motorVoltaje READ getMotorVoltaje WRITE setMotorVoltaje NOTIFY motorVoltajeChanged);

        float getMotorVoltaje();
        void setMotorVoltaje(float newMotorVoltaje);

        Q_PROPERTY(float motorTemp READ getMotorTemp WRITE setMotorTemp NOTIFY motorTempChanged);

        float getMotorTemp();
        void setMotorTemp(float newMotorTemp);

        Q_PROPERTY(float motorVelocity READ getMotorVelocity WRITE setMotorVelocity NOTIFY motorVelocityChanged);

        float getMotorVelocity();
        void setMotorVelocity(float newMotorVelocity);

    signals:
        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(bool confirm);

        void sendSetParam(hmiprotocoldata::Sensor sensor, float value);

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

        // Parametros recividos de los sensores
        // Pileta
        void lvFosoChanged();
        void lvLodoChanged();
        void tempChanged();
        void odChanged();
        void phAnoxChanged();
        void phAireacionChanged();

        // Motores
        void motorCurrentChanged();
        void motorVoltajeChanged();
        void motorTempChanged();
        void motorVelocityChanged();

    private:
        // Hilo de administración de cliente
        QThread *hmiClientThread = nullptr;
        HMIClientManager *hmiClientManager = nullptr;

        // Valores de los sensores
        float lvFoso = 0;
        float lvLodo = 0;
        float temp = 0;
        float od = 0;
        float phAnox = 0;
        float phAireacion = 0;

        float motorCurrent = 0;
        float motorVoltaje = 0;
        float motorTemp = 0;
        float motorVelocity = 0;
};

#endif // GUISCPAMANAGER_H

/*************************************************************/
/* AUTOR: GabiAndi                                           */
/* FECHA: 11/01/2022                                         */
/*                                                           */
/* DESCRIPCION:                                              */
/* Clase que maneja la interacción del cliente HMI con       */
/* el servidor y sistema de control.                         */
/*************************************************************/

#ifndef HMICLIENTMANAGER_H
#define HMICLIENTMANAGER_H

#include <QObject>

#include <QTimer>
#include <QTcpSocket>

#include "hmiprotocol.h"
#include "hmiprotocoldata.h"

using namespace hmiprotocoldata;

class HMIClientManager : public QObject
{
        Q_OBJECT

    public:
        explicit HMIClientManager(QObject *parent = nullptr);
        ~HMIClientManager();

    signals:
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

        // Sensores
        void getSensorValue(hmiprotocoldata::Sensor sensor, float value);

        // Estado del sistema
        void getSystemState(hmiprotocoldata::SystemState state, float value);

    public slots:
        void init();

        // Señales al hilo del administrador de cliente
        void hmiConnect(const QString serverIP, const QString serverPort);
        void hmiDisconnect();

        // Comandos
        void sendLogin(const QString user, const QString password);
        void sendForceLogin(bool confirm);

        void sendAlive();

        // Sincronización del estado del systema
        void sync();

        // Sensores
        void sendSetSensorValue(hmiprotocoldata::Sensor sensor, float value);

        // Estado del sistema de control
        void sendSetSystemState(hmiprotocoldata::SystemState state, float value);

    private:
        // Conexion
        QTcpSocket *serverSocket = nullptr;

        // Protocolo
        HMIProtocol *hmiProtocol = nullptr;

        // Estado
        typedef struct hmi_client_state
        {
            bool disconnectionCode;
            bool connected;
        }hmi_client_state_t;

        hmi_client_state_t *hmiClientState = nullptr;

        // Timer que solicita el estado del sistema cada x cantidad de tiempo
        QTimer *timerData = nullptr;

    private slots:
        // Eventos
        void clientConnection();
        void clientErrorOcurred(QAbstractSocket::SocketError error);
        void clientDisconnection();

        // Slot que analiza los comandos
        void newPackage(const uint8_t cmd, const QByteArray payload);
};

#endif // HMICLIENTMANAGER_H

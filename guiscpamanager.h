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

#include <qqml.h>

#include "hmiclientmanager.h"

class GUISCPAManager : public QObject
{
        Q_OBJECT
        QML_ELEMENT

    public:
        explicit GUISCPAManager(QObject *parent = nullptr);
        ~GUISCPAManager();

        Q_INVOKABLE void connectToServer(const QString serverIP, const QString serverPort);

    signals:
        void hmiConnect(const QString serverIP, const QString serverPort);

        void sessionInit();

    private:
        QThread *hmiClientThread = nullptr;
        HMIClientManager *hmiClientManager = nullptr;
};

#endif // GUISCPAMANAGER_H

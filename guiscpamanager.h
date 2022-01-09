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

#include <qqml.h>

class GUISCPAManager : public QObject
{
        Q_OBJECT
        Q_PROPERTY(QString serverIP READ getServerIP WRITE setServerIP NOTIFY serverIPChanged)
        QML_ELEMENT

    public:
        explicit GUISCPAManager(QObject *parent = nullptr);

        QString getServerIP();
        void setServerIP(const QString &serverIP);

    signals:
        void serverIPChanged();

    private:
        QString _serverIP;
};

#endif // GUISCPAMANAGER_H

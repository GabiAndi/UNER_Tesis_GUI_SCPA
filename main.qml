import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import SCPA.HMIManager 1.0

Window {
    width: 800
    height: 600
    visible: true
    color: "#2f2f2f"
    title: qsTr("HMI SCPA")
    id: window

    Material.theme: Material.Dark
    Material.accent: "#10A022"

    HMIManager {
        id: hmiManager
    }

    ColumnLayout {
        width: window.width
        height: window.height

        Label {
            text: qsTr("IP del servidor")
            font.pointSize: 14
            Layout.alignment: Qt.AlignCenter
        }

        TextArea {
            id: textAreaIP
            placeholderText: qsTr("10.0.0.100")
            text: "10.0.0.100"
            Layout.alignment: Qt.AlignCenter
        }

        Label {
            text: qsTr("Puerto")
            font.pointSize: 14
            Layout.alignment: Qt.AlignCenter
        }

        TextArea {
            id: textAreaPuerto
            placeholderText: qsTr("33600")
            text: "33600"
            Layout.alignment: Qt.AlignCenter
        }

        Button {
            id: buttonConectar
            text: qsTr("Conectar")
            Layout.alignment: Qt.AlignCenter

            onClicked: {
                hmiManager.serverConnect(textAreaIP.text, textAreaPuerto.text)
            }
        }

        Label {
            text: qsTr("Enviar texto")
            font.pointSize: 14
            Layout.alignment: Qt.AlignCenter
        }

        TextArea {
            id: textAreaMensaje
            placeholderText: qsTr("Mensaje")
            text: "Prueba"
            wrapMode: Text.NoWrap
            Layout.alignment: Qt.AlignCenter
        }

        Button {
            id: buttonEnviar
            text: qsTr("Enviar")
            Layout.alignment: Qt.AlignCenter
        }
    }
}

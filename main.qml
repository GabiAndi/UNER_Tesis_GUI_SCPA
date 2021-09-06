import QtQuick                      2.15
import QtQuick.Window               2.15
import QtQuick.Controls             2.12
import QtQuick.Controls.Material    2.12
import QtQuick.Layouts              1.12

import SCPA.HMIManager              1.0

Window {
    id: window

    width: 800
    height: 600

    visible: true
    visibility: Qt.WindowFullScreen | Qt.Window

    flags: Qt.FramelessWindowHint

    color: "#2f2f2f"
    title: "HMI SCPA"

    Material.theme: Material.Dark
    Material.accent: "#10A022"

    HMIManager {
        id: hmiManager
    }

    ColumnLayout {
        width: parent.width
        height: parent.height

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                topPadding: 10
                text: "Conexión"
                font.pointSize: 32
                Layout.alignment: Qt.AlignCenter
                bottomPadding: 20
            }

            Label {
                text: "Dirección IP"
                font.pointSize: 14
                Layout.alignment: Qt.AlignCenter
            }

            TextArea {
                id: textAreaIP
                placeholderText: "Ejemplo: 192.168.0.100"
                text: "10.0.0.100"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignCenter
            }

            Label {
                text: "Número de puerto"
                font.pointSize: 14
                Layout.alignment: Qt.AlignCenter
            }

            TextArea {
                id: textAreaPuerto
                placeholderText: "Por defecto: 33600"
                text: "33600"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignCenter
            }

            Button {
                id: buttonConectar
                text: "Conectar"
                Layout.alignment: Qt.AlignCenter

                onClicked: {
                    hmiManager.serverConnect(textAreaIP.text, textAreaPuerto.text)
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}
}
##^##*/

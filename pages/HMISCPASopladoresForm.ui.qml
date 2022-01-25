import "../items"

import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias buttonVolver: buttonVolver
    property alias buttonParadaEmergencia: buttonParadaEmergencia
    property alias buttonConfiguracion: buttonConfiguracion
    Pane {
        id: pane
        anchors.fill: parent

        Button {
            id: buttonVolver
            text: qsTr("Volver")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }

        Image {
            id: image
            anchors.fill: parent
            source: "../process/HMISCPASopladores.svg"
            sourceSize.height: width
            sourceSize.width: height
            fillMode: Image.PreserveAspectFit
        }

        Button {
            id: buttonParadaEmergencia
            text: qsTr("Parada de emergencia")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            highlighted: true
        }

        Button {
            id: buttonConfiguracion
            text: qsTr("Configuración")
            anchors.right: parent.right
            anchors.top: parent.top
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:2}D{i:3}D{i:4}D{i:5}D{i:1}
}
##^##*/

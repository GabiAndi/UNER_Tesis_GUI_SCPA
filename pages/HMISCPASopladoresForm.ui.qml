import "../items"

import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias buttonVolver: buttonVolver
    property alias buttonParadaEmergencia: buttonParadaEmergencia
    property alias hMISCPAMotorStatusM01: hMISCPAMotorStatusM01
    property alias switchStateSystem: switchStateSystem

    Pane {
        id: pane
        anchors.fill: parent

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Label {
                id: label
                text: qsTr("Estado de sopladores")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                font.pointSize: 24
            }

            RowLayout {
                id: rowLayout1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    id: image
                    source: "../process/HMISCPASopladores.svg"
                    Layout.fillHeight: true
                    sourceSize.width: image.width
                    sourceSize.height: image.height
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                }

                ColumnLayout {
                    id: columnLayout1
                    Layout.fillHeight: true
                    spacing: 20

                    HMISCPAMotorStatus {
                        id: hMISCPAMotorStatusM01
                        titleText: "P70-M01"
                    }
                }
            }

            RowLayout {
                id: rowLayout
                Layout.fillWidth: true

                Button {
                    id: buttonVolver
                    text: qsTr("Volver")
                }

                Item {
                    id: item2
                    Layout.fillWidth: true
                }



                Switch {
                    id: switchStateSystem
                    text: qsTr("Encendido")
                }
                Item {
                    id: item3
                    Layout.fillWidth: true
                }
                Button {
                    id: buttonParadaEmergencia
                    text: qsTr("Parada de emergencia")
                    highlighted: true
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:3}D{i:5}D{i:7}D{i:6}D{i:4}D{i:9}D{i:10}
D{i:11}D{i:8}D{i:2}D{i:1}
}
##^##*/


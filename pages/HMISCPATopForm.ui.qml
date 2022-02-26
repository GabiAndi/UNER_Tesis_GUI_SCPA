import "../items"

import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias buttonDisconnect: buttonDisconnect
    property alias buttonSopladores: buttonSopladores
    property alias buttonParadaEmergencia: buttonParadaEmergencia
    property alias hMISCPAVariableIndicatorPHAnox: hMISCPAVariableIndicatorPHAnox
    property alias hMISCPAVariableIndicatorLvLodo: hMISCPAVariableIndicatorLvLodo
    property alias hMISCPAVariableIndicatorTemp: hMISCPAVariableIndicatorTemp
    property alias hMISCPAVariableIndicatorPHAireacion: hMISCPAVariableIndicatorPHAireacion
    property alias hMISCPAVariableIndicatorOD: hMISCPAVariableIndicatorOD
    property alias buttonSimulacion: buttonSimulacion
    property alias hMISCPAVariableIndicatorLvFoso: hMISCPAVariableIndicatorLvFoso

    Pane {
        id: pane
        anchors.fill: parent

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            RowLayout {
                id: rowLayout2
                spacing: 30

                Layout.fillWidth: true

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Rectangle {
                    id: rectangle

                    Layout.alignment: Qt.AlignCenter

                    width: columnLayout1.width + 20
                    height: columnLayout1.height + 20

                    color.a: 0
                    border.color: "red"

                    ColumnLayout {
                        id: columnLayout1

                        anchors.centerIn: parent

                        Label {
                            id: label1
                            text: qsTr("Zona anoxica")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            font.styleName: "Bold"
                            font.pointSize: 16
                        }

                        RowLayout {
                            id: rowLayout1
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            spacing: 30

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorLvFoso
                                imageSize: 20
                                image.source: "../icons/HMISCPALv.svg"
                                textValueSubfix: "%"
                                titleText: "Lv foso"
                            }

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorPHAnox
                                imageSize: 20
                                image.source: "../icons/HMISCPALv.svg"
                                textValueSubfix: ""
                                titleText: "PH"
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle1

                    Layout.alignment: Qt.AlignCenter

                    width: columnLayout2.width + 20
                    height: columnLayout2.height + 20

                    color.a: 0
                    border.color: "red"

                    ColumnLayout {
                        id: columnLayout2

                        anchors.centerIn: parent

                        Label {
                            id: label
                            text: qsTr("Zona de aireación")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 16
                            font.styleName: "Bold"
                            Layout.fillWidth: true
                        }

                        RowLayout {
                            id: rowLayout
                            spacing: 30
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorTemp
                                imageSize: 15
                                textValueSubfix: "°C"
                                image.source: "../icons/HMISCPATemp.svg"
                                titleText: "T"
                            }

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorLvLodo
                                imageSize: 20
                                image.source: "../icons/HMISCPALv.svg"
                                textValueSubfix: "%"
                                titleText: "Lv lodo"
                            }

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorPHAireacion
                                imageSize: 20
                                image.source: "../icons/HMISCPALv.svg"
                                textValueSubfix: ""
                                titleText: "PH"
                            }

                            HMISCPAVariableIndicator {
                                id: hMISCPAVariableIndicatorOD
                                image.source: "../icons/HMISCPAOD.svg"
                                textValueSubfix: "mg/L"
                                titleText: "OD"
                            }
                        }
                    }
                }
            }

            Image {
                id: image
                source: "../process/HMISCPAPileta.svg"
                Layout.fillHeight: true
                Layout.fillWidth: true
                sourceSize.width: image.width
                sourceSize.height: image.height
                antialiasing: true
                fillMode: Image.PreserveAspectFit
            }

            RowLayout {
                id: rowLayout3
                Layout.fillWidth: true

                Button {
                    id: buttonDisconnect
                    text: qsTr("Desconectar")
                }

                Item {
                    id: item1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Button {
                    id: buttonSimulacion
                    text: qsTr("Simulacion")
                }

                Item {
                    id: item3
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Button {
                    id: buttonSopladores
                    text: qsTr("Sopladores")
                }

                Item {
                    id: item2
                    Layout.fillHeight: true
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
    D{i:0;autoSize:true;formeditorZoom:0.9;height:600;width:800}D{i:6}D{i:8}D{i:9}D{i:7}
D{i:5}D{i:4}D{i:12}D{i:14}D{i:15}D{i:16}D{i:17}D{i:13}D{i:11}D{i:10}D{i:3}D{i:18}
D{i:20}D{i:21}D{i:22}D{i:23}D{i:24}D{i:25}D{i:26}D{i:19}D{i:2}D{i:1}
}
##^##*/


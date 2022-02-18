import "../items"

import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias buttonVolver: buttonVolver
    property alias buttonParadaEmergencia: buttonParadaEmergencia
    property alias buttonSetLvFoso: buttonSetLvFoso
    property alias sliderLvFoso: sliderLvFoso

    Pane {
        id: pane
        anchors.fill: parent

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Label {
                id: label
                text: qsTr("Simulación")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: false
                font.pointSize: 24
                Layout.fillWidth: true
            }

            Item {
                id: item3
                Layout.fillHeight: true
                Layout.fillWidth: true

                ScrollView {
                    id: scrollView
                    anchors.fill: parent

                    ColumnLayout {
                        id: columnLayout1

                        Label {
                            id: label2
                            text: qsTr("Pileta zona anóxica")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 18
                            Layout.fillWidth: true
                        }

                        RowLayout {
                            id: rowLayoutLvFoso

                            Label {
                                id: label1
                                text: qsTr("Lv foso:")
                            }

                            Slider {
                                id: sliderLvFoso
                                stepSize: 1
                                to: 100
                                Layout.fillWidth: true
                                value: 10
                            }

                            Label {
                                id: label3
                                text: qsTr(sliderLvFoso.value + "%")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            Button {
                                id: buttonSetLvFoso
                                text: qsTr("Establecer")
                            }
                        }

                        RowLayout {
                            id: rowLayoutPHAnox
                            Label {
                                id: label4
                                text: qsTr("PH:")
                            }

                            Slider {
                                id: sliderPHAnox
                                stepSize: 0.1
                                Layout.fillWidth: true
                                value: 7
                                to: 14
                            }

                            Label {
                                id: label5
                                text: qsTr(sliderPHAnox.value + "")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Label {
                            id: label8
                            text: qsTr("Pileta zona aireación")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            font.pointSize: 18
                        }
                        RowLayout {
                            id: rowLayoutLvLodo
                            Label {
                                id: label6
                                text: qsTr("Nivel de lodo:")
                            }

                            Slider {
                                id: sliderLvLodo
                                stepSize: 1
                                Layout.fillWidth: true
                                value: 25
                                to: 100
                            }

                            Label {
                                id: label7
                                text: qsTr(sliderLvLodo.value + "%")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        RowLayout {
                            id: rowLayoutPHAireacion
                            Label {
                                id: label9
                                text: qsTr("PH:")
                            }

                            Slider {
                                id: sliderPHAireacion
                                stepSize: 0.1
                                Layout.fillWidth: true
                                value: 7
                                to: 14
                            }

                            Label {
                                id: label10
                                text: qsTr(sliderPHAireacion.value + "")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        RowLayout {
                            id: rowLayoutTemp
                            Label {
                                id: label11
                                text: qsTr("Temperatura:")
                            }

                            Slider {
                                id: sliderTemperatura
                                stepSize: 0.1
                                Layout.fillWidth: true
                                value: 24
                                to: 50
                            }

                            Label {
                                id: label12
                                text: qsTr(sliderTemperatura.value + "°C")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        RowLayout {
                            id: rowLayoutOD
                            Label {
                                id: label13
                                text: qsTr("Oxígeno disuelto:")
                            }

                            Slider {
                                id: sliderOD
                                stepSize: 0.01
                                Layout.fillWidth: true
                                value: 3.25
                                to: 6
                            }

                            Label {
                                id: label14
                                text: qsTr(sliderOD.value + "mg/L")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Label {
                            id: label15
                            text: qsTr("Soplador 1")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            font.pointSize: 18
                        }

                        RowLayout {
                            id: rowLayoutM01Velocidad
                            Label {
                                id: label16
                                text: qsTr("Velocidad:")
                            }

                            Slider {
                                id: sliderM01Velocidad
                                stepSize: 1
                                Layout.fillWidth: true
                                value: 25
                                to: 60
                            }

                            Label {
                                id: label17
                                text: qsTr(sliderM01Velocidad.value + "Hz")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Label {
                            id: label18
                            text: qsTr("Soplador 2")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            font.pointSize: 18
                        }

                        RowLayout {
                            id: rowLayoutM02Velocidad
                            Label {
                                id: label19
                                text: qsTr("Velocidad:")
                            }

                            Slider {
                                id: sliderM02Velocidad
                                stepSize: 1
                                Layout.fillWidth: true
                                value: 25
                                to: 60
                            }

                            Label {
                                id: label20
                                text: qsTr(sliderM02Velocidad.value + "Hz")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
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
    D{i:0;height:600;width:800}D{i:3}D{i:7}D{i:9}D{i:10}D{i:11}D{i:12}D{i:8}D{i:14}D{i:15}
D{i:16}D{i:13}D{i:17}D{i:19}D{i:20}D{i:21}D{i:18}D{i:23}D{i:24}D{i:25}D{i:22}D{i:27}
D{i:28}D{i:29}D{i:26}D{i:31}D{i:32}D{i:33}D{i:30}D{i:34}D{i:36}D{i:37}D{i:38}D{i:35}
D{i:39}D{i:41}D{i:42}D{i:43}D{i:40}D{i:6}D{i:5}D{i:4}D{i:45}D{i:46}D{i:47}D{i:44}
D{i:2}D{i:1}
}
##^##*/


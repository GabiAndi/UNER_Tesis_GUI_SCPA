import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts

import "../items"

Item {
    property alias buttonVolver: buttonVolver
    property alias buttonParadaEmergencia: buttonParadaEmergencia

    property alias dataSeriesOD: dataSeriesOD
    property alias dataSeriesRPM: dataSeriesRPM

    property alias dataSeriesRPMKp: dataSeriesRPMKp
    property alias dataSeriesRPMKd: dataSeriesRPMKd
    property alias dataSeriesRPMKi: dataSeriesRPMKi

    property alias buttonKi: buttonKi
    property alias buttonKd: buttonKd
    property alias buttonKp: buttonKp

    property alias sliderKp: sliderKp
    property alias sliderKd: sliderKd
    property alias sliderKi: sliderKi

    Pane {
        id: pane
        anchors.fill: parent

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Label {
                id: label
                text: qsTr("Configuración del controlador")
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

                ChartView {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    antialiasing: true
                    animationOptions: ChartView.NoAnimation
                    theme: ChartView.ChartThemeDark

                    ValueAxis {
                        id: axisXOD

                        min: 0
                        max: 60
                    }

                    ValueAxis {
                        id: axisYOD

                        min: 0
                        max: 4
                    }

                    AreaSeries {
                        name: "OD"

                        color: "blue"

                        axisX: axisXOD
                        axisY: axisYOD

                        upperSeries: LineSeries {
                            id: dataSeriesOD
                        }
                    }
                }

                ChartView {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    antialiasing: true
                    animationOptions: ChartView.NoAnimation
                    theme: ChartView.ChartThemeDark

                    ValueAxis {
                        id: axisXRPM

                        min: 0
                        max: 60
                    }

                    ValueAxis {
                        id: axisYRPM

                        min: -3500
                        max: 3500
                    }

                    LineSeries {
                        id: dataSeriesRPM

                        name: "RPM"

                        color: "orange"

                        axisX: axisXRPM
                        axisY: axisYRPM

                        width: 2.5
                    }

                    LineSeries {
                        id: dataSeriesRPMKp

                        name: "Acción proporcional"

                        color: "red"

                        axisX: axisXRPM
                        axisY: axisYRPM

                        width: 2.5
                    }

                    LineSeries {
                        id: dataSeriesRPMKd

                        name: "Acción derivativa"

                        color: "yellow"

                        axisX: axisXRPM
                        axisY: axisYRPM

                        width: 2.5
                    }

                    LineSeries {
                        id: dataSeriesRPMKi

                        name: "Acción integral"

                        color: "green"

                        axisX: axisXRPM
                        axisY: axisYRPM

                        width: 2.5
                    }
                }
            }

            ColumnLayout {
                id: columnLayout2

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Layout.fillWidth: true
                Layout.fillHeight: true

                RowLayout {
                    id: rowLayout3

                    Label {
                        id: label1

                        text: "Kp:"

                        color: "white"
                    }

                    Slider {
                        id: sliderKp
                        Layout.fillWidth: true
                        to: 20
                        from: 1
                        value: 10
                    }

                    Label {
                        id: label2

                        text: qsTr(sliderKp.value.toPrecision(3) + "")

                        color: "white"
                    }

                    Button {
                        id: buttonKp
                        text: qsTr("Establecer")
                    }
                }

                RowLayout {
                    id: rowLayout4

                    Label {
                        id: label3
                        color: "#ffffff"
                        text: "Kd:"
                    }

                    Slider {
                        id: sliderKd
                        Layout.fillWidth: true
                        value: 0.01
                        to: 10
                        from: 0.01
                    }

                    Label {
                        id: label4
                        color: "#ffffff"
                        text: qsTr(sliderKd.value.toPrecision(2) + "")
                    }

                    Button {
                        id: buttonKd
                        text: qsTr("Establecer")
                    }
                }

                RowLayout {
                    id: rowLayout5

                    Label {
                        id: label5
                        color: "#ffffff"
                        text: "Ki:"
                    }

                    Slider {
                        id: sliderKi
                        Layout.fillWidth: true
                        value: 0.01
                        to: 2
                        from: 0.01
                    }

                    Label {
                        id: label6
                        color: "#ffffff"
                        text: qsTr(sliderKi.value.toPrecision(2) + "")
                    }

                    Button {
                        id: buttonKi
                        text: qsTr("Establecer")
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
    D{i:0;autoSize:true;height:600;width:800}D{i:3}D{i:6}D{i:7}D{i:8}D{i:5}D{i:11}D{i:12}
D{i:13}D{i:14}D{i:15}D{i:16}D{i:10}D{i:4}D{i:19}D{i:20}D{i:21}D{i:22}D{i:18}D{i:24}
D{i:25}D{i:26}D{i:27}D{i:23}D{i:29}D{i:30}D{i:31}D{i:32}D{i:28}D{i:17}D{i:34}D{i:35}
D{i:36}D{i:33}D{i:2}D{i:1}
}
##^##*/


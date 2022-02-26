import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: itemTop

    // Propiedades
    // Label de título
    property string titleText: "M01"
    property int titleTextPointSize: 16

    // Imagen
    property real imageSize: 50

    // Estados
    property bool motorOn: false
    property bool motorFail: false

    // Variables
    property alias hMICircularProgressBarCorriente: hMICircularProgressBarCorriente
    property alias hMICircularProgressBarVoltaje: hMICircularProgressBarVoltaje
    property alias hMICircularProgressBarVelocidad: hMICircularProgressBarVelocidad

    Rectangle {
        id: tube

        color.a: 0

        border.color: "white"
        radius: 3
        border.width: 3

        Layout.alignment: Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.topMargin: 45

        height: 20

        onWidthChanged: {
            animationWater.restart();
        }

        Rectangle {
            id: water

            visible: itemTop.motorOn

            color: "#ff6bbdff"

            x: parent.width - width

            width: 15
            height: parent.height

            z: -1

            SequentialAnimation on x {
                id: animationWater

                running: itemTop.motorOn
                loops: Animation.Infinite

                PropertyAnimation {
                    to: 0

                    duration: 10 * (100000 / tube.width + tube.width)
                }
            }
        }
    }

    ColumnLayout {
        Label {
            text: itemTop.titleText

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: itemTop.titleTextPointSize

            Layout.alignment: Qt.AlignCenter
        }

        Image {
            id: image

            width: itemTop.imageSize
            height: itemTop.imageSize

            Layout.alignment: Qt.AlignCenter

            sourceSize.width: itemTop.imageSize
            sourceSize.height: itemTop.imageSize

            fillMode: Image.PreserveAspectFit

            source: itemTop.motorOn ? "../icons/HMISCPASopladorOn.svg" : "../icons/HMISCPASopladorOff.svg"

            SequentialAnimation on source {
                loops: Animation.Infinite
                running: itemTop.motorFail

                PropertyAnimation {
                    to: "../icons/HMISCPASopladorFail.svg"
                    duration: 2000
                }

                PropertyAnimation {
                    to: "../icons/HMISCPASopladorOff.svg"
                    duration: 2000
                }
            }
        }
    }

    Item {
        width: 20
    }

    HMICircularProgressBar {
        id: hMICircularProgressBarCorriente

        titleText: "I"
        textValueSubfix: "A"

        maximumValue: 100
    }

    HMICircularProgressBar {
        id: hMICircularProgressBarVoltaje

        titleText: "V"
        textValueSubfix: "V"

        maximumValue: 500
    }

    HMICircularProgressBar {
        id: hMICircularProgressBarVelocidad

        titleText: "Vel"
        textValueSubfix: "Hz"

        maximumValue: 60
    }
}

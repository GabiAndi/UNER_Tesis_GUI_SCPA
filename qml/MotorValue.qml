import QtQuick                      2.12
import QtQuick.Controls             2.12
import QtQuick.Layouts              1.12
import QtGraphicalEffects           1.0

ColumnLayout {
    id: layout

    // Propiedades
    property real paddingCircle: 4
    property real paddingImage: 16
    property real imageSize: 80

    property color motorColor: "white"

    property string nombreMotor: "M01"
    property int nombreMotorPointSize: 16

    // Eventos
    onMotorColorChanged: canvas.requestPaint()

    Label {
        id: labelTitle

        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        text: layout.nombreMotor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: layout.nombreMotorPointSize
    }

    Canvas {
        id: canvas

        antialiasing: true

        // Tamaño
        width: layout.imageSize
        height: layout.imageSize

        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

        onPaint: {
            var ctx = getContext("2d");

            ctx.save();

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Se dibuja el circulo que envuelve al motor
            ctx.beginPath();

            ctx.lineWidth = 2;
            ctx.strokeStyle = layout.motorColor;
            ctx.arc(canvas.width / 2,
                    canvas.height / 2,
                    (layout.imageSize - layout.paddingCircle) / 2,
                    0,
                    Math.PI * 2);

            ctx.stroke();

            ctx.restore();
        }

        Image {
            id: image

            width: parent.width - layout.paddingCircle - layout.paddingImage
            height: parent.height - layout.paddingCircle - layout.paddingImage

            anchors.centerIn: parent

            source: "qrc:/images/motor.png"

            smooth: true
            visible: false
        }

        ColorOverlay {
            anchors.fill: image
            source: image
            color: layout.motorColor
        }
    }
}

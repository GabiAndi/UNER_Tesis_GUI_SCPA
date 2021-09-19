import QtQuick                      2.12
import QtQuick.Controls             2.12
import QtQuick.Layouts              1.12

ColumnLayout {
    id: layout

    // Propiedades
    // Label de título
    property string titleText: "Título"
    property int titleTextPointSize: 16

    // Circle progress bar
    property int progressBarSize: 90

    property real minimumValue: 0
    property real maximumValue: 100
    property real currentValue: 50

    property color valueColor: "red"
    property color noValueColor: "white"
    property color textValueColor: "white"

    property real valueScale: 1.8

    // Eventos
    onProgressBarSizeChanged: canvas.requestPaint()
    onTitleTextChanged: canvas.requestPaint()

    onMinimumValueChanged: canvas.requestPaint()
    onMaximumValueChanged: canvas.requestPaint()
    onCurrentValueChanged: canvas.requestPaint()

    onValueColorChanged: canvas.requestPaint()
    onTextValueColorChanged: canvas.requestPaint()
    onNoValueColorChanged: canvas.requestPaint()

    Label {
        id: labelTitle

        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        text: layout.titleText

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: layout.titleTextPointSize
    }

    Canvas {
        id: canvas

        antialiasing: true

        width: layout.progressBarSize
        height: layout.progressBarSize

        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

        // Ubicación
        property real padding: 10

        property real centerWidth: width / 2
        property real centerHeight: height / 2
        property real size: Math.min(width - padding, height - padding)
        property real radius: size / 2

        // Angulo que determina la división entre los dos colores
        property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

        // Desplazamiento de inicio
        property real angleOffset: Math.PI / 2

        onPaint: {
            var ctx = getContext("2d");

            ctx.save();

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // El primer arco es mas delgado
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.strokeStyle = layout.noValueColor;
            ctx.arc(canvas.centerWidth,
                    canvas.centerHeight,
                    canvas.radius,
                    canvas.angleOffset + canvas.angle,
                    canvas.angleOffset + 2 * Math.PI);
            ctx.stroke();


            // El segundo arco es mas grueso
            ctx.beginPath();
            ctx.lineWidth = 3;
            ctx.strokeStyle = layout.valueColor;
            ctx.arc(canvas.centerWidth,
                    canvas.centerHeight,
                    canvas.radius,
                    canvas.angleOffset,
                    canvas.angleOffset + canvas.angle);
            ctx.stroke();

            ctx.restore();
        }

        Label {
            id: labelCurrentValue

            anchors.centerIn: parent

            text: layout.currentValue

            font.pixelSize: canvas.size * layout.valueScale / 10
            color: layout.textValueColor
        }
    }
}

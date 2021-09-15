import QtQuick                      2.12

Canvas {
    id: canvas

    // Pading
    property real padding: 10

    width: 240
    height: 240

    antialiasing: true

    // Propiedades que se pueden cambiar
    property color primaryColor: "orange"
    property color secondaryColor: "lightblue"
    property color valueColor: "orange"

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real size: Math.min(width - padding, height - padding)
    property real radius: size / 2

    property real minimumValue: 0
    property real maximumValue: 100
    property real currentValue: 33

    property real valueScale: 8

    // Angulo que determina la división entre los dos colores
    property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

    // Desplazamiento de inicio
    property real angleOffset: Math.PI / 2

    // Eventos
    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onValueColorChanged: requestPaint()
    onMinimumValueChanged: requestPaint()
    onMaximumValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");

        ctx.save();

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // El primer arco es mas delgado
        ctx.beginPath();
        ctx.lineWidth = 1;
        ctx.strokeStyle = canvas.primaryColor;
        ctx.arc(canvas.centerWidth,
                canvas.centerHeight,
                canvas.radius,
                angleOffset + canvas.angle,
                angleOffset + 2 * Math.PI);
        ctx.stroke();


        // El segundo arco es mas grueso
        ctx.beginPath();
        ctx.lineWidth = 3;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth,
                canvas.centerHeight,
                canvas.radius,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angle);
        ctx.stroke();

        ctx.restore();
    }

    Text {
        anchors.centerIn: parent

        text: canvas.currentValue

        font.pixelSize: size * valueScale / 10
        color: canvas.valueColor
    }
}

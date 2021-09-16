import QtQuick                      2.12
import QtQuick.Controls             2.12
import QtQuick.Layouts              1.12

Canvas {
    id: canvas

    // Tamaño
    width: 700
    height: 350

    // Propiedades
    property color lineColor: "#CCCCCC"

    // Propiedades de dibujo
    property real grillaPosInicial: width * (1/4 + 2/8);
    property real grillaPosFinal: width * (24/25);

    property real grillaPosFondo: height * (15/16);

    property real grillaDifusoresLimite: grillaPosFinal - grillaPosInicial;
    property real grillaDifusoresCantidad: 10;

    onPaint: {
        var ctx = getContext("2d");

        ctx.save();

        // Se borra el contenido
        ctx.clearRect(0, 0, canvas.height, canvas.width);

        // Recuadro de la pileta
        ctx.beginPath();
        ctx.lineWidth = 5;
        ctx.strokeStyle = canvas.lineColor;

        ctx.roundedRect(0, 0, canvas.width, canvas.height, 0, 0);

        ctx.stroke();

        // Triangulo del clarificador
        ctx.beginPath();
        ctx.lineWidth = 3;
        ctx.strokeStyle = canvas.lineColor;

        ctx.moveTo(canvas.width * (1/4 - 1/8), 0);
        ctx.lineTo(canvas.width * (1/4), canvas.height * (3/4));

        ctx.moveTo(canvas.width * (1/4 + 2/8), 0);
        ctx.lineTo(canvas.width * (1/4 + 1/10), canvas.height * (15/16));

        ctx.stroke();

        // Grilla de difusores
        ctx.beginPath();
        ctx.lineWidth = 3;
        ctx.strokeStyle = canvas.lineColor;

        ctx.moveTo(canvas.grillaPosInicial, canvas.grillaPosFondo);
        ctx.lineTo(canvas.grillaPosFinal, canvas.grillaPosFondo);

        for (var i = 0 ; i <= canvas.grillaDifusoresCantidad ; i++) {
            var desplazamiento = (i / canvas.grillaDifusoresCantidad) * canvas.grillaDifusoresLimite;

            ctx.moveTo(canvas.grillaPosInicial + desplazamiento, canvas.grillaPosFondo);
            ctx.lineTo(canvas.grillaPosInicial + desplazamiento, canvas.height);
        }

        ctx.stroke();

        ctx.restore();
    }

    ColumnLayout {
        width: canvas.grillaDifusoresLimite
        height: canvas.height / 4

        x: canvas.grillaPosInicial
        y: canvas.height / 4

        Label {
            Layout.alignment: Qt.AlignHCenter

            text: "Nivel OD"

            font.pointSize: 16
        }

        ProgressBarCircular {
            id: progressBarNivelOD

            width: 70
            height: 70

            Layout.alignment: Qt.AlignHCenter

            primaryColor: "white"
            secondaryColor: window.accentColor
            valueColor: "white"

            valueScale: 1.9

            maximumValue: 100

            currentValue: 50
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/

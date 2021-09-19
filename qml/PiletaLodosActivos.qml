import QtQuick                      2.12
import QtQuick.Controls             2.12
import QtQuick.Layouts              1.12

Canvas {
    id: canvas

    antialiasing: true

    // Tamaño
    width: 700
    height: 350

    // Propiedades
    property color lineColor: "#CCCCCC"

    // Propiedades de dibujo
    property real clarificadorPosInicial: canvas.width * (1/4 - 1/8)

    property real grillaPosInicial: width * (1/4 + 2/8)
    property real grillaPosFinal: width * (24/25)

    property real grillaPosFondo: height * (15/16)

    property real grillaDifusoresLimite: grillaPosFinal - grillaPosInicial
    property real grillaDifusoresCantidad: 10

    // Tamaño de los progress bar
    property int variableProgressBarSize: grillaDifusoresLimite * (1/5)

    // Eventos
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()

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

        ctx.moveTo(canvas.clarificadorPosInicial, 0);
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

    // Motor de zona anoxica
    MotorValue {
        x: canvas.clarificadorPosInicial * (1/6)
        y: canvas.height * (5/7)

        nombreMotor: "P70-M03"
    }

    // Motor de aireación
    MotorValue {
        x: canvas.grillaPosInicial + (canvas.grillaPosFinal - canvas.grillaPosInicial - width) / 2
        y: canvas.grillaPosFondo + height * (1/3)

        nombreMotor: "P70-M01"
    }

    RowLayout {
        x: canvas.grillaPosInicial
        y: canvas.height / 4

        VariableProgressBar {
            id: nivelOD

            progressBarSize: variableProgressBarSize

            titleText: "OD"
        }

        VariableProgressBar {
            id: nivelPH

            progressBarSize: variableProgressBarSize

            titleText: "PH"
        }

        VariableProgressBar {
            id: nivelLodo

            progressBarSize: variableProgressBarSize

            titleText: "Lodo"
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50";formeditorZoom:1.75}
}
##^##*/

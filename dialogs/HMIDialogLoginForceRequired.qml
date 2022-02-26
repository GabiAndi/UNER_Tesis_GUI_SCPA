import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Otro usuario ya conectado"
    standardButtons: Dialog.No | Dialog.Yes

    ColumnLayout {
        Label {
            text: "Otro usuario ya se encuentra conectado al sistema."
        }

        Label {
            text: "¿Desea iniciar sesión de todos modos?"
        }

        Label {
            text: "ATENCION: esto cerrará la sesión del otro usuario."

            color: Material.accent
        }
    }
}

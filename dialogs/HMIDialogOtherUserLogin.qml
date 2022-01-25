import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Otro usuario inició sesión"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "Otro usuario se conecto desde otro dispositivo."
        }

        Label {
            text: "Esto causó que la conexión se cierre."
        }
    }
}

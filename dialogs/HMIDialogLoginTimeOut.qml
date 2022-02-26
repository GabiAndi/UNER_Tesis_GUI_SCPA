import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Error de inicio de sesión"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "Se expiró el tiempo para iniciar sesión desde este dispositivo."
        }
    }
}

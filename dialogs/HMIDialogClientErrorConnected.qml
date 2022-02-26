import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Error al conectarse con el servidor"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "No se pudo cominicar con el servidor por un error de red."
        }
    }
}

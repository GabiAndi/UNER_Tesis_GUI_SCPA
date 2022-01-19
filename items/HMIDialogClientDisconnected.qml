import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Se cerro la conexión"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "Se cerro la conexión con el controlador."
        }
    }
}

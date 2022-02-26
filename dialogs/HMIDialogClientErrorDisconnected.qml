import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Error de conexión con el servidor"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "La conexión con el servidor se cerro inesperadamente."
        }
    }
}

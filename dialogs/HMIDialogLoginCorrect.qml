import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialogTop

    property string userName: "userName"

    anchors.centerIn: parent

    parent: Overlay.overlay

    modal: true
    title: "Login correcto"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "El inicio de sesión fue correcto."
        }

        Label {
            text: "Bienvenido " + userName + "."
        }
    }
}

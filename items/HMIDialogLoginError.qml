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
    title: "Error de inicio de sesión"
    standardButtons: Dialog.Ok

    ColumnLayout {
        Label {
            text: "No se puedo iniciar sesión como " + userName + "."
        }

        Label {
            text: "Se puede deber a un error de usuario o contraseña."
        }
    }
}

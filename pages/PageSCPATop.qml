import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard

import "../items"

Item {
    id: itemTop

    Pane {
        width: parent.width
        height: parent.height

        HMIButton {
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            text: "Cerrar"

            onPressed: {
                guiSCPAManager.disconnectToServer();
            }
        }
    }
}

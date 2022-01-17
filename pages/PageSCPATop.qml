import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard

import "../items"

Item {
    Label {
        font.pointSize: 40

        text: "XD"
    }

    HMIButton {
        text: "Cerrar"

        onPressed: {
            guiSCPAManager.disconnectToServer();
        }
    }
}

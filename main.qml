import QtQuick
import QtQuick.Controls.Material
import QtQuick.VirtualKeyboard

import GUISCPA

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    GUISCPAManager {
        id: guiSCPAManager

        onServerIPChanged: {
            console.log("AHRE");
        }
    }

    Column {
        width: parent.width
        height: parent.height

        Text {
            id: text
            text: qsTr(guiSCPAManager.serverIP)

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Precioname"

            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                guiSCPAManager.serverIP = "Me apretaste";
            }
        }
    }
}

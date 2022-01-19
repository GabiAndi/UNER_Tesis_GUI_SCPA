import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import "../items"

Item {
    id: itemTop

    Pane {
        width: parent.width
        height: parent.height

        ColumnLayout {
            anchors.centerIn: parent

            Label {
                Layout.alignment: Qt.AlignCenter

                text: "Conectando al sistema de control"
                font.pointSize: 24
            }

            Item {
                width: 100
                height: 100

                Layout.alignment: Qt.AlignCenter

                BusyIndicator {
                    anchors.fill: parent
                }
            }

            HMIButton {
                Layout.alignment: Qt.AlignCenter

                text: "Cancelar"

                onClicked: {
                    guiSCPAManager.hmiDisconnect();
                }
            }
        }
    }
}

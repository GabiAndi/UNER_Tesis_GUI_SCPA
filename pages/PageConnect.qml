import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard

import "../items"

Item {
    id: itemTop

    property string serverIP: textFieldServerIP.text
    property string serverPort: textFieldServerPort.text

    Pane {
        width: parent.width
        height: parent.height

        ColumnLayout {
            anchors.centerIn: parent

            Label {
                Layout.alignment: Qt.AlignHCenter

                text: "Conectar al sistema"
                font.pointSize: 32
            }

            Item {
                height: 20
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "Dirección:"
                    font.pointSize: 14
                }

                TextField {
                    id: textFieldServerIP

                    horizontalAlignment: Text.AlignHCenter

                    placeholderText: "192.168.0.100"
                    text: "127.0.0.1"

                    inputMethodHints: Qt.ImhPreferNumbers

                    EnterKeyAction.actionId: EnterKeyAction.Next

                    onAccepted: {
                        textFieldServerPort.focus = true;
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "Puerto:"
                    font.pointSize: 14
                }

                TextField {
                    id: textFieldServerPort

                    horizontalAlignment: Text.AlignHCenter

                    placeholderText: "33600"
                    text: "33600"

                    inputMethodHints: Qt.ImhPreferNumbers

                    EnterKeyAction.actionId: EnterKeyAction.Next

                    onAccepted: {
                        textFieldServerPort.focus = false;

                        buttonConnect.clicked();
                    }
                }
            }

            Item {
                height: 10
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                HMIButton {
                    id: buttonClose

                    text: "Cerrar"

                    onClicked: {
                        Qt.exit(0);
                    }
                }

                HMIButton {
                    id: buttonConnect

                    text: "Conectar"

                    onClicked: {
                        guiSCPAManager.connectToServer(textFieldServerIP.text, textFieldServerPort.text);
                    }
                }
            }
        }
    }
}

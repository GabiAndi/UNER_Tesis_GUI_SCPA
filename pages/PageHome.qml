import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard

import "../items"

Item {
    id: itemTop

    property bool connecting: false

    property string userName: textFieldUserName.text
    property string password: textFieldPassword.text

    Pane {
        width: parent.width
        height: parent.height

        Layout.alignment: Qt.AlignCenter

        ColumnLayout {
            anchors.centerIn: parent

            Label {
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
                        textFieldUserName.focus = true;
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "Usuario:"
                    font.pointSize: 14
                }

                TextField {
                    id: textFieldUserName

                    horizontalAlignment: Text.AlignHCenter

                    placeholderText: "usuario"
                    text: "gabi"

                    inputMethodHints: Qt.ImhPreferLowercase

                    EnterKeyAction.actionId: EnterKeyAction.Next

                    onAccepted: {
                        textFieldPassword.focus = true;
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "Contraseña:"
                    font.pointSize: 14
                }

                TextField {
                    id: textFieldPassword

                    horizontalAlignment: Text.AlignHCenter

                    text: "0123456789"

                    echoMode: TextField.Password

                    EnterKeyAction.actionId: EnterKeyAction.Done

                    onAccepted: {
                        this.focus = false;
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

                    enabled: !itemTop.connecting

                    onClicked: {
                        guiSCPAManager.connectToServer(textFieldServerIP.text, textFieldServerPort.text);

                        itemTop.connecting = true;
                    }
                }
            }
        }
    }
}

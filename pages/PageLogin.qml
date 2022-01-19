import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard

import "../items"

Item {
    id: itemTop

    property string userName: textFieldUserName.text
    property string password: textFieldPassword.text

    Pane {
        width: parent.width
        height: parent.height

        ColumnLayout {
            anchors.centerIn: parent

            Label {
                Layout.alignment: Qt.AlignHCenter

                text: "Iniciar sesión"
                font.pointSize: 32
            }

            Item {
                height: 20
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "Nombre de usuario:"
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

                    placeholderText: "contraseña"
                    text: "0123456789"

                    echoMode: TextField.PasswordEchoOnEdit

                    EnterKeyAction.actionId: EnterKeyAction.Done

                    onAccepted: {
                        textFieldPassword.focus = false;

                        buttonLogin.clicked();
                    }
                }
            }

            Item {
                height: 10
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                HMIButton {
                    text: "Desconectar"

                    onClicked: {
                        guiSCPAManager.hmiDisconnect();
                    }
                }

                HMIButton {
                    id: buttonLogin

                    text: "Iniciar sesión"

                    onClicked: {
                        guiSCPAManager.sendLogin(textFieldUserName.text, textFieldPassword.text);
                    }
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Styles
import QtQuick.VirtualKeyboard.Settings

import GUISCPA

Window {
    id: window

    // Resolucion de pantalla
    width: 800
    height: 480

    // Modo de pantalla
    visible: true
    //visibility: Window.FullScreen

    // Tema
    property int themeStyle: Material.Dark

    property int accentColor: Material.Red
    property int primaryColor: Material.Red

    property color backgroundColor: "#2F2F2F"

    property int elevation: 0

    Material.theme: themeStyle
    Material.accent: accentColor
    Material.primary: primaryColor
    Material.elevation: elevation

    color: backgroundColor

    title: "Control de usuario"

    GUISCPAManager {
        id: guiSCPAManager

        // Conexion con el servidor correcta
        onClientConnected: {
            guiSCPAManager.sendLogin(textFieldUser.text, textFieldPassword.text);
        }

        // Conexion con el servidor fallida por problemas de red
        onClientFailConnected: {

        }

        // Conexion correcta, logeo correcto
        onClientLoginConnected: {
            stackLayout.currentIndex = 1;
        }

        // Conexion con el servidor erronea por logeo incorrecto
        onClientErrorConnected: {

        }

        // Conexion con el servidor erronea por usuario ocupado
        onClientBusyConnected: {

        }

        // Conexion con el servidor erronea por dejar la sesion activa
        onClientPassConnected: {

        }

        // Conexion con el servidor erronea por error desconocido
        onClientUndefinedErrorConnected: {

        }

        // Conexion con el servidor desconectada
        onClientDisconnected:
        {

        }
    }

    StackLayout {
        id: stackLayout

        width: window.width
        height: window.height

        Layout.alignment: Qt.AlignCenter

        currentIndex: 0

        Item {
            width: stackLayout.width
            height: stackLayout.height

            Layout.alignment: Qt.AlignCenter

            ColumnLayout {
                anchors.centerIn: parent

                Label {
                    Layout.alignment: Qt.AlignHCenter

                    text: "Conectar al sistema"
                    font.pointSize: 32
                }

                Item {
                    height: 20

                    Layout.alignment: Qt.AlignHCenter
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        Layout.alignment: Qt.AlignVCenter

                        text: "Dirección:"
                        font.pointSize: 14
                    }

                    TextField {
                        id: textFieldServerIP

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

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
                        Layout.alignment: Qt.AlignVCenter

                        text: "Puerto:"
                        font.pointSize: 14
                    }

                    TextField {
                        id: textFieldServerPort

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "33600"
                        text: "33600"

                        inputMethodHints: Qt.ImhPreferNumbers

                        EnterKeyAction.actionId: EnterKeyAction.Next

                        onAccepted: {
                            textFieldUser.focus = true;
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        Layout.alignment: Qt.AlignVCenter

                        text: "Usuario:"
                        font.pointSize: 14
                    }

                    TextField {
                        id: textFieldUser

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

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
                        Layout.alignment: Qt.AlignVCenter

                        text: "Contraseña:"
                        font.pointSize: 14
                    }

                    TextField {
                        id: textFieldPassword

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "contraseña"
                        text: "0123456789"

                        inputMethodHints: Qt.ImhPreferLowercase

                        EnterKeyAction.actionId: EnterKeyAction.Next

                        onAccepted: {
                            textFieldPassword.focus = false;

                            buttonConnect.clicked();
                        }
                    }
                }

                Item {
                    height: 10

                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    id: buttonConnect

                    horizontalPadding: 20
                    verticalPadding: 15

                    Layout.alignment: Qt.AlignHCenter

                    text: "Conectar"
                    font.pointSize: 16

                    onClicked: {
                        // Conectar
                        guiSCPAManager.connectToServer(textFieldServerIP.text, textFieldServerPort.text);
                    }
                }
            }
        }

        Item {
            width: stackLayout.width
            height: stackLayout.height

            Layout.alignment: Qt.AlignCenter

            ColumnLayout {
                anchors.centerIn: parent

                Label {
                    Layout.alignment: Qt.AlignHCenter

                    text: "Logeo correcto"
                    font.pointSize: 32
                }
            }
        }
    }
}

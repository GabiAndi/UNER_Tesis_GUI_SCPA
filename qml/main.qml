import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Styles
import QtQuick.VirtualKeyboard.Settings

import SCPA.HMIManager

Window {
    id: window

    // Resolución de la pantalla touch
    width: 1024
    height: 600

    // Modo full screen
    visible: true
    //visibility: Qt.WindowFullScreen | Qt.Window

    // Tema
    property color backgroundColor: "#2F2F2F"
    property color accentColor: "red"

    color: window.backgroundColor
    Material.accent: window.accentColor

    HMIManager {
        id: hmiManager
    }

    StackLayout {
        id: stackLayout

        width: parent.width
        height: parent.height

        Layout.alignment: Qt.AlignCenter

        currentIndex: 0

        Item {
            id: pageConnect

            width: parent.width
            height: parent.height

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
                        id: textAreaIP

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "192.168.0.100"
                        text: "10.0.0.100"

                        inputMethodHints: Qt.ImhPreferNumbers

                        EnterKeyAction.actionId: EnterKeyAction.Next
                        onAccepted: {
                            textAreaPuerto.focus = true;
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
                        id: textAreaPuerto

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "33600"
                        text: "33600"

                        inputMethodHints: Qt.ImhPreferNumbers
                        onAccepted: {
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
                        //hmiManager.serverConnect(textAreaIP.text, textAreaPuerto.text);

                        stackLayout.currentIndex = 1;
                    }
                }
            }

            Button {
                id: buttonClose

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                anchors.margins: 20
                horizontalPadding: 20
                verticalPadding: 15

                text: "Salir"
                font.pointSize: 16

                onClicked: {
                    Qt.quit();
                }
            }
        }

        Item {
            id: pageTratamientoBiologico

            width: parent.width
            height: parent.height

            Label {
                width: parent.width
                height: parent.height

                text: "Tratamiento biológico"
                font.pointSize: 34

                topPadding: 16

                horizontalAlignment: Text.Center
                verticalAlignment: Text.AlignTop
            }

            PiletaLodosActivos {
                width: parent.width - 300
                height: parent.height - 300

                anchors.centerIn: parent
            }

            Button {
                id: buttonDisconnect

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                anchors.margins: 20
                horizontalPadding: 20
                verticalPadding: 15

                text: "Desconectar"
                font.pointSize: 16

                onClicked: {
                    stackLayout.currentIndex = 0;
                }
            }

            Button {
                id: buttonPageMotores

                anchors.right: parent.right
                anchors.bottom: parent.bottom

                anchors.margins: 20
                horizontalPadding: 20
                verticalPadding: 15

                text: "Motores"
                font.pointSize: 16

                onClicked: {
                    stackLayout.currentIndex = 2;
                }
            }
        }

        Item {
            id: pageMotores

            width: parent.width
            height: parent.height

            RowLayout {
                anchors.centerIn: parent

                VariableProgressBar {
                    titleText: "PM70-M01"

                    titleTextPointSize: 34

                    progressBarSize: 300
                }

                VariableProgressBar {
                    titleText: "PM70-M02"

                    titleTextPointSize: 34

                    progressBarSize: 300

                    currentValue: 0
                }
            }

            Button {
                id: buttonPageTratamientoBiolgico

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                anchors.margins: 20
                horizontalPadding: 20
                verticalPadding: 15

                text: "Biológico"
                font.pointSize: 16

                onClicked: {
                    stackLayout.currentIndex = 1;
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/

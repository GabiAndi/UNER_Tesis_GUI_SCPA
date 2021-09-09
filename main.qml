import QtQuick                      2.15
import QtQuick.Window               2.15
import QtQuick.Controls             2.12
import QtQuick.Controls.Material    2.12
import QtQuick.Layouts              1.12

import SCPA.HMIManager              1.0

Window {
    id: window

    // Resolución de la pantalla touch
    width: 1024
    height: 600

    // Modo full screen
    visible: true
    visibility: Qt.WindowFullScreen | Qt.Window
    flags: Qt.FramelessWindowHint

    title: "HMI SCPA"

    // Tema
    property color backgroundColor: "#2F2F2F"
    property color accentColor: "#FF1D00"

    Material.theme: Material.Dark
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

        currentIndex: 1

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

                    TextArea {
                        id: textAreaIP

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "192.168.0.100"
                        text: "10.0.0.100"
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        Layout.alignment: Qt.AlignVCenter

                        text: "Puerto:"
                        font.pointSize: 14
                    }

                    TextArea {
                        id: textAreaPuerto

                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignVCenter

                        placeholderText: "33600"
                        text: "33600"
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
                        hmiManager.serverConnect(textAreaIP.text, textAreaPuerto.text)
                    }
                }
            }
        }

        Item {
            id: pageTratamientoBiologico

            width: parent.width
            height: parent.height

            Layout.alignment: Qt.AlignCenter

            ColumnLayout {
                width: parent.width
                height: parent.height

                Layout.alignment: Qt.AlignCenter

                RowLayout {
                    width: parent.width

                    Layout.alignment: Qt.AlignCenter

                    Item {
                        width: 10

                        Layout.alignment: Qt.AlignVCenter
                    }

                    ProgressBarCircular {
                        width: 125
                        height: 125

                        primaryColor: "white"
                        secondaryColor: window.accentColor
                        textColor: "white"

                        text: "OD"
                    }

                    Item {
                        width: 10

                        Layout.alignment: Qt.AlignVCenter
                    }

                    ProgressBarCircular {
                        width: 125
                        height: 125

                        primaryColor: "white"
                        secondaryColor: window.accentColor
                        textColor: "white"

                        text: "OD"
                    }

                    Item {
                        width: 10

                        Layout.alignment: Qt.AlignVCenter
                    }

                    ProgressBarCircular {
                        width: 125
                        height: 125

                        primaryColor: "white"
                        secondaryColor: window.accentColor
                        textColor: "white"

                        text: "OD"
                    }

                    Item {
                        width: 10

                        Layout.alignment: Qt.AlignVCenter
                    }

                    ProgressBarCircular {
                        width: 125
                        height: 125

                        primaryColor: "white"
                        secondaryColor: window.accentColor
                        textColor: "white"

                        text: "OD"
                    }

                    Item {
                        width: 10

                        Layout.alignment: Qt.AlignVCenter
                    }

                    ProgressBarCircular {
                        width: 125
                        height: 125

                        primaryColor: "white"
                        secondaryColor: window.accentColor
                        textColor: "white"

                        text: "OD"
                    }
                }
            }
        }
    }
}

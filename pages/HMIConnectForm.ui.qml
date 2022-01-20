import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias buttonConnect: buttonConnect
    property alias buttonClose: buttonClose
    property alias textFieldServerPort: textFieldServerPort
    property alias textFieldServerIP: textFieldServerIP

    Pane {
        id: pane
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        ColumnLayout {
            id: columnLayout
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: label
                text: qsTr("Conectar al sistema")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 24
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            RowLayout {
                id: rowLayout
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Label {
                    text: qsTr("Dirección IP:")
                }

                TextField {
                    id: textFieldServerIP
                    text: "127.0.0.1"
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("192.168.0.200")
                    inputMethodHints: "ImhPreferNumbers"
                }
            }

            RowLayout {
                id: rowLayout1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Label {
                    text: qsTr("Puerto:")
                }

                TextField {
                    id: textFieldServerPort
                    text: "33600"
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("33600")
                    inputMethodHints: "ImhPreferNumbers"
                }
            }

            RowLayout {
                id: rowLayout2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Button {
                    id: buttonClose
                    text: qsTr("Cerrar")
                }

                Button {
                    id: buttonConnect
                    text: qsTr("Conectar")
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:5}D{i:6}D{i:4}D{i:8}D{i:9}D{i:7}
D{i:11}D{i:12}D{i:10}D{i:2}D{i:1}
}
##^##*/


import QtQuick 2.4
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.0

Item {
    property alias textFieldUserName: textFieldUserName
    property alias textFieldPassword: textFieldPassword
    property alias buttonLogin: buttonLogin
    property alias buttonDisconnect: buttonDisconnect

    Pane {
        id: pane
        anchors.fill: parent

        ColumnLayout {
            id: columnLayout
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: label
                text: qsTr("Iniciar sesión")
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
                    text: qsTr("Nombre de usuario:")
                }

                TextField {
                    id: textFieldUserName
                    text: "gabi"
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("user")
                }
            }

            RowLayout {
                id: rowLayout1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Label {
                    text: qsTr("Contraseña:")
                }

                TextField {
                    id: textFieldPassword
                    text: "0123456789"
                    echoMode: TextInput.Password
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("")
                }
            }

            RowLayout {
                id: rowLayout2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Button {
                    id: buttonDisconnect
                    text: qsTr("Desconectar")
                }

                Button {
                    id: buttonLogin
                    text: qsTr("Iniciar")
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:800}D{i:3}D{i:5}D{i:6}D{i:4}D{i:8}D{i:9}D{i:7}
D{i:11}D{i:12}D{i:10}D{i:2}D{i:1}
}
##^##*/


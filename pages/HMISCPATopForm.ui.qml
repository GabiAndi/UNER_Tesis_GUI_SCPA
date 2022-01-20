import QtQuick 2.4
import QtQuick.Controls 6.2

Item {
    property alias buttonDisconnect: buttonDisconnect

    Pane {
        id: pane
        anchors.fill: parent

        Button {
            id: buttonDisconnect
            y: 331
            text: qsTr("Desconectar")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:1}
}
##^##*/

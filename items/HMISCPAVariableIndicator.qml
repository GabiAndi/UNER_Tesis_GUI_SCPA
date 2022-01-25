import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: itemTop

    // Propiedades
    // Label de título
    property string titleText: "Título"
    property int titleTextPointSize: 16

    // Imagen
    property real imageSize: 50
    property alias image: image

    // Valor
    property real currentValue: 50

    property string textValueSubfix: ""

    property color textValueColor: "white"
    property color titleColor: "white"

    property real itemScale: 1

    Label {
        id: labelTitle

        Layout.fillWidth: true

        Layout.alignment: Qt.AlignHCenter

        text: itemTop.titleText

        color: itemTop.titleColor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: itemTop.titleTextPointSize * itemTop.itemScale
    }

    Image {
        id: image

        width: imageSize
        height: imageSize

        Layout.alignment: Qt.AlignCenter

        sourceSize.width: imageSize
        sourceSize.height: imageSize

        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: labelCurrentValue

        Layout.fillWidth: true

        text: itemTop.currentValue + " " + itemTop.textValueSubfix

        color: itemTop.textValueColor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: itemTop.titleTextPointSize * itemTop.itemScale
    }
}

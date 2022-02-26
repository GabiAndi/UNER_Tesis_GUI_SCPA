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
    property real currentValue: 0

    property string textValueSubfix: ""

    property color textValueColor: "white"
    property color titleColor: "white"

    property real itemScale: 1

    Label {
        id: labelTitle

        Layout.alignment: Qt.AlignCenter

        text: itemTop.titleText

        color: itemTop.titleColor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: itemTop.titleTextPointSize * itemTop.itemScale
    }

    Image {
        id: image

        width: itemTop.imageSize
        height: itemTop.imageSize

        Layout.alignment: Qt.AlignCenter

        sourceSize.width: itemTop.imageSize
        sourceSize.height: itemTop.imageSize

        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: labelCurrentValue

        Layout.alignment: Qt.AlignCenter

        text: itemTop.currentValue.toPrecision(4) + " " + itemTop.textValueSubfix

        color: itemTop.textValueColor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: itemTop.titleTextPointSize * itemTop.itemScale
    }
}

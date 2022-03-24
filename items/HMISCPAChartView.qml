import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtCharts

ChartView {
    id: itemTop

    property string chartTitle: "Titulo"
    property color chartColor: "orange"

    property alias series: dataSeries

    antialiasing: true
    animationOptions: ChartView.AllAnimations
    theme: ChartView.ChartThemeDark

    AreaSeries {
        name: itemTop.chartTitle
        color: itemTop.chartColor

        upperSeries: LineSeries {
            id: dataSeries
        }
    }
}

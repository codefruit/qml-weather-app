import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../components"

Page {
	width: 800
	height: 480

    header: Item {
        id: headlineRow
        width: parent.width
        height: 50

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10

            Label {
                text: qsTr("Week")
                font.pixelSize: Qt.application.font.pixelSize * 1.5
            }

            Item { Layout.fillWidth: true }

            Label {
                enabled: false
                text: {
                    var text = ""
                    var l = OwmController.dailyForecast.length;
                    if (OwmController.dailyForecast[0] && OwmController.dailyForecast[l-1]) {
                        text += OwmController.dailyForecast[0].timestamp.toLocaleDateString(Qt.locale(), "dd -")
                        text += OwmController.dailyForecast[l-1].timestamp.toLocaleDateString(Qt.locale(), "dd MMM yyyy")
                    }
                    return text;
                }
                font.pixelSize: Qt.application.font.pixelSize * 1.25
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width - 20
            x: 10
            height: 1
            opacity: 0.25
        }
    }

    background: MaterialGradientBackground { }

    Flickable {
        clip: true
        anchors.fill: parent

        contentWidth: width
        contentHeight: wrapper.implicitHeight

        ScrollBar.vertical: ScrollBar { interactive: false }

        Pane {
            id: wrapper
            width: parent.width
            background: Item { }

            ColumnLayout {
                width: parent.width

                Repeater {
                    id: forecastRepeater
                    model: OwmController.dailyForecast
                    ForecastComponent {
                        id: forecastItem
                        timestampFormat: "dddd dd.MM"
                        forecast: OwmController.dailyForecast[index]
                    }
                }
            }
        }
    }
}

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
                text: OwmController.forecast[0] ? OwmController.forecast[0].timestamp.toLocaleDateString(Qt.locale(), "dddd") : ""
                font.pixelSize: Qt.application.font.pixelSize * 1.5
            }

            Item { Layout.fillWidth: true }

            Label {
                enabled: false
                text: OwmController.forecast[0] ? OwmController.forecast[0] .timestamp.toLocaleDateString(Qt.locale(), "ddd dd. MMM yyyy") : ""
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

    background: Item{ }

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
                    model: OwmController.forecast
                    ForecastComponent {
                        id: forecastItem
                        forecast: OwmController.forecast[index]
                    }
                }
            }
        }
    }
}

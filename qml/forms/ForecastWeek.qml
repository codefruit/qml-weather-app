import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../components"

Page {
	width: 800
	height: 480

	header: Label {
		text: qsTr("Week")
		font.pixelSize: Qt.application.font.pixelSize * 2
		padding: 10
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
                        timestampFormat: "dddd"
                        forecast: OwmController.dailyForecast[index]
                    }
                }
            }
        }
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../components"

Page {
	width: 800
	height: 480

	header: Label {
		text: qsTr("Today")
		font.pixelSize: Qt.application.font.pixelSize * 2
		padding: 10
	}

	Flickable {
		clip: true
		anchors.fill: parent

		contentWidth: width
		contentHeight: wrapper.implicitHeight

		ScrollBar.vertical: ScrollBar { interactive: false }

		Pane {
			id: wrapper
			width: parent.width

			ColumnLayout {
				width: parent.width

				Repeater {
					id: forecastRepeater
					model: OwmController.forecast
					ForecastComponent {
						id: forecastItem
						forecast: OwmController.forecast[index]
						headlineVisible: {
							var f2 = OwmController.forecast[Math.max(index-1,0)]
							var day = f2.timestamp.toLocaleDateString(Qt.locale(), "dd")
							return index === 0 || (forecastItem && forecastItem.day !== day)
						}
					}
				}
			}
		}
	}
}

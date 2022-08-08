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

                RowLayout {
                    id: headlineRow
                    spacing: 10

                    Label {
                        text: OwmController.forecast[0] ? OwmController.forecast[0].timestamp.toLocaleDateString(Qt.locale(), "dddd") : ""
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                    }

                    Item { Layout.fillWidth: true }

                    Label {
                        enabled: false
                        text: OwmController.forecast[0] ? OwmController.forecast[0] .timestamp.toLocaleDateString(Qt.locale(), "dd.MM.yyyy") : ""
                        font.pixelSize: Qt.application.font.pixelSize * 1.25
                    }

                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    opacity: 0.25
                }

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

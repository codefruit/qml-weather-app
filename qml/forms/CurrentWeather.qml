import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../fonts/font-awesome"

import "../components"

Page {
	id: currentWeatherPage
	width: 800
	height: 480

	property date currentDate
	property string dateString

	Component.onCompleted: {
		currentDate = new Date()
		dateString = currentDate.toLocaleDateString(Qt.locale(), "ddd dd. MMM yyyy")
	}

	Connections {
		target: OwmController
		function onWeatherChanged() {
			currentDate = new Date()
			dateString = currentDate.toLocaleDateString(Qt.locale(), "ddd dd. MMM yyyy")
		}
	}

	Flickable {
		anchors.fill: parent

		contentWidth: width
		contentHeight: wrapper.implicitHeight

		ScrollBar.vertical: ScrollBar { interactive: false }

		Pane {
			id: wrapper
			width: parent.width

			ColumnLayout {
				width: parent.width

				WeatherOverviewComponent {

				}

				WeatherDetailsComponent {

				}
			}
		}
	}
}

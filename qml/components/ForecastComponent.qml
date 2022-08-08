import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../fonts/font-awesome"

Item {
	Layout.fillWidth: true
	Layout.preferredHeight: headlineRow.visible ? 84 : 42

	property var forecast
	property string day: forecast.timestamp.toLocaleDateString(Qt.locale(), "dd")
	property alias headlineVisible: headlineRow.visible

	RowLayout {
		id: headlineRow
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		height: 42
		spacing: 10

		Label {
			text: forecast.timestamp.toLocaleDateString(Qt.locale(), "dddd")
		}

		Item { Layout.fillWidth: true }

		Label {
			text: forecast.timestamp.toLocaleDateString(Qt.locale(), "dd.MM.yyyy")
		}

	}

	RowLayout {
		id: forecastRow
		anchors.top: headlineRow.visible ? headlineRow.bottom : parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		height: 42
		spacing: 10

		Label {
			text: forecast.timestamp.toLocaleTimeString(Qt.locale(), "hh:mm")
		}

		WiLabel {
			symbol: forecast.weatherIcon
		}

		Label {
			text: forecast.temperature + "°"
		}

		Label {
			text: forecast.weatherDescription
		}

		Item { Layout.fillWidth: true }

		Label {
			text: forecast.precipitation + "%"
		}
	}

	Rectangle {
		anchors.bottom: headlineRow.bottom
		width: parent.width
		height: 1
		opacity: 0.25
		visible: headlineRow.visible
	}

	Rectangle {
		anchors.bottom: forecastRow.bottom
		width: parent.width
		height: 1
		opacity: 0.25
	}

}

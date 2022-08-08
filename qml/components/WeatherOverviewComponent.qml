import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../fonts/font-awesome"

ColumnLayout {
	Layout.fillWidth: true

	Label {
		Layout.fillWidth: true

		text: OwmController.weather.weatherDescription
		font.pixelSize: Qt.application.font.pixelSize * 2
		horizontalAlignment: Text.AlignHCenter
	}

	Label {
		Layout.fillWidth: true
		Layout.topMargin: 50

		text: OwmController.weather.temperature + "°"
		font.pixelSize: Qt.application.font.pixelSize * 15
		horizontalAlignment: Text.AlignHCenter

		WiLabel {
			x: (parent.width / 2) - width
			y: symbolSize * -0.5
			enabled: false
			symbol: OwmController.weather.weatherIcon
			symbolSize: Qt.application.font.pixelSize * 15
		}
	}

	RowLayout {
		Layout.fillWidth: true

		Item {
			Layout.fillWidth: true
		}

		FaToolButton {
			enabled: false
			symbol: FaIcons.faArrowUp
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Label {
			enabled: false
			text: OwmController.dailyForecast[0] ? OwmController.dailyForecast[0].tempMax + "°" : "-1°"
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Item {
			Layout.minimumWidth: 20
		}

		FaToolButton {
			enabled: false
			symbol: FaIcons.faArrowDown
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Label {
			enabled: false
			text: OwmController.dailyForecast[0] ? OwmController.dailyForecast[0].tempMin + "°" : "-1°"
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Item {
			Layout.minimumWidth: 20
		}

		FaToolButton {
			enabled: false
			symbol: FaIcons.faUmbrella
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Label {
			enabled: false
			text: OwmController.forecast[0] ? OwmController.forecast[0].precipitation + "%" : "-1%"
			font.pixelSize: Qt.application.font.pixelSize * 2
		}

		Item {
			Layout.fillWidth: true
		}
	}

	Label {
		Layout.fillWidth: true

		enabled: false
		text: currentWeatherPage.dateString + "  •  " + OwmController.location.cityName + ", " + OwmController.location.countryCode
		horizontalAlignment: Text.AlignHCenter
	}
}

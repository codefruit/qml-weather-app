import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../fonts/font-awesome"

GridLayout {
	Layout.fillWidth: true
	Layout.margins: 20

	columnSpacing: 20
	rowSpacing: 20

	columns: {
		if(window.width > 800)
			return 4
		if(window.width > 600)
			return 3
		if(window.width > 400)
			return 2

		return 1
	}

	WeatherDetailItem {
		headline: qsTr("Pressure")
		text: OwmController.weather.pressure + " hPa"
	}

	WeatherDetailItem {
		headline: qsTr("Humidity")
		text: OwmController.weather.humidity + "%"
	}

	WeatherDetailItem {
		headline: qsTr("Wind")
		icon: FaIcons.faLocationArrow
		text: OwmController.weather.windSpeed + " km/h"
	}

	WeatherDetailItem {

	}

	WeatherDetailItem {

	}
}

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../fonts/weather-icons"

GridLayout {
    Layout.fillWidth: true
    Layout.margins: 20

    columnSpacing: 20
    rowSpacing: 20

    columns: {
        if(window.width > 1200)
            return 4
        if(window.width > 800)
            return 3
        if(window.width > 400)
            return 2

        return 1
    }

    property var locale: Qt.locale()

    WeatherDetailItem {
        headline: qsTr("Pressure")
        icon: WiIcons.wiGauge
        text: OwmController.weather.pressure + " hPa"
    }

    WeatherDetailItem {
        headline: qsTr("Humidity")
        icon: WiIcons.wiDroplet
        text: OwmController.weather.humidity + "%"
    }

    WeatherDetailItem {
        headline: qsTr("Wind Speed")
        icon: WiIcons.wiWind0Deg
        iconRotation: OwmController.weather.windDegree
        text: OwmController.weather.windSpeed + " km/h"
    }

    WeatherDetailItem {
        headline: qsTr("UV Index")
        icon: WiIcons.wiSun
        text: OwmController.forecast[0] ? OwmController.forecast[0].uvIndex.toFixed(2) : 0
    }

    Item {
        visible: columns == 4

        Layout.fillWidth: true
    }

    WeatherDetailItem {
        headline: qsTr("Sunrise")
        icon: WiIcons.wiSunrise
        text: OwmController.weather.sunrise.toLocaleTimeString(locale, Locale.ShortFormat)
    }

    WeatherDetailItem {
        headline: qsTr("Sunset")
        icon: WiIcons.wiSunset
        text: OwmController.weather.sunset.toLocaleTimeString(locale, Locale.ShortFormat)
    }

    Item {
        visible: columns == 4

        Layout.fillWidth: true
    }
}

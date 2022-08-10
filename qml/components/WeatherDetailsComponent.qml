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
        id: chartWrapper
        Layout.columnSpan: parent.columns
        Layout.fillWidth: true
        Layout.preferredHeight: 120

        Rectangle {
            id: chartBackground
            anchors.fill: parent
            radius: 10
            opacity: 0.5
            color: Material.background
            border.color: Qt.lighter(Material.background)
            border.width: 2
        }

        ForecastChart {
            id: chart

            anchors.fill: parent

            tempStrokeColor: window.accentColor !== undefined ? Material.color(window.accentColor, Material.Shade700) : Material.accent
            tempDotColor: Qt.darker(window.accentColor !== undefined ? Material.color(window.accentColor, Material.Shade700) : Material.accent)

            tempFeelStrokeColor: Material.color(Material.Orange, Material.Shade700)
            tempFeelAlpha: 0.5
            tempFeelDotEnabled: false

            popFillColor: Material.color(Material.BlueGrey, Material.Shade700)
            popAlpha: 0.25

            Connections {
                target: OwmController
                function onForecastChanged() {
                    chart.loadTemp()
                }
            }

            function loadTemp() {
                var temps = []
                var tempFeels = []
                var pops = []
                for(let i = 0; i < OwmController.forecast.length; ++i) {
                    temps.push(OwmController.forecast[i].temperature)
                    tempFeels.push(OwmController.forecast[i].tempFeel)
                    pops.push(OwmController.forecast[i].precipitation)
                }

                console.log("Update Temperature Chart: " + temps)
                console.log("Update TempFeel Chart: " + tempFeels)
                console.log("Update ChanceOfRain Chart: " + pops)

                chart.rawTempValues = temps;
                chart.rawTempFeelValues = tempFeels;
                chart.rawPopValues = pops;

                updateModel()
            }

            onVisibleChanged: {
                if (visible) {
                    loadTemp()
                }
            }
        }
    }
}

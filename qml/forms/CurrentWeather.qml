import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../components"

Page {
    id: currentWeatherPage
    width: 800
    height: 480

    property date currentDate
    property string dateString

    background: MaterialGradientBackground { }

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

    ControllableFlickable {
        id: flickable
        anchors.fill: parent

        onReloadTriggered: {
            OwmController.update();
        }

        WeatherOverviewComponent {

        }

        WeatherDetailsComponent {

        }
    }
}

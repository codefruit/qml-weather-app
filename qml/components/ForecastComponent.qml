import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../fonts/font-awesome"

Item {
	Layout.fillWidth: true
    Layout.preferredHeight: 80

	property var forecast
    property string timestampFormat: "hh:mm"

	RowLayout {
		id: forecastRow
        anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom        
		spacing: 10

        ColumnLayout {
            Label {
                id: fcDT
                enabled: false
                text: forecast.timestamp.toLocaleString(Qt.locale(), timestampFormat)
                font.pixelSize: Qt.application.font.pixelSize * 1.25
            }

            Label {
                id: fcDesc
                text: forecast.weatherDescription
                font.pixelSize: Qt.application.font.pixelSize * 1.25
            }
        }

        Item { Layout.preferredWidth: parent.width / 2 - Math.max(fcDesc.width, fcDT.width) - (Qt.application.font.pixelSize * 5) }

		WiLabel {            
			symbol: forecast.weatherIcon
            symbolSize: Qt.application.font.pixelSize * 3
		}

		Label {
			text: forecast.temperature + "°"
            font.pixelSize: Qt.application.font.pixelSize * 2
        }

		Item { Layout.fillWidth: true }

        FaToolButton {
            enabled: false
            symbol: FaIcons.faDroplet
            font.pixelSize: Qt.application.font.pixelSize * 1.5
        }

		Label {
            enabled: false
			text: forecast.precipitation + "%"
            font.pixelSize: Qt.application.font.pixelSize * 1.5
		}
	}

	Rectangle {
		anchors.bottom: forecastRow.bottom
		width: parent.width
		height: 1
		opacity: 0.25
	}
}

import QtQuick 2.12
import QtQuick.Controls 2.5

import "../fonts/weather-icons"

Label {
	id: label

	property alias symbol: label.text
	property alias symbolSize: label.font.pixelSize

	horizontalAlignment: Text.AlignHCenter
	verticalAlignment: Text.AlignVCenter

	font.family: WiFontFamily.icons
}

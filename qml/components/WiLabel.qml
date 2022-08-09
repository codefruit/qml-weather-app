import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../fonts/weather-icons"

Label {
	id: label

    Layout.preferredWidth: label.font.pixelSize * 1.5

	property alias symbol: label.text
	property alias symbolSize: label.font.pixelSize
    property alias symbolFamily: label.font.family

	horizontalAlignment: Text.AlignHCenter
	verticalAlignment: Text.AlignVCenter

	font.family: WiFontFamily.icons
}

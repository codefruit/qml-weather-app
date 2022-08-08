import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
	width: 800
	height: 480

	header: Label {
		text: qsTr("Week")
		font.pixelSize: Qt.application.font.pixelSize * 2
		padding: 10
	}

	Label {
		text: qsTr("8-day forecast")
		anchors.centerIn: parent
	}
}

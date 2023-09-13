import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../components"

import "../fonts/font-awesome"

ModalDialog {
	id: dialog
	title: qsTr("Test")
	standardButtons: Dialog.Close

	property bool armed: false
	property bool success: false

	property int error
	property string errorMessage

	function arm() {
		armed = true
	}

	function exec() {
		if (armed) {
			open()
			armed = false
		}
	}

	ColumnLayout {
		anchors.fill: parent
		spacing: 10

		Label {
			text: qsTr("Open Weather Map API test result:")
		}

		RowLayout {
			Layout.fillWidth: true
			Layout.topMargin: 10
			Layout.bottomMargin: 10

			Item {
				Layout.fillWidth: true
			}

			FaToolButton {
				Material.foreground: dialog.success ? Material.Green : Material.Red

				symbol: dialog.success ? FaIcons.faCheckCircle : FaIcons.faExclamationCircle
				font.pixelSize: Qt.application.font.pixelSize * 4
			}


			Label {
				Material.foreground: dialog.success ? Material.Green : Material.Red

				text: dialog.success ? qsTr("Epic!") : qsTr("Oh, poop.")
				font.pixelSize: Qt.application.font.pixelSize * 2
			}

			Item {
				Layout.fillWidth: true
			}

		}

		Label {
			visible: dialog.error != 0
			text: "["+ dialog.error +"]"
			font.pointSize: Qt.application.font.pointSize + 2
			font.bold: true
		}

		Label {
			Layout.fillWidth: true

			visible: dialog.error != 0
			text: dialog.errorMessage
			wrapMode: Text.WrapAnywhere
		}
	}
}

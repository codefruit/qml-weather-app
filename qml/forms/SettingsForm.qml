import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import "../fonts/font-awesome"

import "../components"
import "../dialogs"

Page {
	width: 800
	height: 480

	Settings {
		id: owmSettings
		category: "owm"
		property alias apiKey: apiKeyTextField.text
		property alias cityName: cityNameTextField.text
		property alias countryCode: countryCodeTextField.text
	}

	Settings {
		id: generalSettings
		category: "general"
		property alias temperatureUnit: temperatureUnitTextField.text
		property alias systemLang: systemLangTextField.text
		property alias systemUnits: systemUnitsTextField.text
	}


	Connections {
		target: OwmController
		function onLocationChanged() {
			dialog.success = true
			dialog.error = 0
			dialog.errorMessage = ""
			dialog.exec()
		}

		function onError(error, errorMessage) {
			dialog.success = false
			dialog.error = error
			dialog.errorMessage = errorMessage
			dialog.exec()
		}
	}

	Flickable {
		id: flickable
		clip: true
		anchors.fill: parent;
		anchors.margins: 10;
		contentHeight: layout.height

		GridLayout {
			id: layout
			//anchors.fill: parent;
			//anchors.margins: 10

			width: flickable.width
			height: flickable.height * 1.25

			columns: 2
			columnSpacing: 10

			Label {
				Layout.fillWidth: true
				Layout.columnSpan: 2

				text: qsTr("Open Weather Map:");
				font.bold: true
				font.pointSize: Qt.application.font.pointSize + 2
			}

			Label { text: qsTr("API Key:") }
			TextField {
				Layout.fillWidth: true

				id: apiKeyTextField
				placeholderText: qsTr("Enter your Open Weather Map Api Key")
			}

			Label { text: qsTr("City:") }
			TextField {
				Layout.fillWidth: true

				id: cityNameTextField
				placeholderText: qsTr("Enter city name")
			}

			Label { text: qsTr("Country Code:") }
			TextField {
				Layout.fillWidth: true

				id: countryCodeTextField
				placeholderText: qsTr("Enter two-letter lowercase country code")
			}

			RowLayout {
				Layout.columnSpan: 2

				layoutDirection: Qt.RightToLeft

				Button {
					text: qsTr("Test")
					onClicked: {
						dialog.arm()
						OwmController.update(true)
					}
				}

				Item {
					Layout.fillWidth: true
				}
			}

			Label {
				Layout.fillWidth: true
				Layout.columnSpan: 2

				text: qsTr("General:");
				font.bold: true
				font.pointSize: Qt.application.font.pointSize + 2
			}

			Label { text: qsTr("Temperatur Units:") }
			TextField {
				Layout.fillWidth: true

				id: temperatureUnitTextField
				placeholderText: qsTr("Units of measurement [c, k]")
				readOnly: true
			}

			Label { text: qsTr("Language:") }
			TextField {
				Layout.fillWidth: true

				id: systemLangTextField
				placeholderText: qsTr("System Language")
				readOnly: true
			}

			Label { text: qsTr("Units:") }
			TextField {
				Layout.fillWidth: true

				id: systemUnitsTextField
				placeholderText: qsTr("Units of measurement [standard, metric, imperial]")
				readOnly: true
			}

			Item {
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.columnSpan: 2
			}
		}

		ScrollBar.vertical: ScrollBar { interactive: false }
	}

	ConnectionDialog {
		id: dialog
	}
}

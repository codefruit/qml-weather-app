import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import "../fonts/font-awesome"

import "../components"
import "../dialogs"

Page {
	id: settingsPage
	width: 800
	height: 480

    background: Item{ }

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
			width: parent.width

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

				Item {
					Layout.fillWidth: true
				}

				Button {
					text: qsTr("Test")
					onClicked: {
						dialog.arm()
						OwmController.update(true)
					}
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

			Label {
				Layout.fillWidth: true
				Layout.columnSpan: 2
				Layout.topMargin: 50

				text: qsTr("Style:");
				font.bold: true
				font.pointSize: Qt.application.font.pointSize + 2
			}

			RowLayout {
				Layout.fillWidth: true
				Layout.columnSpan: 2
				Label {
					Layout.fillWidth: true
					text: qsTr("Dark Mode:")
				}
				Switch {
					checked: window.darkMode
					onCheckedChanged: window.darkMode = checked
				}
			}

			RowLayout {
				Layout.fillWidth: true
				Layout.columnSpan: 2
				Label {
					Layout.fillWidth: true
					text: qsTr("Color:")
				}

				Label {
					text: qsTr("Primary")
				}
				RoundButton {
					Material.background: window.primaryColor !== undefined ? Material.color(window.primaryColor, Material.Shade700) : undefined
					font.family: FaFontFamilies.solidIcons
					text: window.primaryColor === undefined ? FaIcons.faXmark : ""
					onClicked: {
						primaryColorDialog.open()
					}
					MaterialColorChoosingDialog {
						id: primaryColorDialog
						title: qsTr("Primary Color")
						onSelectedColorChanged: {
							window.primaryColor = selectedColor
						}
					}
				}
				Label {
					text: qsTr("Accent")
				}
				RoundButton {
					Material.background: window.accentColor !== undefined ? Material.color(window.accentColor, Material.Shade700) : undefined
					font.family: FaFontFamilies.solidIcons
					text: window.accentColor === undefined ? FaIcons.faXmark : ""
					onClicked: {
						accentColorDialog.open()
					}
					MaterialColorChoosingDialog {
						id: accentColorDialog
						title: qsTr("Accent Color")
						onSelectedColorChanged: {
							window.accentColor = selectedColor
						}
					}
				}
			}

			RowLayout {
				Layout.fillWidth: true
				Layout.columnSpan: 2
				Label {
					Layout.fillWidth: true
					text: qsTr("Responsive:")
				}
				RoundButton {
					font.family: FaFontFamilies.solidIcons
					text: FaIcons.faMobileScreen
					onClicked: {
						window.width = 390;
						window.height = 844;
					}
				}
				RoundButton {
					font.family: FaFontFamilies.solidIcons
					text: FaIcons.faTabletScreenButton
					onClicked: {
						window.width = 1024;
						window.height = 768;
					}
				}
				RoundButton {
					font.family: FaFontFamilies.solidIcons
					text: FaIcons.faLaptop
					onClicked: {
						window.width = 1280;
						window.height = 850;
					}
				}
				RoundButton {
					font.family: FaFontFamilies.brands
					text: FaIcons.faRaspberryPi
					onClicked: {
						window.width = 800;
						window.height = 480;
					}
				}
			}
		}

		ScrollBar.vertical: ScrollBar { interactive: false }
	}

	ConnectionDialog {
		id: dialog
	}
}

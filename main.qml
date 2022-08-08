import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.4

import "qml/forms"
import "qml/components"

ApplicationWindow {
	id: window
	width: 800
	height: 480
	visible: true
	title: qsTr("QML Weather App - Open Weather Map Widget")

	Component.onCompleted: {
		OwmController.update();
	}

	property alias interactive: swipeView.interactive;

	SwipeView {
		id: swipeView
		anchors.fill: parent
		currentIndex: tabBar.currentIndex

		PageLoader {
			id: loaderCurrentWeather
			active: Math.abs(swipeView.currentIndex - SwipeView.index) < 2;
			CurrentWeather { }
		}

		PageLoader {
			active: Math.abs(swipeView.currentIndex - SwipeView.index) < 2;
			ForecastHourly { }
		}

		PageLoader {
			active: Math.abs(swipeView.currentIndex - SwipeView.index) < 2;
			ForecastWeek { }
		}

		PageLoader {
			active: Math.abs(swipeView.currentIndex - SwipeView.index) < 2;
			SettingsForm { }
		}
	}

	footer: TabBar {
		id: tabBar
		currentIndex: swipeView.currentIndex

		TabButton {
			text: qsTr("Home")
		}
		TabButton {
			text: qsTr("Today")
		}
		TabButton {
			text: qsTr("Forecast")
		}
		TabButton {
			text: qsTr("Settings")
		}
	}

	InputPanel {
		id: inputPanel
		z: 99
		x: 0
		y: window.height
		width: window.width

		states: State {
			name: "visible"
			when: inputPanel.active
			PropertyChanges {
				target: inputPanel
				y: window.height - inputPanel.height
			}
		}
		transitions: Transition {
			from: ""
			to: "visible"
			reversible: true
			ParallelAnimation {
				NumberAnimation {
					properties: "y"
					duration: 250
					easing.type: Easing.InOutQuad
				}
			}
		}
	}
}

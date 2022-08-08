import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
	id: item
	width: 800
	height: 480

	property alias active: loader.active
	default property alias content: loader.sourceComponent

	Loader {
		id: loader
		anchors.fill: parent
		asynchronous: true
		visible: status == Loader.Ready
	}
}

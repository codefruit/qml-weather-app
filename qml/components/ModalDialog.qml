import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Dialog {
	id: dialog

	readonly property int margin: 16
	x: parent ? ((parent.width - width) / 2) : 0
	y: parent ? ((parent.height - height) / 2) : 0
	width: parent ? (parent.width / 2 - margin) : 128

	modal: true
	standardButtons: Dialog.Okay
}


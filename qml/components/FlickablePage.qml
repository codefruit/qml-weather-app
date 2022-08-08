import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
	width: 800
	height: 480


	default property alias content: view.children

	ScrollView  {
		id: view
		clip: true
		anchors.fill: parent;

		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.interactive: false

		//ScrollBar.vertical: ScrollBar { interactive: false }
	}
}

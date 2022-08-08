import QtQuick 2.12
import QtQuick.Controls 2.5

import "../fonts/font-awesome"

ToolButton {
	id: button

	property alias symbol: button.text

    font.family: FaFontFamilies.solidIcons
}

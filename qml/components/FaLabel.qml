import QtQuick 2.12
import QtQuick.Controls 2.5

import "../fonts/font-awesome"

Label {
    id: label

    property alias symbol: label.text
    property alias symbolSize: label.font.pixelSize
    property alias symbolFamily: label.font.family

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font.family: FaFontFamilies.solidIcons
    renderType: Text.NativeRendering
}

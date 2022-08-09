import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import de.codefruit.qmlcomponents 1.0

import "../fonts/font-awesome"

Pane {
    Layout.fillWidth: true

    property alias headline: headline.text
    property alias text: content.text
    property alias icon: icon.symbol
    property alias iconRotation: icon.rotation
    property alias iconFamiliy: icon.symbolFamily

    background: Rectangle {        
        radius: 10
        opacity: 0.5
        color: Material.background
        border.color: Qt.lighter(Material.background)
        border.width: 2
    }

    RowLayout {
        anchors.fill: parent

        WiLabel {
            id: icon
            visible: icon.symbol.length > 0
            symbolSize: Qt.application.font.pixelSize * 2
        }

        ColumnLayout {
            Layout.fillWidth: true

            Label {
                id: headline
                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
                font.capitalization: Font.AllUppercase
            }

            Label {
                id: content;
                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}


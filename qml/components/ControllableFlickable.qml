import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../fonts/font-awesome"

Item {
    id: container
    anchors.fill: parent

    signal reloadTriggered

    default property alias children: wrapperLayout.children

    Flickable {
        id: flickable
        anchors.fill: parent

        contentWidth: width
        contentHeight: wrapper.implicitHeight

        ScrollBar.vertical: ScrollBar { interactive: false }

        onDragEnded: {
            if (reloadButtonWrapper.triggered) {
                container.reloadTriggered()
                reloadButtonWrapper.triggered = false;
            }
        }

        Pane {
            id: wrapper
            width: parent.width
            background: Item { }

            ColumnLayout {
                id: wrapperLayout
                width: parent.width
            }
        }
    }

    Item {
        id: reloadButtonWrapper
        width: parent.width
        height: 80

        visible: flickable.dragging && flickable.verticalOvershoot < height * -1
        property int overshoot: flickable.verticalOvershoot * -1 - height
        property bool triggered: false

        RoundButton {
            id: reloadButton
            anchors.centerIn: parent
            checkable: true

            checked: roloadIcon.rotation > 300
            padding: Qt.application.font.pixelSize * 2.5

            onCheckedChanged: {
                if (checked && reloadButtonWrapper.visible) {
                    reloadButtonWrapper.triggered = true
                }
            }

            Label {
                id: roloadIcon
                anchors.centerIn: parent
                font.family: FaFontFamilies.solidIcons
                font.pixelSize: Qt.application.font.pixelSize * 2
                text: FaIcons.faArrowRotateRight

                rotation: 180 + (reloadButtonWrapper.overshoot)
            }
        }
    }
}

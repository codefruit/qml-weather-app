import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

import "../fonts/font-awesome"

Dialog {
    id: messageDialog
    title: "Message"

    parent: ApplicationWindow.overlay
    x: (window.width - width) / 2
    y: (window.height - height) / 2

    property var selectedColor

    ColumnLayout {
        Label {
            Layout.bottomMargin: 25
            text: qsTr("Select your Material Design Color:")
        }

        GridLayout {
            columns: 4

            Repeater {
                model: [
                    Material.Red,
                    Material.Pink,
                    Material.Purple,
                    Material.DeepPurple,
                    Material.Indigo,
                    Material.Blue,
                    Material.LightBlue,
                    Material.Cyan,
                    Material.Teal,
                    Material.Green,
                    Material.LightGreen,
                    Material.Lime,
                    Material.Yellow,
                    Material.Amber,
                    Material.Orange,
                    Material.DeepOrange,
                    Material.Brown,
                    Material.Grey,
                    Material.BlueGrey,
                    undefined
                ]

                RoundButton {
                    font.family: FaFontFamilies.solidIcons
                    Material.background: modelData !== undefined ? Material.color(modelData, Material.Shade700) : modelData
                    text: modelData === undefined ? FaIcons.faXmark : ""
                    onClicked: {
                        selectedColor = modelData
                        close()
                    }
                }
            }
        }
    }
}

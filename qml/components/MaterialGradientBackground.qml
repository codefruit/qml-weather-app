import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12

Item {
    id: backgroudWrapper

    Connections {
        target: window
        function onAccentColorChanged() {
            dataCanvas.requestPaint()
        }
        function onPrimaryColorChanged() {
            dataCanvas.requestPaint()
        }
        function onDarkModeChanged() {
            dataCanvas.requestPaint()
        }
    }

    property color colorTL: (window.primaryColor !== undefined ? Material.color(window.primaryColor, Material.Shade700) : Material.primary)
    property color colorCC: (!window.darkMode ? Qt.darker(Material.background, 4) : Qt.darker(Material.background, 1))
    property color colorBR: (window.accentColor !== undefined ? Material.color(window.accentColor, Material.Shade700) : Material.accent)

    Canvas {
        id: dataCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            var gradient = ctx.createLinearGradient(45, 45, window.width - 75, window.height - 75)

            gradient.addColorStop(0, colorTL)
            gradient.addColorStop(0.4, colorCC)
            gradient.addColorStop(0.6, colorCC)
            gradient.addColorStop(1, colorBR)

            ctx.fillStyle = gradient
            ctx.fillRect(0, 0, window.width, window.height)
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Material.background
        opacity: 0.80
    }
}

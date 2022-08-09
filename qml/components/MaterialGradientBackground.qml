import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item {

    id: wrapper
    property color colorTL: window.primaryColor !== undefined ? Material.color(window.primaryColor, Material.Shade700) : Material.primary
    property color colorBL: Material.background
    property color colorCC: Material.background
    property color colorTR: Material.background
    property color colorBR: window.accentColor !== undefined ? Material.color(window.accentColor, Material.Shade700) : Material.accent
    property bool light: !window.darkMode

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

    Item {
        anchors.fill: parent

        layer.enabled: true
        layer.effect: ShaderEffect {
            blending: false
            readonly property var dataTex: dataCanvas
            readonly property int count: dataCanvas.colors.length

            fragmentShader: "
                          varying highp vec2 qt_TexCoord0;
                          uniform lowp float qt_Opacity;
                          uniform sampler2D dataTex;
                          const uniform lowp int count;
                          void main() {
                              vec3 col = 0.0;

                              for (int i = 0; i < count; i++) {
                                  vec4 color = texture2D(dataTex, vec2(i / (float)count + 0.01, 0.0));
                                  vec2 point = texture2D(dataTex, vec2(i / (float)count + 0.01, 1.0)).rg;

                                  float dist = distance(qt_TexCoord0, point);
                                  col += color * (1.0 - dist);
                              }

                              gl_FragColor = vec4(col, 1.0);
                          }
                ";
        }

        Canvas {
            id: dataCanvas
            readonly property var colors: [
                wrapper.colorTL,
                wrapper.light ? Qt.darker(wrapper.colorBL, 2) : Qt.darker(wrapper.colorBL, 1.5),
                wrapper.light ? Qt.darker(wrapper.colorCC, 4) : Qt.darker(wrapper.colorCC, 1),
                wrapper.light ? Qt.darker(wrapper.colorTR, 2) : Qt.darker(wrapper.colorTR, 1.5),
                wrapper.colorBR]
            readonly property var positions: [
                Qt.point(0,0),
                Qt.point(10, parent.height - 20),
                Qt.point(parent.width / 2, parent.height / 4),
                Qt.point(parent.width, 0),
                Qt.point(parent.width, parent.height)]

            height: 2
            width: colors.length
            antialiasing: false
            visible: false

            onPaint: {
                if (colors.length !== positions.length) {
                    console.error("Array size of 'colors' doesn't equal array size of 'positions'");
                    return;
                }

                var ctx = getContext("2d");
                ctx.reset();
                ctx.lineWidth = 1;

                for (var i = 0; i < colors.length; i++) {
                    ctx.beginPath();
                    ctx.strokeStyle = colors[i];
                    ctx.moveTo(i, 0);
                    ctx.lineTo(i+1, 0);
                    ctx.stroke();
                    ctx.closePath();

                    ctx.beginPath();
                    ctx.strokeStyle = Qt.rgba(positions[i].x / parent.width, positions[i].y / parent.height, 0, 1);
                    ctx.moveTo(i, 1);
                    ctx.lineTo(i+1, 1);
                    ctx.stroke();
                    ctx.closePath();
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Material.background
        opacity: 0.80
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

Canvas {
    id: canvas

    antialiasing: true

    property color tempStrokeColor
    property color tempDotColor
    property bool tempDotEnabled: true
    property real tempAlpha: 1.0

    property color tempFeelStrokeColor
    property color tempFeelDotColor
    property bool tempFeelDotEnabled: true
    property real tempFeelAlpha: 1.0

    property color popFillColor
    property real popAlpha: 1.0

    property int lineWidth: 2
    property real dotRadius: 5

    property int yDiff: 0
    property int xDiff: 0
    property int nullOffset: 0

    property var rawTempValues : []
    property var rawTempFeelValues : []
    property var rawPopValues : []

    Path { id: tempPath; }
    Path { id: tempFeelPath; }
    property var popRects : []

    function updateModel() {
        calculateEnv()
        updateModelPath(tempPath, rawTempValues)
        updateModelPath(tempFeelPath, rawTempFeelValues)
        canvas.popRects = calculateBarChartRects(rawPopValues)

        canvas.requestPaint()
    }

    function calculateEnv() {

        var length = canvas.rawTempValues.length
        if (length <= 0) {
            return;
        }

        var min; var max;
        if (canvas.rawTempValues.length) {
            for(let i = 0; i < length; ++i) {
                let temp = canvas.rawTempValues[i]
                if (max === undefined || temp > max) { max = temp }
                if (min === undefined || temp < min) { min = temp }
            }
        }
        if (canvas.rawTempFeelValues.length) {
            for(let i = 0; i < length; ++i) {
                let temp = canvas.rawTempFeelValues[i]
                if (max === undefined || temp > max) { max = temp }
                if (min === undefined || temp < min) { min = temp }
            }
        }

        min = 5 * Math.floor((min - 10) / 5)
        max = 5 * Math.floor((max + 10) / 5)
        //console.log("len:" + length + ", min: " + min + ", max: " + max)

        var yAbsTemp = min < 0 ? Math.abs(min) + Math.abs(max) : max - min
        canvas.yDiff = canvas.height / yAbsTemp;
        canvas.xDiff = canvas.width / (length + 1)
        canvas.nullOffset = (min < 0 ? Math.abs(min) : -min) * canvas.yDiff

        //console.log("height:" + canvas.height + ", yDiff: " + canvas.yDiff + ", width: " + canvas.width + ", xDiff: " + canvas.xDiff)
        //console.log("nullOffset:" + canvas.nullOffset)
    }

    function updateModelPath(pathObj, rawModel) {

        var length = rawModel.length
        if (length <= 0) {
            return;
        }

        pathObj.pathElements = []

        for(let i = 0; i < length; ++i) {
            let temp = rawModel[i]

            var pathcurve = Qt.createQmlObject('import QtQuick 2.12; PathCurve {}', pathObj);
            pathcurve.x = Math.floor(canvas.xDiff * (i + 1))
            pathcurve.y = Math.floor(canvas.height - canvas.nullOffset - canvas.yDiff * temp)

            if (i === 0) {
                pathObj.startX = pathcurve.x
                pathObj.startY = pathcurve.y
            } else {
                pathObj.pathElements.push(pathcurve)
            }
        }
    }

    function calculateBarChartRects(rawModel) {

        var length = rawModel.length
        if (length <= 0) {
            return;
        }

        var rectObj = []

        for(let i = 0; i < length; ++i) {
            let percent = rawModel[i]

            let width = canvas.xDiff - 5
            let x = Math.floor(canvas.xDiff * (i + 1)) - width / 2
            let height = canvas.height * (percent / 100) - 10
            let y = canvas.height - height - 5

            if (percent < 0 || percent > 100 || y < 0 || height < 0) {
                continue
            }

            var rect = { "x": x, "y": y, "width": width, "height": height}
            rectObj.push(rect)
        }

        return rectObj
    }

    function drawLineChart(ctx, pathObj, strokeStyle, enableDots, dotStyle, alpha) {
        if (pathObj.pathElements.length) {
            ctx.globalAlpha = alpha
            ctx.beginPath();
            ctx.path = pathObj;
            ctx.strokeStyle = strokeStyle;
            ctx.stroke();

            if (enableDots === true) {
                ctx.beginPath();
                ctx.ellipse(pathObj.startX-canvas.dotRadius, pathObj.startY-canvas.dotRadius, 2*canvas.dotRadius, 2*canvas.dotRadius)

                for(var i=0; i < pathObj.pathElements.length; i++){
                    let point = pathObj.pathElements[i]
                    ctx.ellipse(point["x"]-canvas.dotRadius, point["y"]-canvas.dotRadius, 2*canvas.dotRadius, 2*canvas.dotRadius)
                }

                ctx.fillStyle = dotStyle
                ctx.fill()
            }
        }
    }

    function drawBarChart(ctx, rectObj, fillStyle,  alpha) {
        if (rectObj && rectObj.length) {
            ctx.globalAlpha = alpha
            ctx.fillStyle = fillStyle
            ctx.beginPath();

            for(var i=0; i < rectObj.length; i++){
                let rect = rectObj[i]
                ctx.fillRect(rect.x, rect.y, rect.width, rect.height)
            }
        }
    }

    onPaint: {
        var ctx = getContext("2d");

        ctx.save();
        ctx.clearRect(0,0,canvas.width, canvas.height);
        ctx.lineWidth = canvas.lineWidth

        drawBarChart(ctx, canvas.popRects, canvas.popFillColor, canvas.popAlpha)
        drawLineChart(ctx, tempFeelPath, canvas.tempFeelStrokeColor, canvas.tempFeelDotEnabled, canvas.tempFeelDotColor, canvas.tempFeelAlpha)
        drawLineChart(ctx, tempPath, canvas.tempStrokeColor, canvas.tempDotEnabled, canvas.tempDotColor, canvas.tempAlpha)

        ctx.restore();
    }
}

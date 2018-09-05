import QtQuick 2.0

Item {
    id: fpsDisplayControl
    property bool hidden: true
    property real fps: 0.0
    property alias frames: timer.frames

    onHiddenChanged: {
        if (fpsDisplayControl.hidden)
            fpsDisplay.color = "transparent"
        else
            fpsDisplay.color = "#000000FF"
    }

    onFpsChanged: {
        fpsDisplay.updateFps()
    }

    Timer {
        id: timer

        interval: 1000
        repeat: true
        running: !fpsDisplayControl.hidden
        property int frames: 0

        onTriggered: {
            fpsDisplayControl.fps = frames * 1000 / interval;
            frames = 0
        }
        onRunningChanged: frames = 0
    }

    Rectangle {
        anchors.fill: parent
        id: fpsDisplay
        color: "transparent"

        property real maxFps: 60.0
        property color maxFpsColor: "#5500FF00"
        property color minFpsColor: "#55FF0000"

        function updateFps() {
            var scale = (fps > maxFps)?1.0:(fps/maxFps)
            var r = (1 - scale) * minFpsColor.r + scale * maxFpsColor.r
            var g = (1 - scale) * minFpsColor.g + scale * maxFpsColor.g
            var b = (1 - scale) * minFpsColor.b + scale * maxFpsColor.b
            var a = (1 - scale) * minFpsColor.a + scale * maxFpsColor.a
            fpsCauge.height = scale * fpsDisplay.height
            fpsCauge.color = Qt.rgba(r, g, b, a)
        }

        Rectangle {
            id: fpsCauge
            width: parent.width
            anchors.bottom: parent.bottom
            visible: !fpsDisplayControl.hidden
        }

        Text {
            id: fpsText
            text: "" + (fps | 0) + "fps"
            font.family: "Helvetica"
            font.pixelSize: 16
            font.weight: Font.Light
            color: "white"
            anchors.fill: parent
            anchors.margins: 10
            verticalAlignment: Text.AlignVCenter
            visible: !fpsDisplayControl.hidden
            horizontalAlignment: Text.AlignRight
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            fpsDisplayControl.hidden = !fpsDisplayControl.hidden
        }
    }
}

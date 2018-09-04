import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Scene3D 2.0
import Qt3D.Logic 2.0

Window {
    visible: true
    width: 480
    height: 480
    title: qsTr("Qt3DBaseProject")

    Item {
        anchors.fill: parent

        Scene3D {
            id: scene3D
            anchors.fill: parent

            focus: true // get key event
            aspects: ["input", "logic"] // get events
            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
            hoverEnabled: true // get mouse-over event

            Content3D {
                FrameAction {
                    onTriggered: {
                        fpsDisplay.frames++;
                    }
                }
            }
        }

        Text {
            text: "Qt3D Base Project"

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            font.pixelSize: 25
        }

        FpsDisplay {
            id: fpsDisplay

            hidden: false

            width: 70
            height: 30

            anchors.right: parent.right
        }
    }
}

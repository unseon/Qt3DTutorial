import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Scene3D 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("HudBezierStroke")

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
                id: content3D
            }
        }


        RowLayout {
            width: parent.width
            spacing: 10
            Button {
                Layout.preferredWidth: 100
                text: "Turn Left"
                onClicked: {
                    content3D.stateController.state = "turnLeft"
                }
            }
            Button {
                Layout.preferredWidth: 100

                text: "To Left Lane"
                onClicked: {
                    content3D.stateController.state = "toLeftLane"
                }
            }
            Button {
                Layout.preferredWidth: 100

                text: "Straight"
                onClicked: {
                    content3D.stateController.state = "straight"
                }
            }
            Button {
                Layout.preferredWidth: 100

                text: "To Right Lane"
                onClicked: {
                    content3D.stateController.state = "toRightLane"
                }
            }
            Button {
                Layout.preferredWidth: 100

                text: "Turn Right"
                onClicked: {
                    content3D.stateController.state = "turnRight"
                }
            }

        }
    }
}

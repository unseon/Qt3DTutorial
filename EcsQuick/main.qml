import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Scene3D 2.0



Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item {
        anchors.fill: parent

        Scene3D {
            width: parent.width / 2
            height: parent.height

            SceneEntity {

            }
        }

        Item {
            x: width
            width: parent.width / 2
            height: parent.height

            Image {
                height: 150
                width: 150
                source: "qrc:/qt_logo_green_rgb.png"
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }

            Image {
                x: 150
                height: 150
                width: 150
                source: "qrc:/qt_logo_green_rgb.png"
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}

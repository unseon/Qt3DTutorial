import QtQuick 2.0

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.11
import QtQuick 2.11

import QtQuick.Scene3D 2.0

Scene3D {
    id: scene3d
    focus: true
    aspects: ["input", "logic"]
    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

    property alias backgroundColor: backToFrontRenderer.clearColor

    Entity {
        components: [
            RenderSettings {
                activeFrameGraph: BackToFrontRenderer {
                    id: backToFrontRenderer
                    clearColor: "black"
                    camera: mainCamera
                }
            },
            InputSettings { }
        ]

        Camera {
            id: mainCamera
            position: Qt.vector3d(0.0, 0.0, 7.0)
            upVector: Qt.vector3d(0.0, 1.0, 0.0)
            viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
        }

        FirstPersonCameraController {
            camera: mainCamera
        }

        Entity {
            components: [
                PointLight {},
                Transform { translation: mainCamera.position }
            ]
        }

        Cubes {
            components: [
                Transform {
                    translation: Qt.vector3d(0.2, 0.2, 0.0);
                }
            ]
        }
        Cubes {
            components: [
                Transform {
                    translation: Qt.vector3d(0.1, 0.1, -0.1);
                }
            ]
        }
        Cubes {
            components: [
                Transform {
                    translation: Qt.vector3d(0.0, 0.0, -0.2);
                }
            ]
        }

    }

}

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0
import QtQuick 2.9


Entity {
    id: content3D

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: "gray"
                camera: camera
            }
        },
        InputSettings { },
        MouseHandler {
            id: mouseHandler
            sourceDevice:  MouseDevice {}

            onPressed: {
            }

            onReleased: {
            }
        },
        DirectionalLight {
            worldDirection: Qt.vector3d(1.0, -2.0, -1.0)
            intensity: 1.0
        }
    ]

    Camera {
        id: camera

        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60
        aspectRatio: 1.0 / 1.0
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 100.0, 100.0, 100.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    OrbitCameraController {
        id: orbitCameraController

        camera: camera
        linearSpeed: 1000.0
    }

    NodeInstantiator {
        id: instantiator

        model: ListModel {
            ListElement {
                x: 0.0
                y: 10.0
                z: 0.0
                myColor: "red"
            }
            ListElement {
                x: 0.0
                y: 30.0
                z: 0.0
                myColor: "#AADDAA"
            }
        }

        property var geometry:
            Mesh {
                id: toyplaneMesh
                source: "qrc:/toyplane.obj"
            }

        property var material:
            PhongMaterial {
                ambient: "#222222"
                diffuse: "#DDCCBB"
            }

        delegate: Entity {
            id: toyplane

            property var transform:
                Transform {
                    translation: Qt.vector3d(0.0, model.y, 30.0)
                    scale: 1.0
                }

            property var material:
                PhongMaterial {
                    ambient: "#222222"
                    diffuse: model.myColor
                }

            components: [transform, instantiator.geometry, material]
        }
    }

    Entity {
        id: plane

        property var transform:
            Transform {
                translation: Qt.vector3d(0.0, 0.0, 0.0)
            }

        property var geometry:
            PlaneMesh {
                width: 100.0
                height: 100.0
            }

        property var material:
            PhongMaterial {
                ambient: "#222222"
                diffuse: "#AAAABB"
            }

        components: [transform, geometry, material]
    }
}

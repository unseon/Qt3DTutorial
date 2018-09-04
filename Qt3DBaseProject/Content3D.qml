import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0


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

    Entity {
        id: cube

        property var transform:
            Transform {
                translation: Qt.vector3d(0.0, 5.0, 0.0)
            }

        property var geometry:
            CuboidMesh {
                xExtent: 10.0
                yExtent: 10.0
                zExtent: 10.0
            }

        property var material:
            PhongMaterial {
                ambient: "#222222"
                diffuse: "#AADDAA"
            }

        components: [transform, geometry, material]
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

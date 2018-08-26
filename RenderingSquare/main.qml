import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Entity {
    id: sceneRoot

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: "lightgreen"
                camera: camera
            }
        }
    ]

    Entity {
        id: camera

        property var transform:
            Transform {
                translation: Qt.vector3d(0.0, 0.0, 1.0)
            }

        property var cameraLens:
            CameraLens {
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 90.0
            }

        components: [transform, cameraLens]
    }

    Entity {
        id: plane

        property var transform:
            Transform {
                translation: Qt.vector3d(0.0, 0.0, 0.0)
                rotationX: 90
            }

        property var geometry:
            PlaneMesh {
                width: 1
                height: 1
            }

        property var material:
            PhongMaterial {
                ambient: "red"
            }

        components: [transform, geometry, material]
    }
}

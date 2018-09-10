import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.10
import QtBezierStroke 1.0
import QtQuick 2.9 as QQ2

Entity {
    id: sceneRoot
    property var stateController: stateController

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: "darkgreen"
                camera: camera
            }
        }
    ]

    Camera {
        id: camera

        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60
        aspectRatio: 1.0 / 1.0
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, 1.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    OrbitCameraController {
        id: orbitCameraController

        camera: camera
        linearSpeed: 1000.0
    }

    Entity {
        id: plane

        property var transform:
            Transform {
                translation: Qt.vector3d(0.0, -0.5, 0.0)
                rotationX: -90

                scale: 0.5

            }

        property var geometry:
            BezierStroke {
                id: bezierStroke
                p0: Qt.vector3d(0.0, 0.0, 0.0)
                p1: Qt.vector3d(0.0, 0.0, 0.3)
                p2: Qt.vector3d(0.0, 0.0, 0.3)
                p3: Qt.vector3d(0.0, 0.0, 1.0)
            }

            QQ2.Item {
                id: stateController

                state: "turnToRight"
                states: [
                    QQ2.State {
                        name: "straight"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p2.x: 0.0
                            p3.x: 0.0
                        }
                    },
                    QQ2.State {
                        name: "toRightLane"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p1.z: 0.5
                            p2.z: 0.5
                            p2.x: 0.75
                            p3.x: 0.75
                        }
                    },
                    QQ2.State {
                        name: "toLeftLane"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p1.z: 0.5
                            p2.z: 0.5
                            p2.x: -0.75
                            p3.x: -0.75
                        }
                    },
                    QQ2.State {
                        name: "turnRight"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: 0.75
                            p2.x: 0.0
                            p2.z: 1.0
                        }
                    },
                    QQ2.State {
                        name: "turnLeft"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: -0.75
                            p2.x: 0.0
                            p2.z: 1.0
                        }
                    }
                ]

                transitions: [
                    QQ2.Transition {
                        from: "*"
                        to: "*"
                        QQ2.PropertyAnimation {
                            target: bezierStroke
                            properties: "p1.x, p1.z, p2.x, p2.z, p3.x"

                            duration: 500

                            easing.type: QQ2.Easing.OutQuad
                        }
                    }
                ]

            }

            QQ2.SequentialAnimation {
                running: false
                loops: -1
                QQ2.PropertyAnimation {
                    target: bezierStroke
                    property: "p3.x"

                    duration: 1000
                    from: -1.0
                    to: 1.0
                }
                QQ2.PropertyAnimation {
                    target: bezierStroke
                    property: "p3.x"

                    duration: 1000
                    from: 1.0
                    to: -1.0
                }
            }

        property var material:
            DiffuseSpecularMaterial {
                ambient: "white"
                diffuse: "white"
            }

        components: [transform, geometry, material]
    }
}

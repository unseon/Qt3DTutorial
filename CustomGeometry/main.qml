import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import QtBezierStroke 1.0
import QtQuick 2.9 as QQ2

Entity {
    id: sceneRoot
    property var stateController: stateController

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
                translation: Qt.vector3d(0.0, 0.0, 2.0)
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
                //rotationX: -45
            }

        property var geometry:
//            PlaneMesh {
//                width: 1
//                height: 1
//            }

//            GeometryRenderer {

//                primitiveType: GeometryRenderer.Points
//                geometry: Geometry {
//                    Attribute {
//                        attributeType: Attribute.VertexAttribute
//                        vertexBaseType: Attribute.Float
//                        vertexSize: 3
//                        count: 60
//                        name: defaultPositionAttributeName
//                        buffer: bezierCurveBuffer
//                    }
//                }
//            }
            BezierStroke {
                id: bezierStroke
                p0: Qt.vector3d(0.0, 0.0, 0.0)
                p1: Qt.vector3d(0.0, 0.5, 0.0)
                p2: Qt.vector3d(p3.x, 0.5, 0.0)
                p3: Qt.vector3d(0.5, 1.0, 0.0)
            }

            QQ2.Item {
                id: stateController

                state: "turnToRight"
                states: [
                    QQ2.State {
                        name: "toRightLane"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: 1.0
                        }
                    },
                    QQ2.State {
                        name: "toLeftLane"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: -1.0
                        }
                    },
                    QQ2.State {
                        name: "turnToRight"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: 1.0
                            p2.y: 1.0
                        }
                    },
                    QQ2.State {
                        name: "turnToLeft"
                        QQ2.PropertyChanges {
                            target: bezierStroke
                            p3.x: -1.0
                            p2.y: 1.0
                        }
                    }
                ]

                transitions: [
                    QQ2.Transition {
                        from: "*"
                        to: "*"
                        QQ2.PropertyAnimation {
                            target: bezierStroke
                            properties: "p3.x, p2.y"

                            duration: 1.0

                            easing: QQ2.Easing.OutQuad
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
            PhongMaterial {
                ambient: "red"
            }

        components: [transform, geometry, material]
    }
}

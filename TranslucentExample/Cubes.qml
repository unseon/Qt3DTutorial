import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0
import Qt3D.Extras 2.11
import QtQuick.Scene2D 2.9

Entity {
    id: cubes

    property real alpha: 0.5

    NumberAnimation {
        target: cubes
        property: "alpha"
        duration: 10000
        easing.type: Easing.InOutQuad
        from: 0.0
        to: 1.0
        running: true
        loops: Animation.Infinite
    }

    TextureLoader {
        id: arrowTexture
        source: "qrc:/heart.svg"
    }

//    Scene2D {
//        id: qmlTexture
//        output: RenderTargetOutput {
//            attachmentPoint: RenderTargetOutput.Color0
//            texture: Texture2D {
//                id: offscreenTexture
//                width: pngImg.width
//                height: pngImg.height
//                format: Texture.RGBA8_UNorm
//                generateMipMaps: true
//                magnificationFilter: Texture.Linear
//                minificationFilter: Texture.LinearMipMapLinear
//                wrapMode {
//                    x: WrapMode.ClampToEdge
//                    y: WrapMode.ClampToEdge
//                }
//            }
//        }
//        mouseEnabled: false
//        Image {
//            id: pngImg
//            source: "qrc:/heart.svg"
//            opacity: 1.0
//        }
//    }

    CubeEntity {
        id: solidPlane0
        position: Qt.vector3d(-1, 1, 0)
        material: PhongAlphaMaterial {
            diffuse: Qt.rgba(1.0, 0.0, 0.0, cubes.alpha)

            Component.onCompleted: {
                console.log("solidPane0", sourceAlphaArg, destinationAlphaArg);
            }
        }
    }

    CubeEntity {
        id: solidPlane1
        position: Qt.vector3d(-1, 0, 0)

        material: PhongAlphaMaterial {
            diffuse: Qt.rgba(1.0, 0.0, 0.0)
            ambient: Qt.rgba(alpha, 0.0, 0.0)
            alpha: cubes.alpha
            //sourceRgbArg: BlendEquationArguments.SourceAlpha
            //destinationRgbArg: BlendEquationArguments.OneMinusSourceAlpha
            sourceAlphaArg: BlendEquationArguments.One
            destinationAlphaArg: BlendEquationArguments.One

            Component.onCompleted: {
                console.log("solidPane1", sourceAlphaArg, destinationAlphaArg);
            }
        }
    }

    CubeEntity {
        id: solidPane2
        position: Qt.vector3d(-1, -1, 0)

        material: PhongAlphaMaterial {
            diffuse: Qt.rgba(1.0, 0.0, 0.0)
            ambient: Qt.rgba(alpha, 0.0, 0.0)
            sourceAlphaArg: BlendEquationArguments.Zero
            destinationAlphaArg: BlendEquationArguments.One

            alpha: cubes.alpha

            Component.onCompleted: {
                console.log("solidPane2", sourceAlphaArg, destinationAlphaArg);
            }
        }
    }

    CubeEntity {
        id: texturePlane0
        position: Qt.vector3d(0, 1, 0)
        material: UnlitTextureAlphaMaterial {
            diffuse: arrowTexture

            sourceAlpha: BlendEquationArguments.One
            destinationAlpha: BlendEquationArguments.One

            alpha: cubes.alpha
            Component.onCompleted: {
                console.log("texturePane0", sourceAlpha, destinationAlpha);
            }
        }
    }

    CubeEntity {
        id: texturePlane1
        position: Qt.vector3d(0, 0, 0)
        material: UnlitTextureAlphaMaterial {
            diffuse: arrowTexture

            sourceAlpha: BlendEquationArguments.Zero
            destinationAlpha: BlendEquationArguments.One

            alpha: cubes.alpha
        }
    }

    CubeEntity {
        id: texturePlane2
        position: Qt.vector3d(0, -1, 0)
        material: UnlitTextureAlphaMaterial {
            diffuse: arrowTexture

            sourceAlpha: BlendEquationArguments.One
            destinationAlpha: BlendEquationArguments.Zero

            alpha: cubes.alpha
        }
    }

//    CubeEntity {
//        id: offscreenPlane0
//        position: Qt.vector3d(1, 1, 0)
//        material: UnlitTextureAlphaMaterial {
//            diffuse: offscreenTexture

//            sourceAlpha: BlendEquationArguments.One
//            destinationAlpha: BlendEquationArguments.One

//            alpha: cubes.alpha
//            Component.onCompleted: {
//                console.log("texturePane0", sourceAlpha, destinationAlpha);
//            }
//        }
//    }

    CubeEntity {
        position: Qt.vector3d(1, -1, 0)
        material: DiffuseSpecularMaterial {
            diffuse: Qt.rgba(1.0, 0.0, 0.0, cubes.alpha)
            ambient: Qt.rgba(cubes.alpha, 0.0, 0.0)
            alphaBlending: true
        }
    }



//    CubeEntity {
//        position: Qt.vector3d(1, -1, 0)
//        material: DiffuseSpecularMaterial {
//            normal: TextureLoader { source: "qrc:/assets/textures/pattern_09/normal.webp" }
//            diffuse: TextureLoader { source: "qrc:/assets/textures/pattern_09/diffuse.webp" }
//            specular: TextureLoader { source: "qrc:/assets/textures/pattern_09/specular.webp" }
//        }
//    }
}

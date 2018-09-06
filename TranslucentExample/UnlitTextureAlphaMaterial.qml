import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "UnlitTextureAlphaShaders.js" as ShaderCode

Material {
    id: root

    property var diffuse: Texture2D {}
    property real textureScale: 1.0
    property real alpha: 0.5

    property var sourceRgb: BlendEquationArguments.SourceAlpha
    property var sourceAlpha: BlendEquationArguments.One
    property var destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
    property var destinationAlpha: BlendEquationArguments.Zero

    parameters: [
        Parameter {
            name: "diffuseTexture"
            value: root.diffuse
        },
        Parameter {
            name: "texCoordScale"
            value: root.textureScale
        },
        Parameter {
            name: "alpha"
            value: root.alpha
        }
    ]

    effect: Effect {

        FilterKey {
            id: forward
            name: "renderingStyle"
            value: "forward"
        }

        //! [2]
        ShaderProgram {
            id: gl3Shader
            vertexShaderCode: ShaderCode.getVertGL()
            fragmentShaderCode: ShaderCode.getFragGL()
        }
        ShaderProgram {
            id: es2Shader
            vertexShaderCode: ShaderCode.getVertES2()
            fragmentShaderCode: ShaderCode.getFragES2()
        }

        techniques: [
            // OpenGL 3.1
            Technique {
                filterKeys: [forward]
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGL
                    profile: GraphicsApiFilter.CoreProfile
                    majorVersion: 3
                    minorVersion: 1
                }
                renderPasses: RenderPass {
                    shaderProgram: gl3Shader
                    renderStates: [
                        NoDepthMask {
                        },
                        BlendEquationArguments {
                            sourceRgb: root.sourceRgb
                            sourceAlpha: root.sourceAlpha
                            destinationRgb: root.destinationRgb
                            destinationAlpha: root.destinationAlpha
                        },
                        BlendEquation {
                            blendFunction: BlendEquation.Add

                        }
                    ]
                }
            },

            // OpenGL 2.0
            Technique {
                filterKeys: [forward]
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGL
                    profile: GraphicsApiFilter.NoProfile
                    majorVersion: 2
                    minorVersion: 0
                }
                renderPasses: RenderPass {
                    shaderProgram: es2Shader
                    renderStates: [
                        NoDepthMask {
                        },
                        BlendEquationArguments {
                            sourceRgb: root.sourceRgb
                            sourceAlpha: root.sourceAlpha
                            destinationRgb: root.destinationRgb
                            destinationAlpha: root.destinationAlpha
                        },
                        BlendEquation {
                            blendFunction: BlendEquation.Add
                        }
                    ]
                }
            },
            // ES 2.0
            Technique {
                filterKeys: [forward]
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGLES
                    profile: GraphicsApiFilter.CoreProfile
                    majorVersion: 2
                    minorVersion: 0
                }
                renderPasses: RenderPass {
                    shaderProgram: es2Shader
                    renderStates: [
                        NoDepthMask {
                        },
                        BlendEquationArguments {
                            sourceRgb: root.sourceRgb
                            sourceAlpha: root.sourceAlpha
                            destinationRgb: root.destinationRgb
                            destinationAlpha: root.destinationAlpha
                        },
                        BlendEquation {
                            blendFunction: BlendEquation.Add
                        }


                    ]

                    SortPolicy {
                        id: sortPolicy
                        // Always render back to front
                        sortTypes: [SortPolicy.BackToFront]
                    }
                }
            }
        ]
    }
}



import Qt3D.Core 2.0
import Qt3D.Render 2.10

TechniqueFilter {
    id: techniqueFilter

    property alias surface: renderSurfaceSelector.surface
    property alias viewportRect: viewport.normalizedRect
    property alias clearColor: clearBuffers.clearColor
    property alias camera: cameraSelector.camera
    property alias externalRenderTargetSize: renderSurfaceSelector.externalRenderTargetSize
    property alias frustumCulling: frustumCulling.enabled
    property alias gamma: viewport.gamma

    matchAll: [
        FilterKey {
            name: "renderingStyle"
            value: "forward"
        }
    ]

    RenderSurfaceSelector {
        id: renderSurfaceSelector

        Viewport {
            id: viewport
            normalizedRect: Qt.rect(0.0, 0.0, 1.0, 1.0)

            CameraSelector {
                id: cameraSelector

                ClearBuffers {
                    id: clearBuffers
                    clearColor: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                    buffers: ClearBuffers.ColorBuffer

                    FrustumCulling {
                        id: frustumCulling

                        RenderStateSet {
                            id: renderStateSet
                            renderStates: [
                                NoDepthMask {
                                    // Disable Depth Test
                                },
                                CullFace {
                                    // Only Render Front faces (needed when you disable depth test)
                                    mode: CullFace.Back
                                },
                                BlendEquationArguments {
                                    sourceRgb: BlendEquationArguments.SourceAlpha
                                    sourceAlpha: BlendEquationArguments.One
                                    destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                                    destinationAlpha: BlendEquationArguments.Zero

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
                }
            }
        }
    }
}

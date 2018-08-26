import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Entity {
    id: sceneRoot

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: "lightgreen"
            }
        }
    ]
}

import MetalKit
enum SceneTypes{
    case Sandbox
}//contains 1 sandbox that we have made - different scenes we make over time
class SceneManager{
    private static var _currentScene: Scene!//current state that we are in - depends on what we are actually doing
    
    public static func Initialize(_ sceneType: SceneTypes){//
        SetScene(sceneType)
    }
    public static func SetScene(_ sceneType: SceneTypes){
        switch sceneType {
        case .Sandbox:
            _currentScene = SandboxScene()
        }
    }
    //taking the rendering of the scene and replace in scne manager - it take responsibility of updating and rendering the current scene it is on scene.children is terrain - go over and render.
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float){
        _currentScene.updateCameras(deltaTime: deltaTime)
        _currentScene.update(deltaTime: deltaTime)
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}

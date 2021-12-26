import MetalKit
class Scene: Node{//backend scene
    var cameraManager = CameraManager()
    var sceneConstants = SceneConstants()

    //headnode of the tree- node class will need array of children

        override init(){
            super.init()
            buildScene()//basic prototype for schene
        }
    func addCamera(_ camera: Camera,_ isCurrentCamera: Bool=true){
        cameraManager.registerCamera(camera: camera)
        if(isCurrentCamera){
            cameraManager.setCamera(camera.cameraType)
        }
    }
    func buildScene(){
        
    }
    func updateCameras(deltaTime: Float){
        cameraManager.update(deltaTime: deltaTime)
    }
    override func update(deltaTime: Float){
      
        updateSceneConstants()
        super.update(deltaTime: deltaTime)
    }
    
    func updateSceneConstants(){
        sceneConstants.viewMatrix = cameraManager.currentCamera.viewMatrix
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
 




class CameraManager {
    /*
     strategy patern - update algorith at runtiem rather tha nbefore compile time
     
     */
    private var _cameras: [CameraTypes : Camera] = [:]//dict of cameras
    
    public var currentCamera: Camera!//current camera
    
    public func registerCamera(camera: Camera){
        self._cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraTypes){//set current camera
        self.currentCamera = _cameras[cameraType]
    }
    
    internal func update(deltaTime: Float){//update cameras to be able to switch between them
        for camera in _cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
    
}

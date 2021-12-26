import MetalKit
class Player : GameObject{
    private var camera: Camera!
    init(camera: Camera){
        self.camera=camera
        super.init(meshType: .Triangle_Custom)//automatically init's itself with mesh type
    }
    override func update(deltaTime: Float){
        //want player to follow mouse position
        //inverse arctan
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x-position.x+camera.position.x,Mouse.GetMouseViewportPosition().y-position.y+camera.position.y)
        super.update(deltaTime: deltaTime)
        
        
    }
}

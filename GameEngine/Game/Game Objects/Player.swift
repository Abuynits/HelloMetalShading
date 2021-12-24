import MetalKit
class Player : GameObject{
    init(){
        super.init(meshType: .Triangle_Custom)//automatically init's itself with mesh type
    }
    override func update(deltaTime: Float){
        //want player to follow mouse position
        //inverse arctan
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x-position.x,Mouse.GetMouseViewportPosition().y-position.y)
        super.update(deltaTime: deltaTime)
        
        
    }
}

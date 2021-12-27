import MetalKit

class SandboxScene: Scene{
    var debugCamera = DebugCamera()
   // let player = Player()
    var cube = Cube()
    override func buildScene() {
        
        addCamera(debugCamera)
      //  addChild(player)//adds to the children array in node - itterate over all nodes and render player
//        let count : Int = 5
//        for y in -count..<count{
//            for x in -count..<count{
//                let player = Player(camera: debugCamera)
//                player.position.y = Float(Float(y)+0.5)/Float(count)
//                player.position.x = Float(Float(x)+0.5)/Float(count)
//                player.scale = SIMD3<Float>(0.1,0.1,0.1)
//                addChild(player)
//            }
//        }
        debugCamera.position.z = 5
        addChild(cube)
    }
    override func update(deltaTime: Float) {
        //depth buffer - need to activate - not even look at depth - just ask if it is a pixel and puts it on the screen - pixel overide pixel or not override - depth buffer can be automatioc
        //depth stencil states - maintain depth buffers 
        cube.rotation.x+=deltaTime
        //cube.rotation.y+=deltaTime
        super.update(deltaTime: deltaTime)
    }
}

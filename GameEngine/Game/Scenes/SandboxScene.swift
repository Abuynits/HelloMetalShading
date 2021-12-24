import MetalKit
class SandboxScene: Scene{
   // let player = Player()
    override func buildScene() {
      //  addChild(player)//adds to the children array in node - itterate over all nodes and render player
        let count : Int = 5
        for y in -count..<count{
            for x in -count..<count{
                let player = Player()
                player.position.y = Float(Float(y)+0.5)/Float(count)
                player.position.x = Float(Float(x)+0.5)/Float(count)
                player.scale = SIMD3<Float>(0.1,0.1,0.1)
                addChild(player)
            }
        }
    }
}

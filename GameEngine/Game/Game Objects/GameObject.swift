import MetalKit

class GameObject: Node{
    var modelConstant = ModelConstants()
    
    //want to change the type of shape based on what is being passed in
    var mesh : Mesh!
    //model constants - way of trasnfering movement information on our model to the GPU to do these matrix operations
    init(meshType : MeshTypes){
        mesh = MeshLibrary.Mesh(meshType)
    }
   // var time: Float = 0
    override func update(deltaTime: Float){
//        time += deltaTime
//
//
//        self.position.x = cos(time)//updated to cos time,
//        self.position.y = sin(time)
//        self.scale = SIMD3<Float>(0.5*cos(time),0.5*sin(time),1)//scale allong all axis
//        self.rotation.z = cos(time)
//
        updateModelConstants()
        
    }
    private func updateModelConstants(){
        modelConstant.modelMatrix = self.modelMatrix//refer to the node's nodel matrix
    }
    
}
extension GameObject: Renderable{
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        // renderCommandEncoder.setTriangleFillMode(.lines)//set to a fill line
         //set render command encorder's pipeline state:
         //each game object will have a render pipeline state
        //use bytes vs float - not want to make buffer if have value over 4mb- once over that cap, you want to make a buffer - if have a few bytes, can just pass reference -just call renderCommandEncoder.setBytes- set at the index
        renderCommandEncoder.setVertexBytes(&modelConstant, length: ModelConstants.stride, index: 1)//where place in shader - at buffer 1
         renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.Basic))
         /*
          ata
          */
         renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
         //index 0 is the buffer at 0
         //'?' controls whether the object is nil
         renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)//use triangle - loop around
         //send info to render command encoder
        
        //if want to have multiple game objects, can have an array of them, and call render on each one - come in some that not make sense- could render mutliple things and override. If each one has particle effects or other objects that can ovveride.
        /*
         if have street scene, will have terrain, street, car. This does not look like array - look likes a tree - called a scene graph - terrain render itself, streeet render itself, car render itself,
         */
    }
}

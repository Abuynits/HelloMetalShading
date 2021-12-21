import MetalKit

class GameObject: Node{
    //want to change the type of shape based on what is being passed in
    var mesh : Mesh!
    init(meshType : MeshTypes){
        mesh = MeshLibrary.Mesh(meshType)
    }
}
extension GameObject: Renderable{
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        // renderCommandEncoder.setTriangleFillMode(.lines)//set to a fill line
         //set render command encorder's pipeline state:
         //each game object will have a render pipeline state
         renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.Basic))
         /*
          ata
          */
         renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
         //index 0 is the buffer at 0
         //'?' controls whether the object is nil
         renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)//use triangle - loop around
         //send info to render command encoder
    }
}

import MetalKit
class GameObject{
    //create vertex array: (cant create on the fly- need to have function)
    var vertices: [Vertex]!//! is an optional - dont have to define here
    //create unistantiated vertex buffer
    var vertexBuffer: MTLBuffer!
    
    init(){
        createVertices()
        createBuffer()
    }
    
    func createVertices(){//want to call this before we make the buffers
        vertices = [
            Vertex(position: SIMD3<Float>(0,1,0), color: SIMD4<Float>(1,0,0,1)),
        Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,1,0,1)),
        Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,0,1,1))
        ]
    }
    func createBuffer(){
        //need device to make objects
        //bytes are the vertices
        //length use the memory layout of SIMD3
        //options - memory shared functionality - how shared between cpu and gpu
        vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])//32 bytes- 32*coutn = 32*3
    }
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        //set render command encorder's pipeline state:
        //each game object will have a render pipeline state
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.Basic))
        /*
         we are setting the render pipeline state- this consists of the vertex and fragment function ( set them already) - can also set the vertex buffers using render command encoder -renderpipeline state can access the buffer data
         */
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        //index 0 is the buffer at 0
        //'?' controls whether the object is nil
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)//use triangle - loop around
        //send info to render command encoder
        
    }
}

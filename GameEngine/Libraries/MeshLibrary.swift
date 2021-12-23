import MetalKit
enum MeshTypes{
    case Triangle_Custom
    case Quad_Custom
}
class MeshLibrary{
    private static var meshDict: [MeshTypes:Mesh]=[:]
    
    public static func initialize(){
        createDefaultMeshes()
    }
    private static func createDefaultMeshes(){
        meshDict.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        meshDict.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom )
    }
    public static func Mesh(_ meshType: MeshTypes)->Mesh{
        return meshDict[meshType]!
    }
}
protocol Mesh{
    //will need multiple type of meshes
    var vertexBuffer : MTLBuffer! {get}
    var vertexCount : Int! {get}
}
class CustomMesh: Mesh{
    //create vertex array: (cant create on the fly- need to have function)
    var vertices: [Vertex]!//! is an optional - dont have to define here
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int!{
        return vertices.count
    }
    init(){
        createVertices()
        createBuffer()
    }
    
    func createVertices(){//want to call this before we make the buffers
        //overidden in others
    }
    func createBuffer(){
        //need device to make objects
        //bytes are the vertices
        //length use the memory layout of SIMD3
        //options - memory shared functionality - how shared between cpu and gpu
        vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])//32 bytes- 32*coutn = 32*3
    }
}
class Triangle_CustomMesh: CustomMesh{
    override func createVertices() {//ovverite create vertices from about
        vertices = [
        Vertex(position: SIMD3<Float>(0,1,0), color: SIMD4<Float>(1,0,0,1)),
        Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,1,0,1)),
        Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,0,1,1))
        ]
    }
}

class Quad_CustomMesh: CustomMesh{
    override func createVertices() {//ovverite create vertices from about
        vertices = [
           
            
            Vertex(position: SIMD3<Float>(1,1,0), color: SIMD4<Float>(1,0,0,1)),//Top right
        Vertex(position: SIMD3<Float>(-1,1,0), color: SIMD4<Float>(0,1,0,1)),//top left
        Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,0,1,1)),//bottom left
        
        Vertex(position: SIMD3<Float>(1,1,0), color: SIMD4<Float>(1,0,0,1)),//top right
        Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,0,1,1)),//bottom left
        Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,1,0,1)),//bottom right
        
        
        ]
    }
}

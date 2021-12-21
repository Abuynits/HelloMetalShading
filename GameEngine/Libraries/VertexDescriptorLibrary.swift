import MetalKit
enum VertexDescriptorTypes{
    case Basic//key to look up - use Basic - basic vertex - has position and color
    
}
class VertexDescriptorLibrary{
    private static var vertexDescriptorDict: [VertexDescriptorTypes: VertexDescriptor] = [:]
    public static func initialize(){
        createDefaultVertexDescriptors()
    }
    private static func createDefaultVertexDescriptors(){
        //init the map - say value is basic vertex descriptor
        vertexDescriptorDict.updateValue(Basic_VertexDescriptor(), forKey: .Basic)
    }
    public static func descriptor(_ vertexDescriptorType: VertexDescriptorTypes)->MTLVertexDescriptor{
        return vertexDescriptorDict[vertexDescriptorType]!.vertexDescriptor
    }

}
protocol VertexDescriptor{
    var name: String {get}
    var vertexDescriptor: MTLVertexDescriptor {get}
}
//basic vertex descriptor - if want to make another - make the same method signature and add it in update value
//do: vertexDesscriptorDict.updateValue(New_VertexDescriptor(), forkey: .newKey)
//also need to add another case to the VertexDescriptorTypes ex: case newBasic
public struct Basic_VertexDescriptor: VertexDescriptor{
    var name: String = "Basic Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor{
        
        let vertexDescriptor = MTLVertexDescriptor() //basic object - set render pipeline vertex descripto to this one
        //first attribute represented by position (0 -index)
       
        //attributes at 0 (setting up the position
       
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0//buffer index is 0
        vertexDescriptor.attributes[0].offset = 0 // where exactly is inside of the struct ( is 0).
        //flaot 4 ( the color) will have an offset of float3
        
        vertexDescriptor.attributes[1].format = .float4//set to float 4
        vertexDescriptor.attributes[1].bufferIndex = 0//still at buffer 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size//offset is float3
        //how the pipeline state describes our thing - our stride with float 3 and float 4, use stride of vertex to describe it
        
        vertexDescriptor.layouts[0].stride = Vertex.stride//knows this from Types
        return vertexDescriptor
    }
}

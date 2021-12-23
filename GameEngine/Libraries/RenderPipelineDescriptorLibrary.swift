import MetalKit
enum RenderPipelineDescriptorTypes{
    case Basic
}

class RenderPipelineDescriptorLibrary{
    private static var renderPipelineDict: [RenderPipelineDescriptorTypes:RenderPipelineDescriptor] = [:]
    public static func initialize(){
        createDefaultRenderPipelineDescriptors()
    }
    private static func createDefaultRenderPipelineDescriptors(){
        renderPipelineDict.updateValue(Basic_Render_Pipeline_Descriptor(), forKey: .Basic)
    }
    public static func descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorTypes)->MTLRenderPipelineDescriptor{
        return renderPipelineDict[renderPipelineDescriptorType]!.renderPipelineDescriptor
    }
    
    
}


protocol RenderPipelineDescriptor{
    var name: String {get}
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! {get}
}
public struct Basic_Render_Pipeline_Descriptor: RenderPipelineDescriptor{
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    init(){
         renderPipelineDescriptor = MTLRenderPipelineDescriptor()
      
        renderPipelineDescriptor.vertexDescriptor=VertexDescriptorLibrary.descriptor(.Basic)
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preference.mainPixelFormat
        
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)//bc cached
    }
    
}

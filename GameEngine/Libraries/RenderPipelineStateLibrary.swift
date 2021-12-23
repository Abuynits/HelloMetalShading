import MetalKit
enum RenderPipelineStateTypes{
    case Basic
}

class RenderPipelineStateLibrary{
    private static var renderPipelineStateDict: [RenderPipelineStateTypes:RenderPipelineState] = [:]
    
    public static func initialize(){
        renderPipelineStateDict.updateValue(Basic_Render_Pipeline_State(), forKey: .Basic)
    }
    public static func pipelineState(_ renderPipelineStateType: RenderPipelineStateTypes)-> MTLRenderPipelineState{
        return renderPipelineStateDict[renderPipelineStateType]!.renderPipelineState
    }
    
}
protocol RenderPipelineState{
    var name : String {get}
    var renderPipelineState : MTLRenderPipelineState! {get}
}
public struct Basic_Render_Pipeline_State: RenderPipelineState{
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    init(){
        //need libary
        
       // let library = Engine.Device.makeDefaultLibrary()
        //can put on code
        //each object needs to have a game create object- dont want to create them over and over - want to cache info, then grab from cache for each game buffer
        //instantiatign vertex and fragment functions
        //need to correspond to the function name in metal
       // let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
       // let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        // now make the pipieline state descriptor
        //let renderPipelineDescriptor = RenderPipelineDescriptorLibrary.descriptor(.Basic)
//        renderPipelineState: MTLRenderPipelineState!
         //create render pipieline state
        do {//init the pipeline state- try the build the renderer
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(.Basic))
        } catch let error as NSError{
            print("Unable to compile render pipeline state: \(error)")
           
        }
      //  return renderPipelineState
    }
    
}

import MetalKit
//mtkView= subclass of NSView
class GameView: MTKView{
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    //now need to create initializer
    required init(coder: NSCoder){
        super.init(coder:coder)
        //device: abstract representation of GPU- make metal view objects and send them down to GPU
        self.device = MTLCreateSystemDefaultDevice()
        //havea clear funciton - darwing, clearing, drawing clearing - need to set clear color
        self.clearColor = MTLClearColor(red: 0, green: 1, blue: 0, alpha: 1)
        //set the pixel format - need to match outf=put of fragment shader- will output a display image, ened to match image pixel format to our pixel format - .bgra8 (most generic/msot used format)
        //can click on "colorPixelformat" to get library brings up the formats that exist and the sizes that they mean
        
        //now need to setup command Queue
        //just a queue - a list of instuctions (FIFO) - acts as a limiter of who goes out, has commadn buffers, when ready to commit, push to lcear screen, and then discarded
        //command queue has a list of command buffers - cimmited to clear screen, ones done displaying, it wil lbe disposed ( show a clear screen), get a new buffer
        self.commandQueue = device?.makeCommandQueue()
        //need to have stuff store inside it
        
        self.colorPixelFormat = .bgra8Unorm
        
        createRenderPipelineState()
    }
    func createRenderPipelineState(){
        //need libary
        let library = device?.makeDefaultLibrary()
        //can put on code
        //instantiatign vertex and fragment functions
        //need to correspond to the function name in metal
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        // now make the pipieline state descriptor
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
         //create render pipieline state
        do {//init the pipeline state- try the build the renderer
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError{
            print("Unable to compile render pipeline state: \(error)")
           
        }
        
    }
    //in the NSView, part of MTKView-
    override func draw(_ dirtyRect: NSRect){
        //once tries to get current drawable- willl continue on
        guard let drawable = self.currentDrawable else { return}
        guard let renderPassDescriptor = self.currentRenderPassDescriptor else { return}
        //need to make a coomand buffer -whatever order enque command buffer in queue - will execute first
        let commandBuffer = commandQueue.makeCommandBuffer()
        //render commadn encoder- tell commadn buffer what ot do when it is called
        //- can render graphics directly to screen
        // compute command encoder -computation tasks, mathematics- things wiant to multithread over GPU,
        //blit command encoder- memory managment
    // paralel command: able to render mutliple things at the same time - if want to render tecture and then turn into another tecture0 write two textures to the screeen.
        //use renderpass descriptor to instantiate comand encoder- renderpassdescriptor -has pixel/ buffer store infor ofr next job
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        //set render command encoder render pipeline state
        //most important thing:
        //holds a lot of info - vertex function, fragment functions, color attachment
        //color attachment - pixel format: colorattachement[0] must match MSView(GameVIew)- need to set to .bgra8Unorm
        //vertex and fragment made with MTL library - it makes these fucntions, then stores in pipline descripton, vertex and fragment live in metal file
        
        //set render command encorder's pipeline state:
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        //send info to render command encoder
        
        //need to stop render command encoder:
        renderCommandEncoder?.endEncoding()
        //need to present next drawable to screen
        commandBuffer?.present(drawable)
        //now commit it to the next buffer
        commandBuffer?.commit()
        
        
    }
    
}

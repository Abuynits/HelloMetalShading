import MetalKit
//mtkView= subclass of NSView
class GameView: MTKView{
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    
    //create vertex array:
    let vertices: [SIMD3<Float>] = [
        SIMD3<Float>(0,1,0),//top middle
        SIMD3<Float>(-1,-1,0),//bottom right
        SIMD3<Float>(1,-1,0)//bottom left
    ]
    //create unistantiated vertex buffer
    var vertexBuffer: MTLBuffer!
    
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
        createBuffer()
    }
    func createBuffer(){
        //need device to make objects
        //bytes are the vertices
        //length use the memory layout of SIMD3
        //options - memory shared functionality - how shared between cpu and gpu
        vertexBuffer = device?.makeBuffer(bytes: vertices, length: vertices.count*MemoryLayout<SIMD3<Float>>.stride, options: [])
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
        /*
         we are setting the render pipeline state- this consists of the vertex and fragment function ( set them already) - can also set the vertex buffers using render command encoder -renderpipeline state can access the buffer data
         */
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        //index 0 is the buffer at 0
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)//use triangle - loop around
        //send info to render command encoder
        
        //need to stop render command encoder:
        renderCommandEncoder?.endEncoding()
        //need to present next drawable to screen
        commandBuffer?.present(drawable)
        //now commit it to the next buffer
        commandBuffer?.commit()
        
        //rendering using GPU in swift and metal - compile data on cpu, ship to gpu, then pop out of gpu, and put on nsview
        /*
         what are MTL buffers?
         unforamted device accessible space:
            If take n obytes ( off in memory and want to put stuff into it )- want 12 byes of memory that we can grab from and have areference to it
            want to allocate 12 bytes worth of space ( nothing written there, jsut for outr access)
            when create buffer, always the same amoutn - buffered - bc know the amount of data that the reference will have - if write more or less, it will voerwrite the buffer
            then we can store our data in it - have 12 bytes of buffer ( cna grab as we have reference to it)
         now we can use cpu and gpu to read and write to that area
         in our case, a triangle
         
         How to make a triangle?
            scren spce coordinates- have origin at 0,0,0 ( in the middle of the screen)
            - point out of nose and come behind you ( z- component)
            min and max = -1,1 - only goes in unit space
            want to create vertex array that will store tiangle angle- need 3 float 3
            vertexArray: [float3]=[flaot3(0,1,0), float3(-1,-1,0). float3(1,-1,0)]
            wil draw and last one will connect to the first as we are using a triangle primitive type
        How to compile data in vertex buffer?
            have 3 float 3's - need to store that info- vert array size = 16 byes *3 = 48 bytes size ( the size of the buffer) - 16 bytes bc a float 3 holds 16 bytes
        Device space:
            have rows of unoformated buffer memory - index with allocated space and data - does not even exist rn - can have a max of 30 buffered memory - not need to use that much-
            use the device to make a buffer:
            vertexBuffer =Device.MakeBuffer(bytes: VertexArray, size: 48 BYtes, index: 0)
            size: 48 bytes
            index = 0
            bytes: vertetx array
            
            how use with GPU - create the buffer, but not actually set it - use the vertex shader to draw with these vertecies - first parament to vertex shader is at buffer index 0 - ties to index of the device space- when use render command encoder to setr at vindex 0, use the attriburte to grab at index 0- can grab it out of the device space using buffer attribute tag ( index)
         
         vertex float4 basic_vertex_shader(device flaot3 *vertices [[buffer(0) ]], uint vertexID [[vertex_id}})[
         return vertices[vertexID};
         }
         gpu will return position to rasterizer
         
         
         
         
         */
    }
    
}

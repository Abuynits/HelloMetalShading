import MetalKit
class Engine{
    //now need to setup command Queue
    //just a queue - a list of instuctions (FIFO) - acts as a limiter of who goes out, has commadn buffers, when ready to commit, push to lcear screen, and then discarded
    //command queue has a list of command buffers - cimmited to clear screen, ones done displaying, it wil lbe disposed ( show a clear screen), get a new buffer
   //NOTE: this has been moved to engine
    //need to have stuff store inside it
    public static var CommandQueue : MTLCommandQueue!
    
    public static var Device: MTLDevice!
    public static func Ignite(device: MTLDevice){//call engine .ignite at start of aplicating that would make it set the device of MTL to the engine device
        self.Device=device
        self.CommandQueue = device.makeCommandQueue()
        ShaderLibrary.inittialize()//init the shader library
        VertexDescriptorLibrary.initialize()//init vertex descriptor library
        RenderPipelineDescriptorLibrary.initialize()//init render library
        RenderPipelineStateLibrary.initialize()//init the render state library
    }
}

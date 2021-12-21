import MetalKit
//mtkView= subclass of NSView
//mtkView Deletage: deletage renderer draw function of the view to the class.
class GameView: MTKView{
    //a view - job not to render things want to change it jsut to set up view stuff - mouse input, keyboard input. - need renderer file
    // rn the game view have vertices and vertex buffer - need to be in another sub class
    // game view main objective is  to do key and mouse input.
    
    var renderer: Renderer!//need to instantiate after engine.ignite
    
    //now need to create initializer
    required init(coder: NSCoder){
        super.init(coder:coder)
        //device: abstract representation of GPU- make metal view objects and send them down to GPU
        self.device = MTLCreateSystemDefaultDevice()//create 1 time on applicatio nadn never chagne
        Engine.Ignite(device: device!)//everywhere in application use device - not use local device, use engine device
        //havea clear funciton - darwing, clearing, drawing clearing - need to set clear color
        //signleton class - called enging- just do engine.device rather than passing it through.
        self.clearColor = Preference.clearColor
        //set the pixel format - need to match outf=put of fragment shader- will output a display image, ened to match image pixel format to our pixel format -  8 (most generic/msot used format)
        //can click on "colorPixelformat" to get library brings up the formats that exist and the sizes that they mean
        
      
        
        self.colorPixelFormat = Preference.mainPixelFormat
        
        self.renderer = Renderer()//delegate all of draw functionalities to renderer class
        
        self.delegate = renderer
        
       
    }
   //Mouse and keyboard input
   
    
}

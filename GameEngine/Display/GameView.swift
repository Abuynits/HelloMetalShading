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
        self.depthStencilPixelFormat = Preference.mainDepthPixelFormat
        
        self.renderer = Renderer(self)//delegate all of draw functionalities to renderer class
        
        self.delegate = renderer
        
       /*
        perspective projection - things are larger when they are closer and smaller when they are farther away)train tracks)
        have a near and far cliping plane - everything beyond these planes are not touched - not clipped
        
        orthographic projection - things are the same size regardless of what position they are at
        projective: add depth to the scene
        
        
        local space (original vector position) x world space ( model matrix - rot, tran, scale) x Eye Space(view matrix - camera) x projection matrix (normalized Device Space Coordinates )- new vertex position
        
        each one of these matrix arer transformation- projection matrix - objects not move in same distance - move different distances.
        
        
        */
    }

    }
extension GameView{
    //keyboard input
     override var acceptsFirstResponder: Bool {return true} //allow to accept key view on the loop
 //keyboard button - click button down - keydown event
     override func keyDown(with event: NSEvent) {
         Keyboard.SetKeyPressed(event.keyCode, isOn: true)
     }
     //when release button:
     override func keyUp(with event: NSEvent) {
         Keyboard.SetKeyPressed(event.keyCode, isOn: false)
     }
 }
//moue input
extension GameView{
    override func mouseDown(with event: NSEvent) {//left button click
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func mouseUp(with event: NSEvent) {
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    override func rightMouseDown(with event: NSEvent) {
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func rightMouseUp(with event: NSEvent) {//right button click
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    override func otherMouseUp(with event: NSEvent) {//if have another button on mouse
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func otherMouseDown(with event: NSEvent) {
         Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
}
//mouse moved extension
extension GameView {
    override func mouseMoved(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    override func scrollWheel(with event: NSEvent) {
         Mouse.ScrollMouse(deltaY: Float(event.deltaY))
    }
    override func mouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    override func rightMouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    override func otherMouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    private func setMousePositionChanged(event: NSEvent){//get curernt location in window of mouse, change - how far moved
        let overallLocation = SIMD2<Float>(Float(event.locationInWindow.x),Float(event.locationInWindow.y))
        let deltaChange = SIMD2<Float>(Float(event.deltaX),Float(event.deltaY))
        Mouse.SetMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    override func updateTrackingAreas(){
        //called anytime the screen is initialized or resized - set area of screen with tracking area- take bounds of entire screen size, set options of what want to apply, and constantly tracking
        let area = NSTrackingArea(rect: self.bounds,
                                  options: [NSTrackingArea.Options.activeAlways,NSTrackingArea.Options.mouseMoved,NSTrackingArea.Options.enabledDuringMouseDrag],
                                  owner:self,
                                  userInfo: nil
        )
        self.addTrackingArea(area)
    }
}
/*
 theory of moving objects in screen space:
 if want, can do manually - un realistic, hard to do
 computational algorithms - very fast-matrix operations with formula in them
 act as a operation
 can take a 1x4, multiply by 4x4, we get a 1x4 matrix returned. collumn of first has to be equal to row of first. It goes out to 1x4 bc these are the other, remaining locations
 
 location is a 1x4 coordinate - [x,y,z,a] by the move operation, get a new position- not need to do much, just say the amount that you want to move, we can also rotate and scale
 - we can do these things sequentially
 */

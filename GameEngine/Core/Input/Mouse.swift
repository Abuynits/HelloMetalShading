import MetalKit

enum MOUSE_BUTTON_CODES: Int {//mouse button codes- integer - any button click on mouse
    case LEFT = 0
    case RIGHT = 1
    case CENTER = 2
}

class Mouse {
    private static var MOUSE_BUTTON_COUNT = 12//can fill up to
    private static var mouseButtonList = [Bool].init(repeating: false, count: MOUSE_BUTTON_COUNT)

    private static var overallMousePosition = SIMD2<Float>(0)
    private static var mousePositionDelta = SIMD2<Float>(0)//changes

    private static var scrollWheelPosition: Float = 0//mouse scroll position
    private static var lastWheelPosition: Float = 0.0//way to track how much scroll by

    private static var scrollWheelChange: Float = 0.0

    public static func SetMouseButtonPressed(button: Int, isOn: Bool){
        mouseButtonList[button] = isOn//true in array
    }

    public static func IsMouseButtonPressed(button: MOUSE_BUTTON_CODES)->Bool{
        return mouseButtonList[Int(button.rawValue)] == true
    }

    public static func SetOverallMousePosition(position: SIMD2<Float>){//as mouse moves, will update overall position
        self.overallMousePosition = position
    }

    ///Sets the delta distance the mouse had moved
    public static func SetMousePositionChange(overallPosition: SIMD2<Float>, deltaPosition: SIMD2<Float>){
        self.overallMousePosition = overallPosition
        self.mousePositionDelta += deltaPosition
    }

    public static func ScrollMouse(deltaY: Float){//delta wheel
        scrollWheelPosition += deltaY
        scrollWheelChange += deltaY
    }

    //Returns the overall position of the mouse on the current window
    public static func GetMouseWindowPosition()->SIMD2<Float>{
        return overallMousePosition
    }

    ///Returns the movement of the wheel since last time getDWheel() was called
    public static func GetDWheel()->Float{
        let position = scrollWheelChange
        scrollWheelChange = 0
        return position
    }

    ///Movement on the y axis since last time getDY() was called.
    public static func GetDY()->Float{
        let result = mousePositionDelta.y
        mousePositionDelta.y = 0
        return result
    }

    ///Movement on the x axis since last time getDX() was called.
    public static func GetDX()->Float{//if move to right -will get that frames distance in change and it will update that state
        let result = mousePositionDelta.x
        mousePositionDelta.x = 0
        return result
    }

    //Returns the mouse position in screen-view coordinates [-1, 1] take in current screen size we have 
    public static func GetMouseViewportPosition()->SIMD2<Float>{
        let x = (overallMousePosition.x - Renderer.ScreenSize.x * 0.5) / (Renderer.ScreenSize.x * 0.5)
        let y = (overallMousePosition.y - Renderer.ScreenSize.y * 0.5) / (Renderer.ScreenSize.y * 0.5)
        return SIMD2<Float>(x, y)
    }
}

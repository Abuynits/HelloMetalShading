import MetalKit
//create enum for clear color
enum ClearColors{
    static let White: MTLClearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let Green: MTLClearColor = MTLClearColor(red: 0.22, green: 0.55, blue: 0.5, alpha: 1.0)
    static let Grey: MTLClearColor = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let Black: MTLClearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1.0)
}
class Preference{
    
    public static var clearColor: MTLClearColor = ClearColors.Black
    public static var mainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    public static var mainDepthPixelFormat: MTLPixelFormat = MTLPixelFormat.depth32Float
    public static var StartingSceneTypes: SceneTypes = SceneTypes.Sandbox
}

import MetalKit

class Keyboard{
    private static var KEY_COUNT: Int = 256
    private static var keys = [Bool].init(repeating: false, count: KEY_COUNT)//fills all values with false for 256 types
    
    public static func SetKeyPressed(_ keyCode: UInt16, isOn: Bool){
        keys[Int(keyCode)] = isOn
    }
    public static func IsKeyPressed(_ keyCode: Keycode)->Bool{
        return keys[Int(keyCode.rawValue)]
    }
}

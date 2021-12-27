import simd
class DebugCamera: Camera{
    var cameraType: CameraTypes = CameraTypes.Debug
    var position: SIMD3<Float> = SIMD3(repeating: 0)
    var projectionMatrix: matrix_float4x4{
        //made a get - return a matrix 4x4 .perspective
        return matrix_float4x4.perspective(degreesFov: 45, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
        //aspect ration- have sceen sizes - have it - just dynamic calculation of aspect ration
    }
    func update(deltaTime: Float) {
        if(Keyboard.IsKeyPressed(.leftArrow)){
            self.position.x -= deltaTime
        }
        if(Keyboard.IsKeyPressed(.rightArrow)){
            self.position.x += deltaTime
        }
        if(Keyboard.IsKeyPressed(.upArrow)){
            self.position.y += deltaTime
        }
        if(Keyboard.IsKeyPressed(.downArrow)){
            self.position.y -= deltaTime
        }
    }
}

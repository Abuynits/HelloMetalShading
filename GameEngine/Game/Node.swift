import MetalKit
class Node{
    
    var position: SIMD3<Float> = [0,0,0]
    var scale: SIMD3<Float> = [1,1,1]
    var rotation: SIMD3<Float> = [0,0,0]
    var modelMatrix: matrix_float4x4{//can extend functions of 4x4
        var modelMatrix = matrix_identity_float4x4//just set equal to 1
        modelMatrix.translate(direction: position)//need to make translate function
        modelMatrix.rotate(angle: rotation.x, axis: X_AXIS)
        modelMatrix.rotate(angle: rotation.y, axis: Y_AXIS)
        modelMatrix.rotate(angle: rotation.z, axis: Z_AXIS)
        modelMatrix.scale(axis: scale)//scale allong x and y axis
        return modelMatrix
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        //do rendering here - as of right now, game object does not have values that we can use- want to call render on the game object, but want to seperate rendering out from game object.
     
        if let renderable = self as? Renderable{ //cast to renderable - if fail, will just skip over
            renderable.doRender(renderCommandEncoder)
    }
}
}

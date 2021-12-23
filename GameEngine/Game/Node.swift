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
    var children: [Node] = []
    
    func addChild(_ child: Node){
        children.append( child)
    }
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        //do rendering here - as of right now, game object does not have values that we can use- want to call render on the game object, but want to seperate rendering out from game object.
        for child in children{
            child.render(renderCommandEncoder: renderCommandEncoder)
            //call up to the render function for the old children, go through leaves, call render - do until each child will not have a children
        }
        if let renderable = self as? Renderable{ //cast to renderable - if fail, will just skip over
            renderable.doRender(renderCommandEncoder)
    }
     
}
    func update(deltaTime: Float){
        for child in children{
            child.update(deltaTime: deltaTime)
        }
    }
}

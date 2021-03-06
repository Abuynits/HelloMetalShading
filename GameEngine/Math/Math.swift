import MetalKit

public var X_AXIS: SIMD3<Float>{
    return SIMD3<Float>(1,0,0)
}
public var Y_AXIS: SIMD3<Float>{
    return SIMD3<Float>(0,1,0)
}
public var Z_AXIS: SIMD3<Float>{
    return SIMD3<Float>(0,0,1)
}
extension Float{
    var toRadians: Float{
        return (self/180.0)*Float.pi
    }
    var toDegrees: Float{
        return (self*(180.0/Float.pi))
    }
}
extension matrix_float4x4{
    //to do certain operations
    mutating func translate(direction: SIMD3<Float>){
        //has to be mutating bc it has to change itself
        
        var result = matrix_identity_float4x4
        
        /*
         translation matrix:
         1 0 0 0
         0 1 0 0
         0 0 1 0
         x y z 1
        
         */
        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z
        result.columns = (
        SIMD4<Float>(1,0,0,0),
        SIMD4<Float>(0,1,0,0),
        SIMD4<Float>(0,0,1,0),
        SIMD4<Float>(x,y,z,1)
        )
        //multiple self by result
        self = matrix_multiply(self, result)
    }
    mutating func scale(axis: SIMD3<Float>){
        //has to be mutating bc it has to change itself
        
        var result = matrix_identity_float4x4
        
        /*
         scale matrix:
         x 0 0 0
         0 y 0 0
         0 0 z 0
         0 0 0 1
        
         */
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        result.columns = (
        SIMD4<Float>(x,0,0,0),
        SIMD4<Float>(0,y,0,0),
        SIMD4<Float>(0,0,z,0),
        SIMD4<Float>(0,0,0,1)
        )
        //multiple self by result
        self = matrix_multiply(self, result)
    }
    mutating func rotate(angle: Float, axis: SIMD3<Float>){//take angle and axis
        //has to be mutating bc it has to change itself
        
        var result = matrix_identity_float4x4
    
    
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        let c: Float = cos(angle)
        let s: Float = sin(angle)
        
        let mc: Float = (1-c)
        
        let r1c1: Float = x*x*mc+c
        let r2c1: Float = x*y*mc+z*s
        let r3c1: Float = x*z*mc-y*s
        let r4c1: Float = 0.0
        
        let r1c2: Float = y*x*mc-z*s
        let r2c2: Float = y*y*mc+c
        let r3c2: Float = y*z*mc+x*s
        let r4c2: Float = 0.0
        
        let r1c3: Float = z*x*mc-z*s
        let r2c3: Float = z*y*mc-x*s
        let r3c3: Float = z*y*mc+c
        let r4c3: Float = 0.0
        
        let r1c4: Float = 0.0
        let r2c4: Float = 0.0
        let r3c4: Float = 0.0
        let r4c4: Float = 1.0
       
        result.columns = (
        SIMD4<Float>(r1c1,r2c1,r3c1,r4c1),
        SIMD4<Float>(r1c2,r2c2,r3c2,r4c2),
        SIMD4<Float>(r1c3,r2c3,r3c3,r4c3),
        SIMD4<Float>(r1c4,r2c4,r3c4,r4c4)
        )
        //multiple self by result
        self = matrix_multiply(self, result)
    }
    
    //https://gamedev.stackexchange.com/questions/120338/what-does-a-perspective-projection-matrix-look-like-in-opengl
        static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float)->matrix_float4x4{
            let fov = degreesFov.toRadians
            //generates new float 4x4
            //degreesFov: take a papertowel tube- look down the tube- looked zoomed in bc cut off range ( lower field of view)
            //aspect ration - anything that you want - a good common is 16 by 9- whatever display you are working on
            //anything close will be clipped- near value, far value - anythign after the far will also be clipped
            //units use is near to far - if use 1-100, we have 99 workable units
            let t: Float = tan(fov / 2)
            //this is a matrix calculation
            let x: Float = 1 / (aspectRatio * t)
            let y: Float = 1 / t
            let z: Float = -((far + near) / (far - near))
            let w: Float = -((2 * far * near) / (far - near))
            
            var result = matrix_identity_float4x4//return new matrix 4x4
            result.columns = (
                SIMD4<Float>(x,  0,  0,   0),
                SIMD4<Float>(0,  y,  0,   0),
                SIMD4<Float>(0,  0,  z,  -1),
                SIMD4<Float>(0,  0,  w,   0)
            )
            return result
        }
}

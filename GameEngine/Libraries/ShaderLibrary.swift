import MetalKit
/*
 create the jkey and value
 key= enumeration:
 will make a cache of vertex shader and freagment shader
 the value will be our own shader - make own struct
 */
enum VertexShaderTypes{//this is a key
    case Basic
}
enum FragmentShaderTypes {//this is a key
    case Basic
}

protocol Shader{//use protocol bc will make to extend
    var name: String {get}//"basic vertex  shader"
    var functionName: String {get}//what function name is in shader.metal
    var function: MTLFunction! {get}//this will be the actual function that we will do in vertex descriptor\
}

class ShaderLibrary{//library where can grab things - always exist
    public static var defaultLibrary: MTLLibrary!
    /*
     to implement cache system
     need to grab vertex shader over and over again
     will use through dictionary.
     will use the key as the enums, and the values as the basic vertex/fragment shader
     */
    private static var vertexShaderDict: [VertexShaderTypes:Shader] = [:]
    private static var fragmentShaderDict: [FragmentShaderTypes:Shader] = [:]
    public static func inittialize (){
        defaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()//add new objects to dictionaries ( our caches)
        //grab them by grabbign the vertex
    }
    //if want to add another shader - ad a type for shader, create object of shader and add it in the createDefaultShaders()
    public static func createDefaultShaders(){
        //vertex shader dict
        vertexShaderDict.updateValue(Basic_VertexShader(), forKey: .Basic)
        fragmentShaderDict.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    public static func Vertex(_ VertexShaderType: VertexShaderTypes)->MTLFunction{
        return vertexShaderDict[VertexShaderType]!.function
    }
    public static func Fragment(_ FragmentShaderType: FragmentShaderTypes)->MTLFunction{
        return fragmentShaderDict[FragmentShaderType]!.function
    }
}
//everytime call function - we go int ofunction - we grab a function and create it
public struct Basic_VertexShader: Shader {

    public var name: String = "Basic Vertex Shader"
    public var functionName: String = "basic_vertex_shader"
    public var function: MTLFunction!
    init(){
    //need library to instantiate
     function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name//when pass to gpu, can set label to the name (can be descritive)
    }
    }

public struct Basic_FragmentShader: Shader {

    public var name: String = "Basic Fragment Shader"
    public var functionName: String = "basic_fragment_shader"
    public var function: MTLFunction!
    init() {
    //need library to instantiate
    function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name//when pass to gpu, can set label to the name (can be descritive)
    }
    }

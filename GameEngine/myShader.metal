
#include <metal_stdlib>
using namespace metal;
//passing the buffer - going to take in buffer 0 ( [[]] is attribute tag -where grab info)
//device is the place from which take - device - read and write, constant, only read -
//memory layout used is float 3- use memory layout. stride of the data used

vertex float4 basic_vertex_shader(constant simd_float3 *vertices [[buffer(0)]], uint vertexID[[vertex_id]]){
    //need to return 3 individual vertexes ( not whole array)
    //use another attribute tag - vertex id (tracks the backend vertex id)- instead of hardcoding:
    return float4(vertices[vertexID],1);
    //at 0 return ptr of 0, then at 1, and then at 2- called per fragment as opposed to per vertex coding
    

}
//not pas and paraments - not use gpu - just clear screen to differnet color
fragment half4 basic_fragment_shader(){
    return half4(1);
}

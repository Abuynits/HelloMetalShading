
#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex_shader(){
    return float4(1);
}
//not pas and paraments - not use gpu - just clear screen to differnet color
fragment half4 basic_fragment_shader(){
    return half4(1);
}

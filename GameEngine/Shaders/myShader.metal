
#include <metal_stdlib>
using namespace metal;
//passing the buffer - going to take in buffer 0 ( [[]] is attribute tag -where grab info)
//device is the place from which take - device - read and write, constant, only read -
//memory layout used is float 3- use memory layout. stride of the data used

//create a similar struct to the gpu
struct vertexIn{
    simd_float3 position[[attribute(0)]];//describe position at attribute of 0
    simd_float4 color[[attribute(1)]];//indexing of the positions things are in the structures
};///bind buffer with vertexes -vertices of vertex in - return the vertex. position
//not pas and paraments - not use gpu - just clear screen to differnet color
//cannot manipulate rasterizer - off in space- anything that we return from vertex sahder will go to rasterizer and then to the fragment shader- need to make a rasterizer data object that will go off into the rasterizer
struct RasterizerData{//same thing, but the position need to use the atrtibute qualifier - anyting that goes on position will be interpolated between 3 triangle points.
    // by sayind [[position]], we are saying to not touch those values - anything else that is not marked with [[]], will be edited-need to replace the return type of vertex shader with rasterizer data
    simd_float4 position[[position]];
    simd_float4 color;
    
};
struct modelConstants{
    float4x4 modelMatrix;
};


//no longer need to take in array of vertices, just vertex
//no longer device, jsut const
// not use buffer at 0, just use stage_in - know size of the attributes
//not need vertex id, just pass in vertex
vertex RasterizerData basic_vertex_shader(const vertexIn vIn [[stage_in]],constant modelConstants &modelConstants[[buffer(1)]]){
    //need to return 3 individual vertexes ( not whole array)
    //use another attribute tag - vertex id (tracks the backend vertex id)- instead of hardcoding:
    RasterizerData r;//create rasterizer data object
    r.position=modelConstants.modelMatrix * simd_float4(vIn.position,1);//populate position
    r.color= vIn.color;//add the same atributes - create fragments for each one
    //reasterizer - figure out what color it should be
    //at 0 return ptr of 0, then at 1, and then at 2- called per fragment as opposed to per vertex coding
    return r;
}





////per pixel shading -we want to do per vertex shading - describe vertex instead of passing in vertex array - pass in 1 vertex for every pass that we do
//vertex RasterizerData basic_vertex_shader(constant vertexIn *vertices [[buffer(0)]], uint vertexID[[vertex_id]]){
//    //need to return 3 individual vertexes ( not whole array)
//    //use another attribute tag - vertex id (tracks the backend vertex id)- instead of hardcoding:
//    RasterizerData r;//create rasterizer data object
//    r.position=simd_float4(vertices[vertexID].position,1);//populate position
//    r.color= vertices[vertexID].color;//add the same atributes - create fragments for each one
//    //reasterizer - figure out what color it should be
//    //at 0 return ptr of 0, then at 1, and then at 2- called per fragment as opposed to per vertex coding
//    return r;
//}
//vertex go into rasterizer, then go into fragment shader
//need a data qualifer - do per fragment ( of the rasterizer ) - called stage in- each fragment will go through fragment shader and wil be colored. this corresponds to the [[stage_in]] - the id of the specific fragment
fragment half4 basic_fragment_shader(RasterizerData rd[[stage_in]]){
    simd_float4 color = rd.color;
    //create and return the color of the rasterizer data
    return half4(color.r,color.g,color.b,color.a);
}
/*
 go fro vertices to vertex shader to rasterizer to fragment shader
 want to also create a color array - a vertex is not just float3 - also has other data- could have color data, normals, position, texture coordiantes
    
 once call commandbuffer.commit()
 whatever bound to command encoder- shrat at vertex shader - process incoming vertex shader and map to position on the screen space
 final values that will be desplayed are in screen spaces- in vertex sahder- combine matrices that will shrink things back down
 - have basic 3 coordinates - no shape attached
 rasterizer - fixed function pipeline - vertex shader will pass data into rasterizer- figure out what pixels are around the triangle - any frgmaent that lies withing the triangle that has the center of that pixel - will be drawn the color
 0 say this fragment will be this bixel color -
 set poisiotn attribute on pisition- position once goes in rasterizer - dont want to manipulated - everything else, will be interpolated
 halfway between red ( 1,0,0) nad green  (0,1,0), we have (0.5,0.5,0) - far away from blue - now color this fragment this specific color- center will be a third of all the colors ( grey)
 this is why tirngale will look differnet - fragment wil get interpolated value- will be passed in fragment shader one at the time
 NOTE: rasterizer - just computes the colors- does not actually fill it - fragment shader actually fills it
 fragment shader - process it, change it - and then color in every pixel in the triangle
 - want to manipulte it - do in fragment shader - fragment shader - return final value - now draw triangle
 this is the render life cycle of a vertex
 very important - how draw graphics
 
 */

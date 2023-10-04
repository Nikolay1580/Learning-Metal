//
//  MyShaders.metal
//  Metals
//
//  Created by Nikolay Tsonev on 30/09/2023.
//

#include <metal_stdlib>
using namespace metal;

// metal representation of our struct
struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

// creating the rasterizerData to be given to the rasterizer
struct RasterizerData {
    float4 position [[ position ]] ;
    float4 color;
};

// changin from float3 to Vertex as otherwise the gpu does not computer it well and the triangle does not look like it should
// changin from float4 to rasterizer to be able and give color to our fragments
vertex RasterizerData basic_vertex_shader(const VertexIn Vin [[ stage_in ]] )  {
    
    RasterizerData rd;
    // this returns the same position as before but now part of the RasterizerData struct and adds a color componnet
    rd.position = float4(Vin.position, 1);
    rd.color = Vin.color;
    
    return rd;
}

// modify this to add the rasterier and be able to draw the colored fragments on the screen
// stager in tells it that every fragment will go throught the frgament shader func
fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]) {
    
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
}

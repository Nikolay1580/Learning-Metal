//
//  MyShaders.metal
//  Metals
//
//  Created by Nikolay Tsonev on 30/09/2023.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 basic_vertex_shader() {
    return float4(1);
}

fragment half4 basic_fragment_shader() {
    return half4(1);
}

//
//  shaders.metal
//  MandelbrotZoom
//
//  Created by Walt Semrau on 2/15/23.
//

#include <metal_stdlib>
using namespace metal;

struct ModelConstants{
    float4x4 parentViewMatrix;
    float4x4 modelViewMatrix;
};

struct VertexIn {
    float4 position [[attribute(0)]];
    float4 color [[attribute(1)]];
    float2 textureCoordinates [[attribute(2)]];
};

struct VertexOut{
    float4 position [[position]];
    float4 color;
    float2 textureCoordinates;
};

vertex VertexOut vertex_shader(const VertexIn vertexIn[[ stage_in ]],
                               constant ModelConstants &modelConstants [[buffer(1)]]){
    VertexOut vout;
    vout.position = modelConstants.parentViewMatrix * modelConstants.modelViewMatrix * vertexIn.position;
    vout.color = vertexIn.color;
    vout.textureCoordinates = vertexIn.textureCoordinates;
    return vout;
}

fragment half4 fragment_shader(VertexOut vertexIn [[stage_in]]){
    return half4(vertexIn.color);
}

fragment half4 textured_fragment(VertexOut vertexIn [[stage_in]],
                                 sampler sampler2d [[sampler(0)]],
                                 texture2d<float> texture [[texture(0)]]){
    float4 color = texture.sample(sampler2d, vertexIn.textureCoordinates);
    return half4(color.r, color.g, color.b, 1);
}




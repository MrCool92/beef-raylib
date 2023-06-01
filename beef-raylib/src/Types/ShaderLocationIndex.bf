using System;

namespace Raylib;

/// Shader location index
[CRepr]
public enum ShaderLocationIndex : uint32
{
    /// Shader location: vertex attribute: position
    VertexPosition = 0,
    /// Shader location: vertex attribute: texcoord01
    VertexTexcoord01,
    /// Shader location: vertex attribute: texcoord02
    VertexTexcoord02,
    /// Shader location: vertex attribute: normal
    VertexNormal,
    /// Shader location: vertex attribute: tangent
    VertexTangent,
    /// Shader location: vertex attribute: color
    VertexColor,
    /// Shader location: matrix uniform: model-view-projection
    MatrixMvp,
    /// Shader location: matrix uniform: view (camera transform)
    MatrixView,
    /// Shader location: matrix uniform: projection
    MatrixProjection,
    /// Shader location: matrix uniform: model (transform)
    MatrixModel,
    /// Shader location: matrix uniform: normal
    MatrixNormal,
    /// Shader location: vector uniform: view
    VectorView,
    /// Shader location: vector uniform: diffuse color
    ColorDiffuse,
    /// Shader location: vector uniform: specular color
    ColorSpecular,
    /// Shader location: vector uniform: ambient color
    ColorAmbient,
    /// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    MapAlbedo,
    /// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    MapMetalness,
    /// Shader location: sampler2d texture: normal
    MapNormal,
    /// Shader location: sampler2d texture: roughness
    MapRoughness,
    /// Shader location: sampler2d texture: occlusion
    MapOcclusion,
    /// Shader location: sampler2d texture: emission
    MapEmission,
    /// Shader location: sampler2d texture: height
    MapHeight,
    /// Shader location: samplerCube texture: cubemap
    MapCubemap,
    /// Shader location: samplerCube texture: irradiance
    MapIrradiance,
    /// Shader location: samplerCube texture: prefilter
    MapPrefilter,
    /// Shader location: sampler2d texture: brdf
    MapBrdf
}
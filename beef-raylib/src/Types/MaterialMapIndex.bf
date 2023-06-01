using System;

namespace Raylib;

/// Material map index
[CRepr]
public enum MaterialMapIndex : int32
{
    /// Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    Albedo = 0,
    /// Metalness material (same as: MATERIAL_MAP_SPECULAR)
    Metalness,
    /// Normal material
    Normal,
    /// Roughness material
    Roughness,
    /// Ambient occlusion material
    Occlusion,
    /// Emission material
    Emission,
    /// Heightmap material
    Height,
    /// Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    Cubemap,
    /// Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    Irradiance,
    /// Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    Prefilter,
    /// Brdf material
    Brdf
}
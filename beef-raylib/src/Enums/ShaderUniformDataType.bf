using System;

namespace Raylib;

/// Shader uniform data type
[CRepr]
public enum ShaderUniformDataType : int32
{
    /// Shader uniform type: float
    UniformFloat = 0,
    /// Shader uniform type: vec2 (2 float)
    UniformVec2,
    /// Shader uniform type: vec3 (3 float)
    UniformVec3,
    /// Shader uniform type: vec4 (4 float)
    UniformVec4,
    /// Shader uniform type: int
    UniformInt,
    /// Shader uniform type: ivec2 (2 int)
    UniformIVec2,
    /// Shader uniform type: ivec3 (3 int)
    UniformIVec3,
    /// Shader uniform type: ivec4 (4 int)
    UniformIVec4,
    /// Shader uniform type: sampler2d
    UniformSampler2d 
}

using System;

namespace Raylib;

/// Shader
[CRepr]
public struct Shader
{
    /// Shader program id
    public uint32 id;
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    public int32* locs;
}
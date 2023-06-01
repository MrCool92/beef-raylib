using System;

namespace Raylib;

/// Material, includes shader and maps
[CRepr]
public struct Material
{
    /// Material shader
    public Shader shader;
    /// Material maps array (MAX_MATERIAL_MAPS)
    public MaterialMap* maps;
    /// Material generic parameters (if required)
    public float[4] @params;
}
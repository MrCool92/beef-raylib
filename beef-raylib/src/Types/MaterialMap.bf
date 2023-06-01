using System;

namespace Raylib;

/// MaterialMap
[CRepr]
public struct MaterialMap
{
    /// Material map texture
    public Texture2D texture;
    /// Material map color
    public Color color;
    /// Material map value
    public float value;
}
using System;

namespace Raylib;

/// Camera2D, defines position/orientation in 2d space
[CRepr]
public struct Camera2D
{
    /// Camera offset (displacement from target)
    public Vector2 offset;
    /// Camera target (rotation and zoom origin)
    public Vector2 target;
    /// Camera rotation in degrees
    public float rotation;
    /// Camera zoom (scaling), should be 1.0f by default
    public float zoom;

    public this()
    {
        this.offset = .();
        this.target = .();
        this.rotation = 0;
        this.zoom = 0;
    }
}
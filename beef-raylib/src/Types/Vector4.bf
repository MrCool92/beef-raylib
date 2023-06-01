using System;

namespace Raylib;

/// Vector4, 4 components
[CRepr]
public struct Vector4
{
    /// Vector x component
    public float x;
    /// Vector y component
    public float y;
    /// Vector z component
    public float z;
    /// Vector w component
    public float w;

    public this()
    {
        this = default;
    }

    public this(float x, float y)
    {
        this.x = x;
        this.y = y;
        this.z = 0f;
        this.w = 0f;
    }

    public this(float x, float y, float z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = 0f;
    }

    public this(float x, float y, float z, float w)
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }
}
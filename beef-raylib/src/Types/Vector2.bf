using System;

namespace Raylib;

/// Vector2, 2 components
[CRepr]
public struct Vector2
{
    public const Vector2 Zero  = .(0f,  0f);
    public const Vector2 One   = .(1f,  1f);

    public const Vector2 Up    = .(0f,  1f);
    public const Vector2 Down  = .(0f, -1f);
    public const Vector2 Left  = .(-1f,  0f);
    public const Vector2 Right = .(1f,  0f);

    /// Vector x component
    public float x;
    /// Vector y component
    public float y;

    public this()
    {
        this = default;
    }

    public this(float x, float y)
    {
        this.x = x;
        this.y = y;
    }

    [Inline] public static Vector2 operator -(Vector2 left, Vector2 right)
    {
        return .(left.x - right.x, left.y - right.y);
    }

    // TODO
}
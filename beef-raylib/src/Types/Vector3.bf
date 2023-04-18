using System;

namespace Raylib;

[CRepr]
public struct Vector3
{
    public const float Epsilon = 0.00001f;

    public const Vector3 Zero    = .(0f,  0f,  0f);
    public const Vector3 One     = .(1f,  1f,  1f);

    public const Vector3 Up      = .(0f,  1f,  0f);
    public const Vector3 Down    = .(0f, -1f,  0f);
    public const Vector3 Left    = .(-1f,  0f,  0f);
    public const Vector3 Right   = .(1f,  0f,  0f);
    public const Vector3 Forward = .(0f,  0f,  1f);
    public const Vector3 Back    = .(0f,  0f, -1f);

    public float x;
    public float y;
    public float z;

    public this()
    {
        this = default;
    }

    public this(float x, float y)
    {
        this.x = x;
        this.y = y;
        this.z = 0f;
    }

    public this(float x, float y, float z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    [Inline]
    public float Magnitude => (float)Math.Sqrt(x * x + y * y + z * z);

    public Vector3 Normalized
    {
        [Inline]
        get
        {
            float magnitude = Magnitude;
            return (magnitude > Epsilon) ? this / magnitude : .Zero;
        }
    }

    [Inline]
    public void Normalize() mut
    {
        this /= Magnitude;
    }

    [Inline]
    public static Vector3 operator +(Vector3 a, Vector3 b) => .(a.x + b.x, a.y + b.y, a.z + b.z);

    [Inline]
    public static Vector3 operator -(Vector3 a, Vector3 b) => .(a.x - b.x, a.y - b.y, a.z - b.z);

    [Inline]
    public static Vector3 operator -(Vector3 a) => .(-a.x, -a.y, -a.z);

    [Inline]
    public static Vector3 operator *(Vector3 a, float b) => .(a.x * b, a.y * b, a.z * b);

    [Inline]
    public static Vector3 operator /(Vector3 a, float b) => .(a.x / b, a.y / b, a.z / b);

    [Inline]
    public static Vector3 Lerp(Vector3 a, Vector3 b, float t) => .(
        a.x + (b.x - a.x) * t,
        a.y + (b.y - a.y) * t,
        a.z + (b.z - a.z) * t
        );

    // TODO
}
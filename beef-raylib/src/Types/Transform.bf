using System;

namespace Raylib;

/// Transform, vertex transformation data
[CRepr]
public struct Transform
{
    /// Translation
    public Vector3 translation;
    /// Rotation
    public Quaternion rotation;
    /// Scale
    public Vector3 scale;
}
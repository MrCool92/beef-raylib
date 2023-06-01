using System;

namespace Raylib;

/// Ray, ray for raycasting
[CRepr]
public struct Ray
{
    /// Ray position (origin)
    public Vector3 position;
    /// Ray direction
    public Vector3 direction;
}
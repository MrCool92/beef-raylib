using System;

namespace Raylib;

/// RayCollision, ray hit information
[CRepr]
public struct RayCollision
{
    /// Did the ray hit something?
    public bool hit;
    /// Distance to the nearest hit
    public float distance;
    /// Point of the nearest hit
    public Vector3 point;
    /// Surface normal of hit
    public Vector3 normal;
}
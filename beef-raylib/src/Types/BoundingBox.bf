using System;

namespace Raylib;

/// BoundingBox
[CRepr]
public struct BoundingBox
{
    /// Minimum vertex box-corner
    public Vector3 min;
    /// Maximum vertex box-corner
    public Vector3 max;

    public this(Vector3 min, Vector3 max)
    {
        this.min = min;
        this.max = max;
    }
}
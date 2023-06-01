using System;

namespace Raylib;

/// Cubemap layouts
[CRepr]
public enum CubemapLayout : uint32
{
    /// Automatically detect layout type
    AutoDetect = 0,
    /// Layout is defined by a vertical line with faces
    LineVertical,
    /// Layout is defined by a horizontal line with faces
    LineHorizontal,
    /// Layout is defined by a 3x4 cross with cubemap faces
    CrossThreeByFour,
    /// Layout is defined by a 4x3 cross with cubemap faces
    CrossFourByThree,
    /// Layout is defined by a panorama image (equirrectangular map)
    Panorama
}
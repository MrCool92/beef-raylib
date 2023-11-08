using System;

namespace Raylib;

/// Color blending modes (pre-defined)
[CRepr]
public enum BlendMode : int32
{
    /// Blend textures considering alpha (default)
    Alpha = 0,
    /// Blend textures adding colors
    Additive,
    /// Blend textures multiplying colors
    Multiplied,
    /// Blend textures adding colors (alternative)
    AddColors,
    /// Blend textures subtracting colors (alternative)
    SubtractColors,
    /// Blend premultiplied textures considering alpha
    AlphaPremultiply,
    /// Blend textures using custom src/dst factors (use rlSetBlendFactors())
    Custom,
    /// Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
    CustomSeparate
}
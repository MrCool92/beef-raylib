using System;

namespace Raylib;

/// Texture parameters: filter mode
[CRepr]
public enum TextureFilter : int32
{
    /// No filter, just pixel approximation
    Point = 0,
    /// Linear filtering
    Bilinear,
    /// Trilinear filtering (linear with mipmaps)
    Trilinear,
    /// Anisotropic filtering 4x
    Anisotropic4x,
    /// Anisotropic filtering 8x
    Anisotropic8x,
    /// Anisotropic filtering 16x
    Anisotropic16x,
}
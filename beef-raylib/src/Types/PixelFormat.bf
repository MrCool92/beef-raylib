using System;

namespace Raylib;

/// Pixel formats
[CRepr]
public enum PixelFormat : int32
{
    /// 8 bit per pixel (no alpha)
    UncompressedGrayscale = 1,
    /// 8*2 bpp (2 channels)
    UncompressedGrayAlpha,
    /// 16 bpp
    UncompressedR5G6B5,
    /// 24 bpp
    UncompressedR8G8B8,
    /// 16 bpp (1 bit alpha)
    UncompressedR5G5B5A1,
    /// 16 bpp (4 bit alpha)
    UncompressedR4G4B4A4,
    /// 32 bpp
    UncompressedR8G8B8A8,
    /// 32 bpp (1 channel - float)
    UncompressedR32,
    /// 32*3 bpp (3 channels - float)
    UncompressedR32G32B32,
    /// 32*4 bpp (4 channels - float)
    UncompressedR32G32B32A32,
    /// 4 bpp (no alpha)
    CompressedDxt1RGB,
    /// 4 bpp (1 bit alpha)
    CompressedDxt1RGBA,
    /// 8 bpp
    CompressedDxt3RGBA,
    /// 8 bpp
    CompressedDxt5RGBA,
    /// 4 bpp
    CompressedEtc1RGB,
    /// 4 bpp
    CompressedEtc2RGB,
    /// 8 bpp
    CompressedEtc2EacRGBA,
    /// 4 bpp
    CompressedPvrtRGB,
    /// 4 bpp
    CompressedPvrtRGBA,
    /// 8 bpp
    CompressedAstc4x4RGBA,
    /// 2 bpp
    CompressedAstc8x8RGBA
}
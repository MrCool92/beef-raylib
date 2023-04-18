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
    UncompressedR5g6b5,
    /// 24 bpp
    UncompressedR8g8b8,
    /// 16 bpp (1 bit alpha)
    UncompressedR5g5b5a1,
    /// 16 bpp (4 bit alpha)
    UncompressedR4g4b4a4,
    /// 32 bpp
    UncompressedR8g8b8a8,
    /// 32 bpp (1 channel - float)
    UncompressedR32,
    /// 32*3 bpp (3 channels - float)
    UncompressedR32g32b32,
    /// 32*4 bpp (4 channels - float)
    UncompressedR32g32b32a32,
    /// 4 bpp (no alpha)
    CompressedDxt1Rgb,
    /// 4 bpp (1 bit alpha)
    CompressedDxt1Rgba,
    /// 8 bpp
    CompressedDxt3Rgba,
    /// 8 bpp
    CompressedDxt5Rgba,
    /// 4 bpp
    CompressedEtc1Rgb,
    /// 4 bpp
    CompressedEtc2Rgb,
    /// 8 bpp
    CompressedEtc2EacRgba,
    /// 4 bpp
    CompressedPvrtRgb,
    /// 4 bpp
    CompressedPvrtRgba,
    /// 8 bpp
    CompressedAstc4x4Rgba,
    /// 2 bpp
    CompressedAstc8x8Rgba
}
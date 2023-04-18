using System;

namespace Raylib;

/// Image, pixel data stored in CPU memory (RAM)
[CRepr]
public struct Image
{
    /// Image raw data
    public void* data;
    /// Image base width
    public int32 width;
    /// Image base height
    public int32 height;
    /// Mipmap levels, 1 by default
    public int32 mipmaps;
    /// Data format (PixelFormat type)
    public PixelFormat format;
}
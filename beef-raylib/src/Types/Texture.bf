using System;

namespace Raylib;

/// Texture, tex data stored in GPU memory (VRAM)
[CRepr]
public struct Texture
{
    /// OpenGL texture id
    public uint32 id;
    /// Texture base width
    public int32 width;
    /// Texture base height
    public int32 height;
    /// Mipmap levels, 1 by default
    public int32 mipmaps;
    /// Data format (PixelFormat type)
    public PixelFormat format;
}
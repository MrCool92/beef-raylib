using System;

namespace Raylib;

/// Framebuffer texture attachment type
[CRepr]
public enum rlFramebufferAttachTextureType : uint32
{
    /// Framebuffer texture attachment type: cubemap, +X side
    CubemapPositiveX = 0,
    /// Framebuffer texture attachment type: cubemap, -X side
    CubemapNegativeX,
    /// Framebuffer texture attachment type: cubemap, +Y side
    CubemapPositiveY,
    /// Framebuffer texture attachment type: cubemap, -Y side
    CubemapNegativeY,
    /// Framebuffer texture attachment type: cubemap, +Z side
    CubemapPositiveZ,
    /// Framebuffer texture attachment type: cubemap, -Z side
    CubemapNegativeZ,
    /// Framebuffer texture attachment type: texture2d
    Texture2d = 100,
    /// Framebuffer texture attachment type: renderbuffer
    Renderbuffer = 200,
}
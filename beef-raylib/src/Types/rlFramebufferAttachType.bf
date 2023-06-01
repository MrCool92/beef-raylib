using System;

namespace Raylib;

/// Framebuffer attachment type
[CRepr]
public enum rlFramebufferAttachType : uint32
{
    /// Framebuffer attachment type: color 0
    ColorChannel0 = 0,
    /// Framebuffer attachment type: color 1
    ColorChannel1,
    /// Framebuffer attachment type: color 2
    ColorChannel2,
    /// Framebuffer attachment type: color 3
    ColorChannel3,
    /// Framebuffer attachment type: color 4
    ColorChannel4,
    /// Framebuffer attachment type: color 5
    ColorChannel5,
    /// Framebuffer attachment type: color 6
    ColorChannel6,
    /// Framebuffer attachment type: color 7
    ColorChannel7,
    /// Framebuffer attachment type: depth
    Depth = 100,
    /// Framebuffer attachment type: stencil
    Stencil = 200,
}
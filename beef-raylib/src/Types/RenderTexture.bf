using System;

namespace Raylib;

/// RenderTexture, fbo for texture rendering
[CRepr]
public struct RenderTexture
{
    /// OpenGL framebuffer object id
    public uint32 id;
    /// Color buffer attachment texture
    public Texture texture;
    /// Depth buffer attachment texture
    public Texture depth;
}
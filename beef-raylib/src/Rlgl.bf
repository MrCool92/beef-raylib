using System;

namespace Raylib.Rlgl;

static
{
    // Primitive assembly draw modes
    /// GL_LINES
    public const int32 RL_LINES     = 0x0001;
    /// GL_TRIANGLES
    public const int32 RL_TRIANGLES = 0x0004;
    /// GL_QUADS
    public const int32 RL_QUADS     = 0x0007;

    // Projection matrix culling
    /// Default near cull distance
    public const double RL_CULL_DISTANCE_NEAR = 0.01;
    /// Default far cull distance
    public const double RL_CULL_DISTANCE_FAR  = 1000.0;

    // Functions Declaration - Matrix operations
    // TODO
    /// Push the current matrix to stack
    [CLink, CallingConvention(.Cdecl)] public static extern void rlPushMatrix();
    /// Pop latest inserted matrix from stack
    [CLink, CallingConvention(.Cdecl)] public static extern void rlPopMatrix();
    // TODO
    /// Multiply the current matrix by a translation matrix
    [CLink, CallingConvention(.Cdecl)] public static extern void rlTranslatef(float x, float y, float z);
    /// Multiply the current matrix by a rotation matrix
    [CLink, CallingConvention(.Cdecl)] public static extern void rlRotatef(float angle, float x, float y, float z);
    // TODO
    /// Multiply the current matrix by a scaling matrix
    [CLink, CallingConvention(.Cdecl)] public static extern void rlScalef(float x, float y, float z);
    // TODO
    /// Set the viewport area
    [CLink, CallingConvention(.Cdecl)] public static extern void rlViewport(int32 x, int32 y, int32 width, int32 height);

    // Functions Declaration - Vertex level operations
    /// Initialize drawing mode (how to organize vertex)
    [CLink, CallingConvention(.Cdecl)] public static extern void rlBegin(int32 mode);
    /// Finish vertex providing
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnd();
    // TODO
    /// Define one vertex (position) - 3 float
    [CLink, CallingConvention(.Cdecl)] public static extern void rlVertex3f(float x, float y, float z);
    /// Define one vertex (texture coordinate) - 2 float
    [CLink, CallingConvention(.Cdecl)] public static extern void rlTexCoord2f(float x, float y);
    /// Define one vertex (normal) - 3 float
    [CLink, CallingConvention(.Cdecl)] public static extern void rlNormal3f(float x, float y, float z);
    /// Define one vertex (color) - 4 byte
    [CLink, CallingConvention(.Cdecl)] public static extern void rlColor4ub(uint8 r, uint8 g, uint8 b, uint8 a);

    // Vertex buffers state

    // Textures state
    /// Select and active a texture slot
    [CLink, CallingConvention(.Cdecl)] public static extern void rlActiveTextureSlot(int32 slot);
    /// Enable texture
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnableTexture(uint32 id);
    /// Disable texture
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableTexture();
    // TODO
    /// Disable texture cubemap
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableTextureCubemap();

    // Shader state
    /// Enable shader program
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnableShader(uint32 id);
    /// Disable shader program
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableShader();

    // Framebuffer state
    /// Enable render texture (fbo)
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnableFramebuffer(uint32 id);
    /// Disable render texture (fbo), return to default framebuffer
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableFramebuffer();
    /// Activate multiple draw color buffers
    [CLink, CallingConvention(.Cdecl)] public static extern void rlActiveDrawBuffers(int32 count);

    // General render state
    // TODO
    /// Enable depth write
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnableDepthMask();
    /// Disable depth write
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableDepthMask();
    /// Enable backface culling
    [CLink, CallingConvention(.Cdecl)] public static extern void rlEnableBackfaceCulling();
    /// Disable backface culling
    [CLink, CallingConvention(.Cdecl)] public static extern void rlDisableBackfaceCulling();
    // TODO

    // TODO
    /// Clear used screen buffers (color and depth)
    [CLink, CallingConvention(.Cdecl)] public static extern void rlClearScreenBuffers();
    // TODO

    // Functions Declaration - rlgl functionality
    // TODO
    /// Get default framebuffer width
    [CLink, CallingConvention(.Cdecl)] public static extern int32 rlGetFramebufferWidth();
    // TODO
    /// Get default framebuffer height
    [CLink, CallingConvention(.Cdecl)] public static extern int32 rlGetFramebufferHeight();

    // Render batch management
    /// Set current texture for render batch and check buffers limits
    [CLink, CallingConvention(.Cdecl)] public static extern void rlSetTexture(uint32 id);
    // TODO
    /// Check internal buffer overflow for a given number of vertex
    [CLink, CallingConvention(.Cdecl)] public static extern bool rlCheckRenderBatchLimit(int32 vCount);

    // Vertex buffers management

    // Textures management
    //TODO
    /// Load depth texture/renderbuffer (to be attached to fbo)
    [CLink, CallingConvention(.Cdecl)] public static extern uint32 rlLoadTextureDepth(int32 width, int32 height, bool useRenderBuffer);
    /// Load texture cubemap
    [CLink, CallingConvention(.Cdecl)] public static extern uint32 rlLoadTextureCubemap(void* data, int32 size, PixelFormat format);
    //TODO

    // Framebuffer management (fbo)
    /// Load an empty framebuffer
    [CLink, CallingConvention(.Cdecl)] public static extern uint32 rlLoadFramebuffer(int32 width, int32 height);
    /// Attach texture/renderbuffer to a framebuffer
    [CLink, CallingConvention(.Cdecl)] public static extern void rlFramebufferAttach(uint32 fboId, uint32 texId, rlFramebufferAttachType attachType, rlFramebufferAttachTextureType texType, int32 mipLevel);
    /// Verify framebuffer is complete
    [CLink, CallingConvention(.Cdecl)] public static extern bool rlFramebufferComplete(uint32 id);
    /// Delete framebuffer from GPU
    [CLink, CallingConvention(.Cdecl)] public static extern void rlUnloadFramebuffer(uint32 id);

    // Shaders management
    // TODO
    /// Set shader value matrix
    [CLink, CallingConvention(.Cdecl)] public static extern void rlSetUniformMatrix(int32 locIndex, Matrix mat);
    // TODO

    // Compute shader management

    // Shader buffer storage object management (ssbo)

    // Buffer management

    // Matrix state management

    // Quick and dirty cube/quad buffers load->draw->unload
    /// Load and draw a cube
    [CLink, CallingConvention(.Cdecl)] public static extern void rlLoadDrawCube();
    /// Load and draw a quad
    [CLink, CallingConvention(.Cdecl)] public static extern void rlLoadDrawQuad();
}
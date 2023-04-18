using System;

namespace Raylib;

/// Camera, defines position/orientation in 3d space
[CRepr]
public struct Camera3D
{
    /// Camera position
    public Vector3 position;
    /// Camera target it looks-at
    public Vector3 target;
    /// Camera up vector (rotation over its axis)
    public Vector3 up;
    /// Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
    public float fovy;
    /// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    public CameraProjection projection;

    public this()
    {
        this.position = .();
        this.target = .();
        this.up = .Up;
        this.fovy = 60;
        this.projection = .Perspective;
    }
}
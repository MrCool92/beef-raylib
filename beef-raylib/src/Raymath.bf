using System;

namespace Raylib.Raymath;

static
{
    /// Clamp the components of the vector between
    [CLink, CallingConvention(.Cdecl)] public static extern Vector2 Vector2Clamp(Vector2 v, Vector2 min, Vector2 max);

    /// Calculate distance between two vectors
    [CLink, CallingConvention(.Cdecl)] public static extern float Vector3Distance(Vector3 v1, Vector3 v2);

    /// Get translation matrix
    [CLink, CallingConvention(.Cdecl)] public static extern Matrix MatrixTranslate(float x, float y, float z);

    /// Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
    [CLink, CallingConvention(.Cdecl)] public static extern Vector3 Vector3Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c);

    /// Get perspective projection matrix
    [CLink, CallingConvention(.Cdecl)] public static extern Matrix MatrixPerspective(double fovy, double aspect, double near, double far);

    // Get camera look-at matrix (view matrix)
    [CLink, CallingConvention(.Cdecl)] public static extern Matrix MatrixLookAt(Vector3 eye, Vector3 target, Vector3 up);

    // Get xyz-rotation matrix
    [CLink, CallingConvention(.Cdecl)] public static extern Matrix MatrixRotateXYZ(Vector3 angle);
}
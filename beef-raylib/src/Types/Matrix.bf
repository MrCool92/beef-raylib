using System;

namespace Raylib;

/// Matrix, 4x4 components, column major, OpenGL style, right-handed
[CRepr]
public struct Matrix
{
    /// Matrix first row (4 components)
    float m0, m4, m8, m12;
    /// Matrix second row (4 components)
    float m1, m5, m9, m13;
    /// Matrix third row (4 components)
    float m2, m6, m10, m14;
    /// Matrix fourth row (4 components)
    float m3, m7, m11, m15;
}
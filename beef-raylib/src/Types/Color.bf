using System;

namespace Raylib;

/// Color, 4 components, R8G8B8A8 (32bit)
[CRepr]
public struct Color
{
    // Some Basic Colors
    public const Color LightGray  = .(200, 200, 200, 255);
    public const Color Gray		  = .(130, 130, 130, 255);
    public const Color DarkGray	  = .(80,  80,  80, 255);
    public const Color Yellow	  = .(253, 249,   0, 255);
    public const Color Gold		  = .(255, 203,   0, 255);
    public const Color Orange	  = .(255, 161,   0, 255);
    public const Color Pink		  = .(255, 109, 194, 255);
    public const Color Red		  = .(230,  41,  55, 255);
    public const Color Maroon	  = .(190,  33,  55, 255);
    public const Color Green	  = .(  0, 228,  48, 255);
    public const Color Lime		  = .(  0, 158,  47, 255);
    public const Color DarkGreen  = .(  0, 117,  44, 255);
    public const Color SkyBlue 	  = .(102, 191, 255, 255);
    public const Color Blue		  = .(  0, 121, 241, 255);
    public const Color DarkBlue	  = .(  0,  82, 172, 255);
    public const Color Purple	  = .(200, 122, 255, 255);
    public const Color Violet	  = .(135,  60, 190, 255);
    public const Color DarkPurple = .(112,  31, 126, 255);
    public const Color Beige	  = .(211, 176, 131, 255);
    public const Color Brown	  = .(127, 106,  79, 255);
    public const Color DarkBrown  = .(76,  63,  47, 255);
    public const Color White	  = .(255, 255, 255, 255);
    public const Color Black      = .(  0,   0,   0, 255);
    /// Blank (Transparent)
    public const Color Blank	  = .(  0,   0,   0,   0);
    public const Color Magenta	  = .(255,   0, 255, 255);
    /// My own White raylib logo
    public const Color RayWhite   = .(245, 245, 245, 255);

    public uint8 r;
    public uint8 g;
    public uint8 b;
    public uint8 a;

    public this(uint8 r, uint8 g, uint8 b, uint8 a)
    {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }

    // TODO
}

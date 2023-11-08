namespace Raylib.Textures;

static
{
    /// Get a Color struct from hexadecimal value
    public static Color GetColor(uint32 hexValue)
    {
        Color color;

        color.r = (uint8)(hexValue >> 24) & 0xFF;
        color.g = (uint8)(hexValue >> 16) & 0xFF;
        color.b = (uint8)(hexValue >> 8) & 0xFF;
        color.a = (uint8)hexValue & 0xFF;

        return color;
    }
}
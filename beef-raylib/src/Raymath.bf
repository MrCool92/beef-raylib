using System;

namespace Raylib;

static
{
    // Clamp the components of the vector between
    [CLink] public static extern Vector2 Vector2Clamp(Vector2 v, Vector2 min, Vector2 max);
}
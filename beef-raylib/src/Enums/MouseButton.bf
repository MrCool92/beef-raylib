using System;

namespace Raylib;

/// Mouse buttons
[CRepr]
public enum MouseButton : int32
{
    /// Mouse button left
    Left = 0,
    /// Mouse button right
    Right = 1,
    /// Mouse button middle (pressed wheel)
    Middle = 2,
    /// Mouse button side (advanced mouse device)
    Side = 3,
    /// Mouse button extra (advanced mouse device)
    Extra = 4,
    /// Mouse button forward (advanced mouse device)
    Forward = 5,
    /// Mouse button back (advanced mouse device)
    Back = 6
}
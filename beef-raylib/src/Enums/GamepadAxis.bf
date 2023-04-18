using System;

namespace Raylib;

/// Gamepad axis
[CRepr]
public enum GamepadAxis : int32
{
    /// Gamepad left stick X axis
    LeftX = 0,
    /// Gamepad left stick Y axis
    LeftY = 1,
    /// Gamepad right stick X axis
    RightX = 2,
    /// Gamepad right stick Y axis
    RightY = 3,
    /// Gamepad back trigger left, pressure level: [1..-1]
    LeftTrigger = 4,
    /// Gamepad back trigger right, pressure level: [1..-1]
    RightTrigger = 5
}
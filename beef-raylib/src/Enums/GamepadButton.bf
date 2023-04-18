using System;

namespace Raylib;

/// Gamepad buttons
[CRepr]
public enum GamepadButton : int32
{
    /// Unknown button, just for error checking
    Unknown = 0,
    /// Gamepad left DPAD up button
    LeftFaceUp,
    /// Gamepad left DPAD right button
    LeftFaceRight,
    /// Gamepad left DPAD down button
    LeftFaceDown,
    /// Gamepad left DPAD left button
    LeftFaceLeft,
    /// Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    RightFaceUp,
    /// Gamepad right button right (i.e. PS3: Square, Xbox: X)
    RightFaceRight,
    /// Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    RightFaceDown,
    /// Gamepad right button left (i.e. PS3: Circle, Xbox: B)
    RightFaceLeft,
    /// Gamepad top/back trigger left (first), it could be a trailing button
    LeftTrigger1,
    /// Gamepad top/back trigger left (second), it could be a trailing button
    LeftTrigger2,
    /// Gamepad top/back trigger right (one), it could be a trailing button
    RightTrigger1,
    /// Gamepad top/back trigger right (second), it could be a trailing button
    RightTrigger2,
    /// Gamepad center buttons, left one (i.e. PS3: Select)
    MiddleLeft,
    /// Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    Middle,
    /// Gamepad center buttons, right one (i.e. PS3: Start)
    MiddleRight,
    /// Gamepad joystick pressed button left
    LeftThumb,
    /// Gamepad joystick pressed button right
    RightThumb
}
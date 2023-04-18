using System;

namespace Raylib;

/// Camera system modes
[CRepr]
public enum CameraMode : int32
{
    /// Custom camera
    Custom = 0,
    /// Free camera
    Free,
    /// Orbital camera
    Orbital,
    /// First person camera
    FirstPerson,
    /// Third person camera
    ThirdPerson
}
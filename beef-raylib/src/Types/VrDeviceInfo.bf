using System;

namespace Raylib;

/// VrDeviceInfo, Head-Mounted-Display device parameters
[CRepr]
public struct VrDeviceInfo
{
    /// Horizontal resolution in pixels
    public int32 hResolution;
    /// Vertical resolution in pixels
    public int32 vResolution;
    /// Horizontal size in meters
    public float hScreenSize;
    /// Vertical size in meters
    public float vScreenSize;
    /// Screen center in meters
    public float vScreenCenter;
    /// Distance between eye and display in meters
    public float eyeToScreenDistance;
    /// Lens separation distance in meters
    public float lensSeparationDistance;
    /// IPD (distance between pupils) in meters
    public float interpupillaryDistance;
    /// Lens distortion constant parameters
    public float[4] lensDistortionValues;
    /// Chromatic aberration correction parameters
    public float[4] chromaAbCorrection;
}
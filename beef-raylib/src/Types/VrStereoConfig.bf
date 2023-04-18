using System;

namespace Raylib;

/// VrStereoConfig, VR stereo rendering configuration for simulator
[CRepr]
public struct VrStereoConfig
{
    /// VR projection matrices (per eye)
    public Matrix[2] projection;
    /// VR view offset matrices (per eye)
    public Matrix[2] viewOffset;
    /// VR left lens center
    public float[2] leftLensCenter;
    /// VR right lens center
    public float[2] rightLensCenter;
    /// VR left screen center
    public float[2] leftScreenCenter;
    /// VR right screen center
    public float[2] rightScreenCenter;
    /// VR distortion scale
    public float[2] scale;
    /// VR distortion scale in
    public float[2] scaleIn;
}
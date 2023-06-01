using System;

namespace Raylib;

/// ModelAnimation
[CRepr]
public struct ModelAnimation
{
    /// Number of bones
    public int32 boneCount;
    /// Number of animation frames
    public int32 frameCount;
    /// Bones information (skeleton)
    public BoneInfo* bones;
    /// Poses array by frame
    public Transform** framePoses;
}

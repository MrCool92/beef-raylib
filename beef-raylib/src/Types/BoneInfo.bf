using System;

namespace Raylib;

/// Bone, skeletal animation bone
[CRepr]
public struct BoneInfo
{
    /// Bone name
    public char8[32] name;
    /// Bone parent
    public int32 parent;
}
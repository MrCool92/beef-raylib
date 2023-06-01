using System;

namespace Raylib;

/// Model, meshes, materials and animation data
[CRepr]
public struct Model
{
    /// Local transform matrix
    public Matrix transform;

    /// Number of meshes
    public int32 meshCount;
    /// Number of materials
    public int32 materialCount;
    /// Meshes array
    public Mesh* meshes;
    /// Materials array
    public Material* materials;
    /// Mesh material number
    public int* meshMaterial;

    // Animation data
    /// Number of bones
    public int32 boneCount;
    /// Bones information (skeleton)
    public BoneInfo* bones;
    /// Bones base transformation (pose)
    public Transform* bindPose;
}
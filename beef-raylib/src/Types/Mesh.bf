using System;

namespace Raylib;

/// Mesh, vertex data and vao/vbo
[CRepr]
public struct Mesh
{
    /// Number of vertices stored in arrays
    public int32 vertexCount;
    /// Number of triangles stored (indexed or not)
    public int32 triangleCount;

    // Vertex attributes data
    /// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    public float* vertices;
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    public float* texcoords;
    /// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    public float* texcoords2;
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    public float* normals;
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    public float* tangents;
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    public uint8* colors;
    /// Vertex indices (in case vertex data comes indexed)
    public uint16* indices;

    // Animation vertex data
    /// Animated vertex positions (after bones transformations)
    public float* animVertices;
    /// Animated normals (after bones transformations)
    public float* animNormals;
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    public uint8* boneIds;
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    public float* boneWeights;

    // OpenGL identifiers
    /// OpenGL Vertex Array Object id
    public uint32 vaoId;
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    public uint* vboId;
}
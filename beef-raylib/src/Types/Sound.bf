using System;

namespace Raylib;

/// Sound
[CRepr]
public struct Sound
{
    /// Audio stream
    public AudioStream stream;
    /// Total number of frames (considering channels)
    public uint32 frameCount;
}
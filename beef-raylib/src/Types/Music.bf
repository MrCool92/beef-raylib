using System;

namespace Raylib;

/// Music, audio stream, anything longer than ~10 seconds should be streamed
[CRepr]
public struct Music
{
    /// Audio stream
    public AudioStream stream;
    /// Total number of frames (considering channels)
    public uint32 frameCount;
    /// Music looping enable
    public bool looping;

    /// Type of music context (audio filetype)
    public int32 ctxType;
    /// Audio context data, depends on type
    public void* ctxData;
}
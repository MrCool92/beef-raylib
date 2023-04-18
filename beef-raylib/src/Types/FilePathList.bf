using System;

namespace Raylib;

/// File path list
[CRepr]
public struct FilePathList
{
    /// Filepaths max entries
    public uint32 capacity;
    /// Filepaths entries count
    public uint32 count;
    /// Filepaths entries
    public char8** paths;                   
}
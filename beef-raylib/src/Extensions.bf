using System;

namespace Raylib.Beef;

static
{
    // Files management functions
    /// Load file data as byte array (read)
    [Inline] public static Span<uint8> LoadFileDataBf(char8* fileName)
    {
        uint32 bytesRead = 0;
        return .(LoadFileData(fileName, ref bytesRead), bytesRead);
    }

    /// Unload file data allocated by LoadFileDataEx()
    [Inline] public static void UnloadFileDataBf(Span<uint8> data)
    {
        UnloadFileData(data.Ptr);
    }

    /// Save data to file from byte array (write), returns true on success
    [Inline] public static bool SaveFileDataBf(char8* fileName, Span<uint8> data)
    {
        return SaveFileData(fileName, data.Ptr, (uint32)data.Length);
    }
}
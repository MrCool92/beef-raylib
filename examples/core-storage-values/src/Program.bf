/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_storage_values.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_storage_values;

public static
{
    public const String STORAGE_DATA_FILE = "storage.data";
}

public enum StorageData : int
{
    Score     = 0,
    Highscore = 1
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - storage save/load values");
        defer CloseWindow();

        SetTargetFPS(60);

        int score = 0;
        int highscore = 0;
        int framesCounter = 0;

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.R))
            {
                score = GetRandomValue(1000, 2000);
                highscore = GetRandomValue(2000, 4000);
            }

            if (IsKeyPressed(.Enter))
            {
                SaveStorageValue(.Score, score);
                SaveStorageValue(.Highscore, highscore);
            }
            else if (IsKeyPressed(.Space))
            {
                score = LoadStorageValue(.Score);
                highscore = LoadStorageValue(.Highscore);
            }

            framesCounter++;
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText(TextFormat("SCORE: %i", score), 280, 130, 40, .Maroon);
            DrawText(TextFormat("HI-SCORE: %i", highscore), 210, 200, 50, .Black);

            DrawText(TextFormat("frames: %i", framesCounter), 10, 10, 20, .Lime);

            DrawText("Press R to generate random numbers", 220, 40, 20, .LightGray);
            DrawText("Press ENTER to SAVE values", 250, 310, 20, .LightGray);
            DrawText("Press SPACE to LOAD values", 252, 350, 20, .LightGray);
        }

        return 0;
    }

    public static bool SaveStorageValue(StorageData position, int value)
    {
        bool success = false;

        Span<uint8> fileData = LoadFileDataEx(STORAGE_DATA_FILE);
        defer UnloadFileDataEx(fileData);

        if (!fileData.IsNull)
        {
            int newDataSize = 0;
            Span<uint8> newFileData = .();

            if (fileData.Length <= ((int)position * sizeof(int)))
            {
                newDataSize = (int)(position + 1) * sizeof(int);
                newFileData = new uint8[newDataSize];
                defer:: delete newFileData.Ptr;
                fileData.CopyTo(newFileData);

                if (!newFileData.IsNull)
                {
                    int* dataPtr = (int*)newFileData.Ptr;
                    dataPtr[(int)position] = value;
                }
                else
                {
                    TraceLog(.Warning, "FILEIO: [%s] Failed to realloc data (%u), position in bytes (%u) bigger than actual file size", STORAGE_DATA_FILE, fileData.Length, (int)position * sizeof(int));

                    newFileData = fileData;
                    newDataSize = fileData.Length;
                }
            }
            else
            {
                newFileData = fileData;
                newDataSize = fileData.Length;

                int* dataPtr = (int*)newFileData.Ptr;
                dataPtr[(int)position] = value;
            }

            success = SaveFileDataEx(STORAGE_DATA_FILE, newFileData);
            TraceLog(.Info, "FILEIO: [%s] Saved storage value: %i", STORAGE_DATA_FILE, value);
        }
        else
        {
            TraceLog(.Info, "FILEIO: [%s] File created successfully", STORAGE_DATA_FILE);

            int dataSize = (int)(position + 1) * sizeof(int);
            fileData = new uint8[dataSize];
            defer delete fileData.Ptr;

            int* dataPtr = (int*)fileData.Ptr;
            dataPtr[(int)position] = value;

            success = SaveFileDataEx(STORAGE_DATA_FILE, fileData);
            TraceLog(.Info, "FILEIO: [%s] Saved storage value: %i", STORAGE_DATA_FILE, value);
        }

        return success;
    }

    public static int LoadStorageValue(StorageData position)
    {
        int value = 0;

        Span<uint8> fileData = LoadFileDataEx(STORAGE_DATA_FILE);
        defer UnloadFileData(fileData.Ptr);

        if (!fileData.IsNull)
        {
            if (fileData.Length < ((int)position * 4))
                TraceLog(.Warning, "FILEIO: [%s] Failed to find storage position: %i", STORAGE_DATA_FILE, position);
            else
            {
                int* dataPtr = (int*)fileData.Ptr;
                value = dataPtr[(int)position];
            }

            TraceLog(.Info, "FILEIO: [%s] Loaded storage value: %i", STORAGE_DATA_FILE, value);
        }

        return value;
    }
}
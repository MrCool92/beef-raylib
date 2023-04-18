/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_drop_files.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*        - moved path allocation on drop event
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing original example
* 
********************************************************************************************/

using System;
using System.Collections;
using Raylib;

namespace core_drop_files;

public static
{
    public const int MAX_FILEPATH_RECORDED = 4096;
    public const int MAX_FILEPATH_SIZE = 2048;
}

class Program
{
    private static List<String> filePaths = new List<String>(MAX_FILEPATH_RECORDED) ~ DeleteContainerAndItems!(_);

    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - drop files");
        defer CloseWindow();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsFileDropped())
            {
                FilePathList droppedFiles = LoadDroppedFiles();
                defer UnloadDroppedFiles(droppedFiles);

                for (int i = 0; i < droppedFiles.count; i++)
                {
                    if (filePaths.Count < MAX_FILEPATH_RECORDED)
                    {
                        String file = new String(droppedFiles.paths[i]);
                        filePaths.Add(file);
                    }
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            if (filePaths.Count == 0)
                DrawText("Drop your files to this window!", 100, 40, 20, .DarkGray);
            else
            {
                DrawText("Dropped files:", 100, 40, 20, .DarkGray);
                for (int i = 0; i < filePaths.Count; i++)
                {
                    DrawRectangle(0, (int32)(85 + 40 * i), screenWidth, 40, Fade(.LightGray, (i % 2 == 0) ? 0.5f :  0.3f));
                    DrawText(filePaths[i], 120, (int32)(100 + 40 * i), 10, .Gray);
                }
                DrawText("Drop new files...", 100, (int32)(110 + 40 * filePaths.Count), 20, .DarkGray);
            }
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_window_should_close.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_window_should_close;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - window should close");
        defer CloseWindow();

        SetExitKey(.Null);

        bool exitWindowRequested = false;
        bool exitWindow = false;

        SetTargetFPS(60);

        while (!exitWindow)
        {
            if (WindowShouldClose() || IsKeyPressed(.Space))
                exitWindowRequested = true;

            if (exitWindowRequested)
            {
                if (IsKeyPressed(.Y))
                    exitWindow = true;
                else if (IsKeyPressed(.N))
                    exitWindowRequested = false;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            if (exitWindowRequested)
            {
                DrawRectangle(0, 100, screenWidth, 200, .Black);
                DrawText("Are you sure you want to exit program? [Y/N]", 40, 180, 30, .White);
            }
            else
                DrawText("Try to close the window to get confirmation message!", 120, 200, 20, .LightGray);
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_basic_window.c
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

namespace core_basic_window;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
        defer CloseWindow();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);
            DrawText("Congrats! You created your first window!", 190, 200, 20, .LightGray);
        }
        return 0;
    }
}
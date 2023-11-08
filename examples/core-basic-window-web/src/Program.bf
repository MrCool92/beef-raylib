/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_basic_window_web.c
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

namespace core_basic_window_web;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
        defer CloseWindow();

        SetTargetFPS(60);

#if BF_PLATFORM_WASM
        // TODO
        emscripten_set_main_loop(UpdateDrawFrame, 0, 1);
#else
        while (!WindowShouldClose())
        {
            UpdateDrawFrame();
        }

        return 0;
    }
#endif

    public static void UpdateDrawFrame()
    {
        BeginDrawing();
        defer EndDrawing();

        ClearBackground(.RayWhite);
        DrawText("Congrats! You created your first window!", 190, 200, 20, .LightGray);
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_mouse_wheel.c
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

namespace core_input_mouse_wheel;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - input mouse wheel");
        defer CloseWindow();

        int32 boxPositionY = screenHeight / 2 - 40;
        int scrollSpeed = 4;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            boxPositionY -= (int32)(GetMouseWheelMove() * scrollSpeed);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawRectangle(screenWidth / 2 - 40, boxPositionY, 80, 80, .Maroon);

            DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, .Gray);
            DrawText(TextFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, .LightGray);
        }

        return 0;
    }
}
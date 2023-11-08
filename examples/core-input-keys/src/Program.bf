/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_keys.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_input_keys;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - keyboard input");
        defer CloseWindow();

        SetTargetFPS(60);

        Vector2 ballPosition = .((float)screenWidth / 2, (float)screenHeight / 2);

        while (!WindowShouldClose())
        {
            if (IsKeyDown(.Right))
                ballPosition.x += 2f;
            if (IsKeyDown(.Left))
                ballPosition.x -= 2f;
            if (IsKeyDown(.Up))
                ballPosition.y -= 2f;
            if (IsKeyDown(.Down))
                ballPosition.y += 2f;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);
            DrawText("move the ball with arrow keys", 10, 10, 20, .DarkGray);
            DrawCircleV(ballPosition, 50, .Maroon);
        }

        return 0;
    }
}
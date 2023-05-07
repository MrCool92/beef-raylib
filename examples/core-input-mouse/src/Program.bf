/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_mouse.c
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

namespace core_input_mouse;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - mouse input");
        defer CloseWindow();

        SetTargetFPS(60);

        Vector2 ballPosition = Vector2(-100f, -100f);
        Color ballColor = .DarkBlue;

        while (!WindowShouldClose())
        {
            ballPosition = GetMousePosition();

            if (IsMouseButtonPressed(.Left))
                ballColor = .Maroon;
            else if (IsMouseButtonPressed(.Middle))
                ballColor = .Lime;
            else if (IsMouseButtonPressed(.Right))
                ballColor = .DarkBlue;
            else if (IsMouseButtonPressed(.Side))
                ballColor = .Purple;
            else if (IsMouseButtonPressed(.Extra))
                ballColor = .Yellow;
            else if (IsMouseButtonPressed(.Forward))
                ballColor = .Orange;
            else if (IsMouseButtonPressed(.Back))
                ballColor = .Beige;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawCircleV(ballPosition, 40, ballColor);

            DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, .DarkGray);
        }

        return 0;
    }
}
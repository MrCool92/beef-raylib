/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_random_values.c
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

namespace core_random_values;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - generate random values");
        defer CloseWindow();

        SetTargetFPS(60);

        int randValue = GetRandomValue(-8, 5);
        int framesCounter = 0;

        while (!WindowShouldClose())
        {
            framesCounter++;
            if ((framesCounter / 120) % 2 == 1)
            {
                randValue = GetRandomValue(-8, 5);
                framesCounter = 0;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText("Every 2 seconds a new random value is generated:", 130, 100, 20, .Maroon);
            DrawText(TextFormat("%i", randValue), 360, 180, 80, .LightGray);
        }

        return 0;
    }
}
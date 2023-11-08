/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_scissor_test.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Chris Dill (@MysteriousSpace) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_scissor_test;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - scissor test");
        defer CloseWindow();

        SetTargetFPS(60);

        Rectangle scissorArea = Rectangle(0f, 0f, 300f, 300f);
        bool scissorMode = true;

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.S))
                scissorMode = !scissorMode;

            scissorArea.x = GetMouseX() - scissorArea.width / 2;
            scissorArea.y = GetMouseY() - scissorArea.height / 2;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            SM:
            {
                if (scissorMode)
                {
                    BeginScissorMode((int32)scissorArea.x, (int32)scissorArea.y, (int32)scissorArea.width, (int32)scissorArea.height);
                    defer:SM EndScissorMode();
                }

                DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), .Red);
                DrawText("Move the mouse around to reveal this text!", 190, 200, 20, .LightGray);
            }

            DrawRectangleLinesEx(scissorArea, 1, .Black);
            DrawText("Press S to toggle scissor test", 10, 10, 20, .Black);
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_custom_frame_control.c
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

namespace core_custom_frame_control;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - custom frame control");
        defer CloseWindow();

        double previousTime = GetTime();
        double currentTime = 0;
        double updateDrawTime = 0;
        double waitTime = 0;
        float deltaTime = 0f;

        float timeCounter = 0f;
        float position = 0f;
        bool pause = false;

        int targetFPS = 60;

        while (!WindowShouldClose())
        {
            PollInputEvents();

            if (IsKeyPressed(.Space))
                pause = !pause;

            if (IsKeyPressed(.Up))
                targetFPS += 20;
            else if (IsKeyPressed(.Down))
                targetFPS -= 20;

            if (targetFPS < 0)
                targetFPS = 0;

            if (!pause)
            {
                position += 200 * deltaTime;
                if (position >= GetScreenWidth())
                    position = 0;
                timeCounter += deltaTime;
            }

            BeginDrawing();

            ClearBackground(.RayWhite);

            for (int32 i = 0; i < GetScreenWidth() / 200; i++)
                DrawRectangle(200 * i, 0, 1, GetScreenHeight(), .SkyBlue);

            DrawCircle((int32)position, GetScreenHeight() / 2 - 25, 50, .Red);

            DrawText(TextFormat("%03.0f ms", timeCounter * 1000f), (int32)position - 40, GetScreenHeight() / 2 - 100, 20, .Maroon);
            DrawText(TextFormat("PosX: %03.0f", position), (int32)position - 50, GetScreenHeight() / 2 + 40, 20, .Black);

            DrawText("Circle is moving at a constant 200 pixels/sec,\nindependently of the frame rate.", 10, 10, 20, .DarkGray);
            DrawText("PRESS SPACE to PAUSE MOVEMENT", 10, GetScreenHeight() - 60, 20, .Gray);
            DrawText("PRESS UP | DOWN to CHANGE TARGET FPS", 10, GetScreenHeight() - 30, 20, .Gray);
            DrawText(TextFormat("TARGET FPS: %i", targetFPS), GetScreenWidth() - 220, 10, 20, .Lime);
            DrawText(TextFormat("CURRENT FPS: %i", (int)(1f / deltaTime)), GetScreenWidth() - 220, 40, 20, .Green);

            EndDrawing();

            SwapScreenBuffer();

            currentTime = GetTime();
            updateDrawTime = currentTime - previousTime;

            if (targetFPS > 0)
            {
                waitTime = (1f / (float)targetFPS) - updateDrawTime;
                if (waitTime > 0.0)
                {
                    WaitTime((float)waitTime);
                    currentTime = GetTime();
                    deltaTime = (float)(currentTime - previousTime);
                }
            }
            else deltaTime = (float)updateDrawTime;

            previousTime = currentTime;
        }

        return 0;
    }
}
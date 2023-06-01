/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_multitouch.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Berni (@Berni8k) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_input_multitouch;

public static
{
    public const int MAX_TOUCH_POINTS = 10;
}

// TODO: test
class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - input multitouch");
        defer CloseWindow();

        SetTargetFPS(60);

        Vector2[] touchPositions = scope Vector2[MAX_TOUCH_POINTS]();

        while (!WindowShouldClose())
        {
            int tCount = GetTouchPointCount();
            if (tCount > MAX_TOUCH_POINTS)
                tCount = MAX_TOUCH_POINTS;

            for (int i < tCount)
                touchPositions[i] = GetTouchPosition((int32)i);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            for (int i < tCount)
            {
                if ((touchPositions[i].x > 0) && (touchPositions[i].y > 0))
                {
                    DrawCircleV(touchPositions[i], 34, .Orange);
                    DrawText(TextFormat("%d", i), (int32)touchPositions[i].x - 10, (int32)touchPositions[i].y - 70, 40, .Black);
                }
            }

            DrawText("touch the screen at multiple locations to get multiple balls", 10, 10, 20, .DarkGray);
        }

        return 0;
    }
}
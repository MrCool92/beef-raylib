/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_window_flags.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored state toggling/drawing
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_window_flags;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - window flags");
        defer CloseWindow();

        Vector2 ballPosition = .(GetScreenWidth() / 2f, GetScreenHeight() / 2f);
        Vector2 ballSpeed = .(5f, 4f);
        float ballRadius = 20f;

        int framesCounter = 0;

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.F))
                ToggleFullscreen();

            if (IsKeyPressed(.R))
                ToggleWindowState(.WindowResizable);

            if (IsKeyPressed(.D))
                ToggleWindowState(.WindowUndecorated);

            if (IsKeyPressed(.H))
            {
                if (!IsWindowState(.WindowHidden))
                    SetWindowState(.WindowHidden);

                framesCounter = 0;
            }

            if (IsWindowState(.WindowHidden))
            {
                framesCounter++;
                if (framesCounter >= 240)
                    ClearWindowState(.WindowHidden);
            }

            if (IsKeyPressed(.N))
            {
                if (!IsWindowState(.WindowMinimized))
                    MinimizeWindow();

                framesCounter = 0;
            }

            if (IsWindowState(.WindowMinimized))
            {
                framesCounter++;
                if (framesCounter >= 240)
                    RestoreWindow();
            }

            if (IsKeyPressed(.M))
            {
                if (IsWindowState(.WindowMaximized))
                    RestoreWindow();
                else
                    MaximizeWindow();
            }

            if (IsKeyPressed(.U))
                ToggleWindowState(.WindowUnfocused);

            if (IsKeyPressed(.T))
                ToggleWindowState(.WindowTopmost);

            if (IsKeyPressed(.A))
                ToggleWindowState(.WindowAlwaysRun);

            if (IsKeyPressed(.V))
                ToggleWindowState(.VsyncHint);

            ballPosition.x += ballSpeed.x;
            ballPosition.y += ballSpeed.y;
            if ((ballPosition.x >= (GetScreenWidth() - ballRadius)) || (ballPosition.x <= ballRadius))
                ballSpeed.x *= -1.0f;
            if ((ballPosition.y >= (GetScreenHeight() - ballRadius)) || (ballPosition.y <= ballRadius))
                ballSpeed.y *= -1.0f;

            BeginDrawing();
            defer EndDrawing();

            if (IsWindowState(.WindowTransparent))
                ClearBackground(.Blank);
            else
                ClearBackground(.RayWhite);

            DrawCircleV(ballPosition, ballRadius, .Maroon);
            DrawRectangleLinesEx(.(0, 0, (float)GetScreenWidth(), (float)GetScreenHeight()), 4, .RayWhite);

            DrawCircleV(GetMousePosition(), 10, .DarkBlue);

            DrawFPS(10, 10);

            DrawText(TextFormat("Screen Size: [%i, %i]", GetScreenWidth(), GetScreenHeight()), 10, 40, 10, .Green);

            DrawText("Following flags can be set after window creation:", 10, 60, 10, .Gray);
            DrawWindowState("[F] FLAG_FULLSCREEN_MODE",    .FullscreenMode,     80);
            DrawWindowState("[R] FLAG_WINDOW_RESIZABLE",   .WindowResizable,   100);
            DrawWindowState("[D] FLAG_WINDOW_UNDECORATED", .WindowUndecorated, 120);
            DrawWindowState("[H] FLAG_WINDOW_HIDDEN",      .WindowHidden,      140);
            DrawWindowState("[N] FLAG_WINDOW_MINIMIZED",   .WindowMinimized,   160);
            DrawWindowState("[M] FLAG_WINDOW_MAXIMIZED",   .WindowMaximized,   180);
            DrawWindowState("[U] FLAG_WINDOW_UNFOCUSED",   .WindowUnfocused,   200);
            DrawWindowState("[T] FLAG_WINDOW_TOPMOST",     .WindowTopmost,     220);
            DrawWindowState("[A] FLAG_WINDOW_ALWAYS_RUN",  .WindowAlwaysRun,   240);
            DrawWindowState("[V] FLAG_VSYNC_HINT",         .VsyncHint,         260);

            DrawText("Following flags can only be set before window creation:", 10, 300, 10, .Gray);
            DrawWindowState("FLAG_WINDOW_HIGHDPI",     .WindowHighdpi,     320);
            DrawWindowState("FLAG_WINDOW_TRANSPARENT", .WindowTransparent, 340);
            DrawWindowState("FLAG_MSAA_4X_HINT",       .Msaa4xHint,        360);
        }

        return 0;
    }

    public static void ToggleWindowState(ConfigFlags flags)
    {
        if (IsWindowState(flags))
            ClearWindowState(flags);
        else
            SetWindowState(flags);
    }

    public static void DrawWindowState(StringView label, ConfigFlags flags, int y)
    {
        bool enabled = IsWindowState(flags);
        StringView state = enabled ? "on" : "off";
        DrawText(scope $"{label}: {state}", 10, (int32)y, 10, (enabled ? .Lime : .Maroon));
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_window_letterbox.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored for readability
*
*    Credits:
*        Anata (@anatagawa) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_window_letterbox;

class Program
{
    public static int Main(String[] args)
    {
        const int32 windowWidth = 800;
        const int32 windowHeight = 450;

        SetConfigFlags(.WindowResizable | .VsyncHint);
        InitWindow(windowWidth, windowHeight, "raylib [core] example - window scale letterbox");
        defer CloseWindow();
        SetWindowMinSize(320, 240);
        SetTargetFPS(60);

        int32 gameScreenWidth = 640;
        int32 gameScreenHeight = 480;

        RenderTexture2D target = LoadRenderTexture(gameScreenWidth, gameScreenHeight);
        defer UnloadRenderTexture(target);
        SetTextureFilter(target.texture, .Bilinear);

        Color[] colors = scope Color[10];

        for (int i = 0; i < 10; i++)
            colors[i] = .((uint8)GetRandomValue(100, 250), (uint8)GetRandomValue(50, 150), (uint8)GetRandomValue(10, 100), 255);

        while (!WindowShouldClose())
        {
            float scale = Math.Min((float)GetScreenWidth() / gameScreenWidth, (float)GetScreenHeight() / gameScreenHeight);

            if (IsKeyPressed(.Space))
            {
                for (int i = 0; i < 10; i++)
                    colors[i] = .((uint8)GetRandomValue(100, 250), (uint8)GetRandomValue(50, 150), (uint8)GetRandomValue(10, 100), 255);
            }

            Vector2 mouse = GetMousePosition();
            Vector2 virtualMouse = .();
            virtualMouse.x = (mouse.x - (GetScreenWidth() - (gameScreenWidth * scale)) * 0.5f) / scale;
            virtualMouse.y = (mouse.y - (GetScreenHeight() - (gameScreenHeight * scale)) * 0.5f) / scale;
            virtualMouse = Vector2Clamp(virtualMouse, .Zero, .((float)gameScreenWidth, (float)gameScreenHeight));

            BeginTextureMode(target);
            {
                ClearBackground(.RayWhite);

                for (int i = 0; i < 10; i++)
                    DrawRectangle(0, (int32)((gameScreenHeight / 10) * i), gameScreenWidth, gameScreenHeight / 10, colors[i]);

                DrawText("If executed inside a window,\nyou can resize the window,\nand see the screen scaling!", 10, 25, 20, .White);
                DrawText(TextFormat("Default Mouse: [%i , %i]", (int)mouse.x, (int)mouse.y), 350, 25, 20, .Green);
                DrawText(TextFormat("Virtual Mouse: [%i , %i]", (int)virtualMouse.x, (int)virtualMouse.y), 350, 55, 20, .Yellow);
            }
            EndTextureMode();

            BeginDrawing();
            {
                ClearBackground(.Blue);

                Rectangle source = .(0f, 0f, (float)target.texture.width, -(float)target.texture.height);
                Rectangle destination = .()
                    {
                        x = (GetScreenWidth() - ((float)gameScreenWidth * scale)) * 0.5f,
                        y = (GetScreenHeight() - ((float)gameScreenHeight * scale)) * 0.5f,
                        width = (float)gameScreenWidth * scale,
                        height = (float)gameScreenHeight * scale
                    };
                DrawTexturePro(target.texture, source, destination, .Zero, 0f, .White);
            }
            EndDrawing();
        }

        return 0;
    }
}
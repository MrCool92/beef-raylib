/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/textures/textures_bunnymark.c
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

namespace textures_bunnymark;

static
{
    public const int32 MAX_BUNNIES = 50000;
    public const int32 MAX_BATCH_ELEMENTS = 8192;
}

struct Bunny
{
    public Vector2 position;
    public Vector2 speed;
    public Color color;
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [textures] example - bunnymark");
        defer CloseWindow();

        Texture2D texBunny = LoadTexture("../resources/wabbit_alpha.png");
        defer UnloadTexture(texBunny);

        Bunny[] bunnies = new Bunny[MAX_BUNNIES];
        defer delete bunnies;

        int bunniesCount = 0;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsMouseButtonDown(.Left))
            {
                for (int i = 0; i < 100; i++)
                {
                    if (bunniesCount < MAX_BUNNIES)
                    {
                        var bunny = ref bunnies[bunniesCount];
                        bunny.position = GetMousePosition();
                        bunny.speed.x = GetRandomValue(-250, 250) / 60f;
                        bunny.speed.y = GetRandomValue(-250, 250) / 60f;
                        bunny.color = .((uint8)GetRandomValue(50, 240), (uint8)GetRandomValue(80, 240), (uint8)GetRandomValue(100, 240), 255);
                        bunniesCount++;
                    }
                }
            }

            for (int i = 0; i < bunniesCount; i++)
            {
                var bunny = ref bunnies[i];
                bunny.position.x += bunny.speed.x;
                bunny.position.y += bunny.speed.y;

                if (((bunny.position.x + texBunny.width / 2) > GetScreenWidth()) ||
                    ((bunny.position.x + texBunny.width / 2) < 0))
                    bunny.speed.x *= -1;

                if (((bunny.position.y + texBunny.height / 2) > GetScreenHeight()) ||
                    ((bunny.position.y + texBunny.height / 2 - 40) < 0))
                    bunny.speed.y *= -1;
            }

            BeginDrawing();
            {
                ClearBackground(.RayWhite);

                for (int i = 0; i < bunniesCount; i++)
                {
                    var bunny = bunnies[i];
                    DrawTexture(texBunny, (int32)bunny.position.x, (int32)bunny.position.y, bunny.color);
                }

                DrawRectangle(0, 0, screenWidth, 40, .Black);
                DrawText(TextFormat("bunnies: %i", bunniesCount), 120, 10, 20, .Green);
                DrawText(TextFormat("batched draw calls: %i", 1 + bunniesCount / MAX_BATCH_ELEMENTS), 320, 10, 20, .Maroon);

                DrawFPS(10, 10);
            }
            EndDrawing();
        }

        return 0;
    }
}
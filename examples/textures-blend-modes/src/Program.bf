/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/textures/textures_blend_modes.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Karlo Licudine (@accidentalrebel) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;
using Raylib.Textures;

namespace textures_blend_modes;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [textures] example - blend modes");
        defer CloseWindow();

        Image bgImage = LoadImage("../resources/cyberpunk_street_background.png");
        Texture2D bgTexture = LoadTextureFromImage(bgImage);
        defer UnloadTexture(bgTexture);

        Image fgImage = LoadImage("../resources/cyberpunk_street_foreground.png");
        Texture2D fgTexture = LoadTextureFromImage(fgImage);
        defer UnloadTexture(fgTexture);

        UnloadImage(bgImage);
        UnloadImage(fgImage);

        const int32 blendCountMax = 4;
        BlendMode blendMode = 0;

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.Space))
            {
                if (blendMode >= (BlendMode)(blendCountMax - 1))
                    blendMode = 0;
                else
                    blendMode++;
            }

            BeginDrawing();
            {
                ClearBackground(.RayWhite);

                DrawTexture(bgTexture, screenWidth / 2 - bgTexture.width / 2, screenHeight / 2 - bgTexture.height / 2, .White);

                BeginBlendMode(blendMode);
                {
                    DrawTexture(fgTexture, screenWidth / 2 - fgTexture.width / 2, screenHeight / 2 - fgTexture.height / 2, .White);
                }
                EndBlendMode();

                DrawText("Press SPACE to change blend modes.", 310, 350, 10, .Gray);

                switch (blendMode)
                {
                case .Alpha: DrawText("Current: BLEND_ALPHA", (screenWidth / 2) - 60, 370, 10, .Gray); break;
                case .Additive: DrawText("Current: BLEND_ADDITIVE", (screenWidth / 2) - 60, 370, 10, .Gray); break;
                case .Multiplied: DrawText("Current: BLEND_MULTIPLIED", (screenWidth / 2) - 60, 370, 10, .Gray); break;
                case .AddColors: DrawText("Current: BLEND_ADD_COLORS", (screenWidth / 2) - 60, 370, 10, .Gray); break;
                default: break;
                }

                DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", screenWidth - 330, screenHeight - 20, 10, .Gray);
            }
            EndDrawing();
        }

        return 0;
    }
}
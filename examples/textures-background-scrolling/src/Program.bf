/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/textures/textures_background_scrolling.c
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
using Raylib.Textures;

namespace textures_background_scrolling;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [textures] example - background scrolling");
        defer CloseWindow();

        Texture2D background = LoadTexture("../resources/cyberpunk_street_background.png");
        defer UnloadTexture(background);
        Texture2D midground = LoadTexture("../resources/cyberpunk_street_midground.png");
        defer UnloadTexture(midground);
        Texture2D foreground = LoadTexture("../resources/cyberpunk_street_foreground.png");
        defer UnloadTexture(foreground);

        float scrollingBack = 0f;
        float scrollingMid = 0f;
        float scrollingFore = 0f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            scrollingBack -= 0.1f;
            scrollingMid -= 0.5f;
            scrollingFore -= 1f;

            if (scrollingBack <= -background.width * 2)
                scrollingBack = 0;
            if (scrollingMid <= -midground.width * 2)
                scrollingMid = 0;
            if (scrollingFore <= -foreground.width * 2)
                scrollingFore = 0;

            BeginDrawing();

            ClearBackground(GetColor(0x052c46ff));

            DrawTextureEx(background, .(scrollingBack, 20), 0f, 2f, .White);
            DrawTextureEx(background, .(background.width * 2 + scrollingBack, 20), 0f, 2f, .White);

            DrawTextureEx(midground, .(scrollingMid, 20), 0f, 2f, .White);
            DrawTextureEx(midground, .(midground.width * 2 + scrollingMid, 20), 0f, 2f, .White);

            DrawTextureEx(foreground, .(scrollingFore, 70), 0f, 2f, .White);
            DrawTextureEx(foreground, .(foreground.width * 2 + scrollingFore, 70), 0f, 2f, .White);

            DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, .Red);
            DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", screenWidth - 330, screenHeight - 20, 10, .RayWhite);

            EndDrawing();
        }

        return 0;
    }
}
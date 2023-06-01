/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/b59fab7ee6035886554778e8adc540deb3f29f4a/examples/textures/textures_mouse_painting.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Chris Dill (@MysteriousSpace) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace textures_mouse_painting;

static
{
    public const int32 MAX_COLORS_COUNT = 23;
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [textures] example - mouse painting");
        defer CloseWindow();

        Color[] colors = scope Color[MAX_COLORS_COUNT](
            .RayWhite, .Yellow, .Gold, .Orange, .Pink, .Red, .Maroon, .Green, .Lime, .DarkGreen,
            .SkyBlue, .Blue, .DarkBlue, .Purple, .Violet, .DarkPurple, .Beige, .Brown, .DarkBrown,
            .LightGray, .Gray, .DarkGray, .Black
            );

        Rectangle[] colorsRecs = scope Rectangle[MAX_COLORS_COUNT];

        for (int i < MAX_COLORS_COUNT)
        {
            colorsRecs[i].x = 10 + 30f * i + 2 * i;
            colorsRecs[i].y = 10;
            colorsRecs[i].width = 30;
            colorsRecs[i].height = 30;
        }

        int colorSelected = 0;
        int colorSelectedPrev = colorSelected;
        int colorMouseHover = 0;
        float brushSize = 20f;
        bool mouseWasPressed = false;

        Rectangle btnSaveRec = .(750, 10, 40, 30);
        bool btnSaveMouseHover = false;
        bool showSaveMessage = false;
        int saveMessageCounter = 0;

        RenderTexture2D target = LoadRenderTexture(screenWidth, screenHeight);
        defer UnloadRenderTexture(target);

        BeginTextureMode(target);
        ClearBackground(colors[0]);
        EndTextureMode();

        SetTargetFPS(120);

        while (!WindowShouldClose())
        {
            Vector2 mousePos = GetMousePosition();

            if (IsKeyPressed(.Right))
                colorSelected++;
            else if (IsKeyPressed(.Left))
                colorSelected--;

            if (colorSelected >= MAX_COLORS_COUNT)
                colorSelected = MAX_COLORS_COUNT - 1;
            else if (colorSelected < 0)
                colorSelected = 0;

            for (int i < MAX_COLORS_COUNT)
            {
                if (CheckCollisionPointRec(mousePos, colorsRecs[i]))
                {
                    colorMouseHover = i;
                    break;
                }
                else
                    colorMouseHover = -1;
            }

            if ((colorMouseHover >= 0) && IsMouseButtonPressed(.Left))
            {
                colorSelected = colorMouseHover;
                colorSelectedPrev = colorSelected;
            }

            brushSize += GetMouseWheelMove() * 5;
            if (brushSize < 2)
                brushSize = 2;
            if (brushSize > 50)
                brushSize = 50;

            if (IsKeyPressed(.C))
            {
                BeginTextureMode(target);
                ClearBackground(colors[0]);
                EndTextureMode();
            }

            if (IsMouseButtonDown(.Left) || (GetGestureDetected() == .Drag))
            {
                BeginTextureMode(target);
                if (mousePos.y > 50)
                    DrawCircle((int32)mousePos.x, (int32)mousePos.y, brushSize, colors[colorSelected]);
                EndTextureMode();
            }

            if (IsMouseButtonDown(.Right))
            {
                if (!mouseWasPressed)
                {
                    colorSelectedPrev = colorSelected;
                    colorSelected = 0;
                }

                mouseWasPressed = true;

                BeginTextureMode(target);
                if (mousePos.y > 50)
                    DrawCircle((int32)mousePos.x, (int32)mousePos.y, brushSize, colors[0]);
                EndTextureMode();
            }
            else if (IsMouseButtonReleased(.Right) && mouseWasPressed)
            {
                colorSelected = colorSelectedPrev;
                mouseWasPressed = false;
            }

            btnSaveMouseHover = CheckCollisionPointRec(mousePos, btnSaveRec);

            if ((btnSaveMouseHover && IsMouseButtonReleased(.Left)) || IsKeyPressed(.S))
            {
                Image image = LoadImageFromTexture(target.texture);
                ImageFlipVertical(&image);
                ExportImage(image, "my_amazing_texture_painting.png");
                UnloadImage(image);
                showSaveMessage = true;
            }

            if (showSaveMessage)
            {
                saveMessageCounter++;
                if (saveMessageCounter > 240)
                {
                    showSaveMessage = false;
                    saveMessageCounter = 0;
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawTextureRec(target.texture, .(0, 0, (float)target.texture.width, (float) - target.texture.height), .(0, 0), .White);

            if (mousePos.y > 50)
            {
                if (IsMouseButtonDown(.Right))
                    DrawCircleLines((int32)mousePos.x, (int32)mousePos.y, brushSize, .Gray);
                else
                    DrawCircle(GetMouseX(), GetMouseY(), brushSize, colors[colorSelected]);
            }

            DrawRectangle(0, 0, GetScreenWidth(), 50, .RayWhite);
            DrawLine(0, 50, GetScreenWidth(), 50, .LightGray);

            for (int i < MAX_COLORS_COUNT)
                DrawRectangleRec(colorsRecs[i], colors[i]);
            DrawRectangleLines(10, 10, 30, 30, .LightGray);

            if (colorMouseHover >= 0)
                DrawRectangleRec(colorsRecs[colorMouseHover], Fade(.White, 0.6f));

            DrawRectangleLinesEx(.(
                colorsRecs[colorSelected].x - 2, colorsRecs[colorSelected].y - 2,
                colorsRecs[colorSelected].width + 4, colorsRecs[colorSelected].height + 4
                ), 2, .Black);

            DrawRectangleLinesEx(btnSaveRec, 2, btnSaveMouseHover ? .Red : .Black);
            DrawText("SAVE!", 755, 20, 10, btnSaveMouseHover ? .Red : .Black);

            if (showSaveMessage)
            {
                DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(.RayWhite, 0.8f));
                DrawRectangle(0, 150, GetScreenWidth(), 80, .Black);
                DrawText("IMAGE SAVED:  my_amazing_texture_painting.png", 150, 180, 20, .RayWhite);
            }
        }

        return 0;
    }
}
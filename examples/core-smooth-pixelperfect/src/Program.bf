/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_smooth_pixelperfect.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Giancamillo Alessandroni (@NotManyIdeasDev) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_smooth_pixelperfect;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        const int virtualScreenWidth = 160;
        const int virtualScreenHeight = 90;

        const float virtualRatio = (float)screenWidth / (float)virtualScreenWidth;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - smooth pixel-perfect camera");
        defer CloseWindow();

        SetTargetFPS(60);

        Camera2D worldSpaceCamera = .();
        worldSpaceCamera.zoom = 1f;

        Camera2D screenSpaceCamera = .();
        screenSpaceCamera.zoom = 1f;

        RenderTexture2D target = LoadRenderTexture(virtualScreenWidth, virtualScreenHeight);
        defer UnloadRenderTexture(target);

        Rectangle rec01 = .(70f, 35f, 20f, 20f);
        Rectangle rec02 = .(90f, 55f, 30f, 10f);
        Rectangle rec03 = .(80f, 65f, 15f, 25f);

        Rectangle sourceRec = .(0f, 0f, (float)target.texture.width, -(float)target.texture.height);
        Rectangle destRec = .(-virtualRatio, -virtualRatio, screenWidth + (virtualRatio * 2), screenHeight + (virtualRatio * 2));

        Vector2 origin = .Zero;

        float rotation = 0f;

        float cameraX = 0f;
        float cameraY = 0f;

        while (!WindowShouldClose())
        {
            rotation += 60f * GetFrameTime();

            cameraX = ((float)Math.Sin(GetTime()) * 50f) - 10f;
            cameraY = (float)Math.Cos(GetTime()) * 30f;

            screenSpaceCamera.target = Vector2(cameraX, cameraY);

            worldSpaceCamera.target.x = (int)screenSpaceCamera.target.x;
            screenSpaceCamera.target.x -= worldSpaceCamera.target.x;
            screenSpaceCamera.target.x *= virtualRatio;

            worldSpaceCamera.target.y = (int)screenSpaceCamera.target.y;
            screenSpaceCamera.target.y -= worldSpaceCamera.target.y;
            screenSpaceCamera.target.y *= virtualRatio;

            BeginTextureMode(target);
            ClearBackground(.RayWhite);

            BeginMode2D(worldSpaceCamera);
            DrawRectanglePro(rec01, origin, rotation, .Black);
            DrawRectanglePro(rec02, origin, -rotation, .Red);
            DrawRectanglePro(rec03, origin, rotation + 45f, .Blue);
            EndMode2D();
            EndTextureMode();

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.Red);

            BeginMode2D(screenSpaceCamera);
            DrawTexturePro(target.texture, sourceRec, destRec, origin, 0f, .White);
            EndMode2D();

            DrawText(TextFormat("Screen resolution: %ix%i", screenWidth, screenHeight), 10, 10, 20, .DarkBlue);
            DrawText(TextFormat("World resolution: %ix%i", virtualScreenWidth, virtualScreenHeight), 10, 40, 20, .DarkGreen);
            DrawFPS(GetScreenWidth() - 95, 10);
        }

        return 0;
    }
}
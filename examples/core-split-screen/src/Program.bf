/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_split_screen.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Jeffery Myers (@JeffM2501) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_split_screen;

public static
{
    public static Camera cameraPlayer1 = .();
    public static Camera cameraPlayer2 = .();
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - split screen");
        defer CloseWindow();

        cameraPlayer1.fovy = 45f;
        cameraPlayer1.up.y = 1f;
        cameraPlayer1.target.y = 1f;
        cameraPlayer1.position.z = -3f;
        cameraPlayer1.position.y = 1f;

        RenderTexture screenPlayer1 = LoadRenderTexture(screenWidth / 2, screenHeight);
        defer UnloadRenderTexture(screenPlayer1);

        cameraPlayer2.fovy = 45f;
        cameraPlayer2.up.y = 1f;
        cameraPlayer2.target.y = 3f;
        cameraPlayer2.position.x = -3f;
        cameraPlayer2.position.y = 3f;

        RenderTexture screenPlayer2 = LoadRenderTexture(screenWidth / 2, screenHeight);
        defer UnloadRenderTexture(screenPlayer2);

        Rectangle splitScreenRect = Rectangle(0f, 0f, (float)screenPlayer1.texture.width, (float) - screenPlayer1.texture.height);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            float offsetThisFrame = 10f * GetFrameTime();

            if (IsKeyDown(.W))
            {
                cameraPlayer1.position.z += offsetThisFrame;
                cameraPlayer1.target.z += offsetThisFrame;
            }
            else if (IsKeyDown(.S))
            {
                cameraPlayer1.position.z -= offsetThisFrame;
                cameraPlayer1.target.z -= offsetThisFrame;
            }

            if (IsKeyDown(.Up))
            {
                cameraPlayer2.position.x += offsetThisFrame;
                cameraPlayer2.target.x += offsetThisFrame;
            }
            else if (IsKeyDown(.Down))
            {
                cameraPlayer2.position.x -= offsetThisFrame;
                cameraPlayer2.target.x -= offsetThisFrame;
            }

            BeginTextureMode(screenPlayer1);
            ClearBackground(.SkyBlue);
            BeginMode3D(cameraPlayer1);
            DrawScene();
            EndMode3D();
            DrawText("PLAYER1 W/S to move", 10, 10, 20, .Red);
            EndTextureMode();

            BeginTextureMode(screenPlayer2);
            ClearBackground(.SkyBlue);
            BeginMode3D(cameraPlayer2);
            DrawScene();
            EndMode3D();
            DrawText("PLAYER2 UP/DOWN to move", 10, 10, 20, .Blue);
            EndTextureMode();

            BeginDrawing();
            ClearBackground(.Black);
            DrawTextureRec(screenPlayer1.texture, splitScreenRect, Vector2.Zero, .White);
            DrawTextureRec(screenPlayer2.texture, splitScreenRect, Vector2(screenWidth / 2f, 0f), .White);
            EndDrawing();
        }

        return 0;
    }

    public static void DrawScene()
    {
        int count = 5;
        float spacing = 4;
        DrawPlane(Vector3.Zero, Vector2(50f, 50f), .Beige);

        for (float x = -count * spacing; x <= count * spacing; x += spacing)
        {
            for (float z = -count * spacing; z <= count * spacing; z += spacing)
            {
                DrawCube(Vector3(x, 1.5f, z), 1f, 1f, 1f, .Lime);
                DrawCube(Vector3(x, 0.5f, z), 0.25f, 1f, 0.25f, .Brown);
            }
        }

        DrawCube(cameraPlayer1.position, 1f, 1f, 1f, .Red);
        DrawCube(cameraPlayer2.position, 1f, 1f, 1f, .Blue);
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_yaw_pitch_roll.c
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
using Raylib.Raymath;

namespace models_yaw_pitch_roll;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - plane rotations (yaw, pitch, roll)");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(0f, 50f, -120f);
        camera.fovy = 30f;

        Model model = LoadModel("../resources/models/obj/plane.obj");
        defer UnloadModel(model);
        Texture2D texture = LoadTexture("../resources/models/obj/plane_diffuse.png");
        defer UnloadTexture(texture);
        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

        float pitch = 0f;
        float roll = 0f;
        float yaw = 0f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsKeyDown(.Down))
                pitch += 0.6f;
            else if (IsKeyDown(.Up))
                pitch -= 0.6f;
            else
            {
                if (pitch > 0.3f)
                    pitch -= 0.3f;
                else if (pitch < -0.3f)
                    pitch += 0.3f;
            }

            if (IsKeyDown(.S))
                yaw -= 1f;
            else if (IsKeyDown(.A))
                yaw += 1f;
            else
            {
                if (yaw > 0f)
                    yaw -= 0.5f;
                else if (yaw < 0f)
                    yaw += 0.5f;
            }

            if (IsKeyDown(.Left))
                roll -= 1f;
            else if (IsKeyDown(.Right))
                roll += 1f;
            else
            {
                if (roll > 0f)
                    roll -= 0.5f;
                else if (roll < 0f)
                    roll += 0.5f;
            }

            model.transform = MatrixRotateXYZ(.(DEG2RAD * pitch, DEG2RAD * yaw, DEG2RAD * roll));

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(model, .(0f, -8f, 0f), 1f, .White);
            DrawGrid(10, 10f);

            EndMode3D();

            DrawRectangle(30, 370, 260, 70, Fade(.Green, 0.5f));
            DrawRectangleLines(30, 370, 260, 70, Fade(.DarkGreen, 0.5f));
            DrawText("Pitch controlled with: KEY_UP / KEY_DOWN", 40, 380, 10, .DarkGray);
            DrawText("Roll controlled with: KEY_LEFT / KEY_RIGHT", 40, 400, 10, .DarkGray);
            DrawText("Yaw controlled with: KEY_A / KEY_S", 40, 420, 10, .DarkGray);

            DrawText("(c) WWI Plane Model created by GiaHanLam", screenWidth - 240, screenHeight - 20, 10, .DarkGray);
        }

        return 0;
    }
}
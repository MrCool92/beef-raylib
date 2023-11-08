/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_animation.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Culacant (@culacant) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace models_animation;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - model animation");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(10f, 10f, 10f);
        camera.fovy = 45f;

        Model model = LoadModel("../resources/models/iqm/guy.iqm");
        defer UnloadModel(model);

        Texture2D texture = LoadTexture("../resources/models/iqm/guytex.png");
        defer UnloadTexture(texture);

        SetMaterialTexture(&model.materials[0], .Albedo, texture);

        Vector3 position = .Zero;

        uint32 animsCount = 0;
        ModelAnimation* anims = LoadModelAnimations("../resources/models/iqm/guyanim.iqm", &animsCount);
        defer UnloadModelAnimations(anims, animsCount);
        int32 animFrameCounter = 0;

        DisableCursor();
        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .FirstPerson);

            if (IsKeyDown(.Space))
            {
                animFrameCounter++;
                UpdateModelAnimation(model, anims[0], animFrameCounter);
                if (animFrameCounter >= anims[0].frameCount)
                    animFrameCounter = 0;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModelEx(model, position, .(1f, 0f, 0f), -90f, .One, .White);

            for (int i < model.boneCount)
                DrawCube(anims[0].framePoses[animFrameCounter][i].translation, 0.2f, 0.2f, 0.2f, .Red);

            DrawGrid(10, 1f);

            EndMode3D();

            DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, .Maroon);
            DrawText("(c) Guy IQM 3D model by @culacant", screenWidth - 200, screenHeight - 20, 10, .Gray);
        }

        return 0;
    }
}
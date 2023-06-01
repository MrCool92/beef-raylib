/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_loading_m3d.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        bzt (@bztsrc) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace models_loading_m3d;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - M3D model loading");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(1.5f, 1.5f, 1.5f);
        camera.target = .(0f, 0.4f, 0f);
        camera.fovy = 45f;

        Vector3 position = .Zero;

        char8* modelFileName = "../resources/models/m3d/cesium_man.m3d";
        bool drawMesh = true;
        bool drawSkeleton = true;
        bool animPlaying = false;

        Model model = LoadModel(modelFileName);
        defer UnloadModel(model);

        uint32 animsCount = 0;
        int32 animFrameCounter = 0, animId = 0;
        ModelAnimation* anims = LoadModelAnimations(modelFileName, &animsCount);
        defer UnloadModelAnimations(anims, animsCount);

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .FirstPerson);

            if (animsCount > 0)
            {
                if (IsKeyDown(.Space) || IsKeyPressed(.N))
                {
                    animFrameCounter++;

                    if (animFrameCounter >= anims[animId].frameCount)
                        animFrameCounter = 0;

                    UpdateModelAnimation(model, anims[animId], animFrameCounter);
                    animPlaying = true;
                }

                if (IsKeyPressed(.A))
                {
                    animFrameCounter = 0;
                    animId++;

                    if ((uint32)animId >= animsCount)
                        animId = 0;
                    UpdateModelAnimation(model, anims[animId], 0);
                    animPlaying = true;
                }
            }

            if (IsKeyPressed(.S))
                drawSkeleton = !drawSkeleton;

            if (IsKeyPressed(.M))
                drawMesh = !drawMesh;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            if (drawMesh)
                DrawModel(model, position, 1f, .White);

            if (drawSkeleton)
            {
                for (int i < model.boneCount - 1)
                {
                    if (!animPlaying || animsCount == 0)
                    {
                        DrawCube(model.bindPose[i].translation, 0.04f, 0.04f, 0.04f, .Red);

                        if (model.bones[i].parent >= 0)
                            DrawLine3D(model.bindPose[i].translation, model.bindPose[model.bones[i].parent].translation, .Red);
                    }
                    else
                    {
                        DrawCube(anims[animId].framePoses[animFrameCounter][i].translation, 0.05f, 0.05f, 0.05f, .Red);

                        if (anims[animId].bones[i].parent >= 0)
                            DrawLine3D(anims[animId].framePoses[animFrameCounter][i].translation, anims[animId].framePoses[animFrameCounter][anims[animId].bones[i].parent].translation, .Red);
                    }
                }
            }

            DrawGrid(10, 1f);

            EndMode3D();

            DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, GetScreenHeight() - 60, 10, .Maroon);
            DrawText("PRESS A to CYCLE THROUGH ANIMATIONS", 10, GetScreenHeight() - 40, 10, .DarkGray);
            DrawText("PRESS M to toggle MESH, S to toggle SKELETON DRAWING", 10, GetScreenHeight() - 20, 10, .DarkGray);
            DrawText("(c) CesiumMan model by KhronosGroup", GetScreenWidth() - 210, GetScreenHeight() - 20, 10, .Gray);
        }

        return 0;
    }
}
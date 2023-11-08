/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_loading_gltf.c
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

namespace models_loading_gltf;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - loading gltf");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(5f, 5f, 5f);
        camera.target = .(0f, 2f, 0f);
        camera.fovy = 45f;

        Model model = LoadModel("../resources/models/gltf/robot.glb");
        defer UnloadModel(model);

        uint32 animsCount = 0;
        uint animIndex = 0;
        int32 animCurrentFrame = 0;
        ModelAnimation* modelAnimations = LoadModelAnimations("../resources/models/gltf/robot.glb", &animsCount);

        Vector3 position = .Zero;

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .ThirdPerson);

            if (IsKeyPressed(.Up))
                animIndex = (animIndex + 1) % animsCount;
            else if (IsKeyPressed(.Down))
                animIndex = (animIndex + animsCount - 1) % animsCount;

            ModelAnimation anim = modelAnimations[animIndex];
            animCurrentFrame = (animCurrentFrame + 1) % anim.frameCount;
            UpdateModelAnimation(model, anim, animCurrentFrame);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(model, position, 1f, .White);
            DrawGrid(10, 1f);

            EndMode3D();

            DrawText("Use the UP/DOWN arrow keys to switch animation", 10, 10, 20, .Gray);
        }

        return 0;
    }
}
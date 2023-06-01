/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_loading_vox.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Johann Nadalutti (@procfxgen) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;
using Raylib.Raymath;

namespace models_loading_vox;

public static
{
    public const int MAX_VOX_FILES = 3;
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        String[] voxFileNames = scope .(
            "../resources/models/vox/chr_knight.vox",
            "../resources/models/vox/chr_sword.vox",
            "../resources/models/vox/monu9.vox"
            );

        InitWindow(screenWidth, screenHeight, "raylib [models] example - magicavoxel loading");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(10f, 10f, 10f);
        camera.fovy = 45f;

        Model[MAX_VOX_FILES] models = .();

        for (int i < MAX_VOX_FILES)
        {
            double t0 = GetTime() * 1000;
            models[i] = LoadModel(voxFileNames[i].CStr());
            double t1 = GetTime() * 1000;

            TraceLog(.Warning, TextFormat("[%s] File loaded in %.3f ms", voxFileNames[i], t1 - t0));

            BoundingBox bb = GetModelBoundingBox(models[i]);
            Vector3 center = .Zero;
            center.x = bb.min.x + (((bb.max.x - bb.min.x) / 2));
            center.z = bb.min.z + (((bb.max.z - bb.min.z) / 2));

            Matrix matTranslate = MatrixTranslate(-center.x, 0, -center.z);
            models[i].transform = matTranslate;

            defer:: UnloadModel(models[i]);
        }

        int currentModel = 0;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            if (IsMouseButtonPressed(.Left))
                currentModel = (currentModel + 1) % MAX_VOX_FILES;

            if (IsKeyPressed(.Right))
            {
                if (++currentModel >= MAX_VOX_FILES)
                    currentModel = 0;
            }
            else if (IsKeyPressed(.Left))
            {
                if (--currentModel < 0)
                    currentModel = MAX_VOX_FILES - 1;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(models[currentModel], .Zero, 1f, .White);
            DrawGrid(10, 1);

            EndMode3D();

            DrawRectangle(10, 400, 310, 30, Fade(.SkyBlue, 0.5f));
            DrawRectangleLines(10, 400, 310, 30, Fade(.DarkBlue, 0.5f));
            DrawText("MOUSE LEFT BUTTON to CYCLE VOX MODELS", 40, 410, 10, .Blue);
            DrawText(TextFormat("File: %s", GetFileName(voxFileNames[currentModel].Ptr)), 10, 10, 20, .Gray);
        }

        return 0;
    }
}
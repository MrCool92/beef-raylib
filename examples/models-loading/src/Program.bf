/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_loading.c
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

namespace models_loading;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - models loading");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(50f, 50f, 50f);
        camera.target = .(0f, 10f, 0f);
        camera.fovy = 45f;

        Model model = LoadModel("../resources/models/obj/castle.obj");
        Texture2D texture = LoadTexture("../resources/models/obj/castle_diffuse.png");
        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

        Vector3 position = .Zero;

        BoundingBox bounds = GetMeshBoundingBox(model.meshes[0]);

        bool selected = false;

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .FirstPerson);

            if (IsFileDropped())
            {
                FilePathList droppedFiles = LoadDroppedFiles();

                if (droppedFiles.count == 1)
                {
                    if (IsFileExtension(droppedFiles.paths[0], ".obj") ||
                        IsFileExtension(droppedFiles.paths[0], ".gltf") ||
                        IsFileExtension(droppedFiles.paths[0], ".glb") ||
                        IsFileExtension(droppedFiles.paths[0], ".vox") ||
                        IsFileExtension(droppedFiles.paths[0], ".iqm") ||
                        IsFileExtension(droppedFiles.paths[0], ".m3d"))
                    {
                        UnloadModel(model);
                        model = LoadModel(droppedFiles.paths[0]);
                        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

                        bounds = GetMeshBoundingBox(model.meshes[0]);
                    }
                    else if (IsFileExtension(droppedFiles.paths[0], ".png"))
                    {
                        UnloadTexture(texture);
                        texture = LoadTexture(droppedFiles.paths[0]);
                        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;
                    }
                }

                UnloadDroppedFiles(droppedFiles);
            }

            if (IsMouseButtonPressed(.Left))
            {
                if (GetRayCollisionBox(GetMouseRay(GetMousePosition(), camera), bounds).hit)
                    selected = !selected;
                else
                    selected = false;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(model, position, 1.0f, .White);

            DrawGrid(20, 10.0f);

            if (selected)
                DrawBoundingBox(bounds, .Green);

            EndMode3D();

            DrawText("Drag & drop model to load mesh/texture.", 10, GetScreenHeight() - 20, 10, .DarkGray);
            if (selected)
                DrawText("MODEL SELECTED", GetScreenWidth() - 110, 10, 10, .Green);

            DrawText("(c) Castle 3D model by Alberto Cano", screenWidth - 200, screenHeight - 20, 10, .Gray);

            DrawFPS(10, 10);
        }

        UnloadModel(model);
        UnloadTexture(texture);

        return 0;
    }
}
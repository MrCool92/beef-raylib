/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_heightmap.c
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

namespace models_heightmap;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - heightmap loading and drawing");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(18f, 21f, 18f);
        camera.fovy = 45f;

        Image image = LoadImage("../resources/heightmap.png");
        Texture2D texture = LoadTextureFromImage(image);
        defer UnloadTexture(texture);

        Mesh mesh = GenMeshHeightmap(image, .(16, 8, 16));
        Model model = LoadModelFromMesh(mesh);
        defer UnloadModel(model);

        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;
        Vector3 mapPosition = .(-8f, 0f, -8f);

        UnloadImage(image);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(model, mapPosition, 1f, .Red);

            DrawGrid(20, 1f);

            EndMode3D();

            DrawTexture(texture, screenWidth - texture.width - 20, 20, .White);
            DrawRectangleLines(screenWidth - texture.width - 20, 20, texture.width, texture.height, .Green);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_cubicmap.c
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

namespace models_cubicmap;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - cubesmap loading and drawing");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(16f, 14f, 16f);
        camera.fovy = 45f;

        Image image = LoadImage("../resources/cubicmap.png");
        Texture2D cubicmap = LoadTextureFromImage(image);
        defer UnloadTexture(cubicmap);

        Mesh mesh = GenMeshCubicmap(image, .One);
        Model model = LoadModelFromMesh(mesh);
        defer UnloadModel(model);

        Texture2D texture = LoadTexture("../resources/cubicmap_atlas.png");
        defer UnloadTexture(texture);
        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

        Vector3 mapPosition = .(-16f, 0f, -8f);

        UnloadImage(image);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(model, mapPosition, 1.0f, .White);

            EndMode3D();

            DrawTextureEx(cubicmap, .(screenWidth - cubicmap.width * 4f - 20, 20f), 0f, 4f, .White);
            DrawRectangleLines((int32)(screenWidth - cubicmap.width * 4 - 20), 20, cubicmap.width * 4, cubicmap.height * 4, .Green);

            DrawText("cubicmap image used to", 658, 90, 10, .Gray);
            DrawText("generate map 3d model", 658, 104, 10, .Gray);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
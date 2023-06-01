/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_first_person_maze.c
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

namespace models_first_person_maze;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - first person maze");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(0.2f, 0.4f, 0.2f);
        camera.target = .(0.185f, 0.4f, 0f);
        camera.fovy = 45f;

        Image imMap = LoadImage("../resources/cubicmap.png");
        Texture2D cubicmap = LoadTextureFromImage(imMap);
        defer UnloadTexture(cubicmap);

        Mesh mesh = GenMeshCubicmap(imMap, .One);
        Model model = LoadModelFromMesh(mesh);
        defer UnloadModel(model);

        Texture2D texture = LoadTexture("../resources/cubicmap_atlas.png");
        defer UnloadTexture(texture);

        model.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

        Color* mapPixels = LoadImageColors(imMap);
        UnloadImage(imMap);

        Vector3 mapPosition = .(-16f, 0f, -8f);

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            Vector3 oldCamPos = camera.position;

            UpdateCamera(&camera, .FirstPerson);

            Vector2 playerPos = .(camera.position.x, camera.position.z);
            float playerRadius = 0.1f;

            int32 playerCellX = (int32)(playerPos.x - mapPosition.x + 0.5f);
            int32 playerCellY = (int32)(playerPos.y - mapPosition.z + 0.5f);

            if (playerCellX < 0)
                playerCellX = 0;
            else if (playerCellX >= cubicmap.width)
                playerCellX = cubicmap.width - 1;

            if (playerCellY < 0)
                playerCellY = 0;
            else if (playerCellY >= cubicmap.height)
                playerCellY = cubicmap.height - 1;

            for (int y < cubicmap.height)
            {
                for (int x < cubicmap.width)
                {
                    if ((mapPixels[y * cubicmap.width + x].r == 255) &&
                        (CheckCollisionCircleRec(playerPos, playerRadius, .(mapPosition.x - 0.5f + x * 1f, mapPosition.z - 0.5f + y * 1f, 1f, 1f))))
                        camera.position = oldCamPos;
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);
            DrawModel(model, mapPosition, 1f, .White);
            EndMode3D();

            DrawTextureEx(cubicmap, .(GetScreenWidth() - cubicmap.width * 4f - 20, 20f), 0f, 4f, .White);
            DrawRectangleLines(GetScreenWidth() - cubicmap.width * 4 - 20, 20, cubicmap.width * 4, cubicmap.height * 4, .Green);

            DrawRectangle(GetScreenWidth() - cubicmap.width * 4 - 20 + playerCellX * 4, 20 + playerCellY * 4, 4, 4, .Red);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
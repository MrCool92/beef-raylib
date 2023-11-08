/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_box_collisions.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace models_box_collisions;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - box collisions");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(0f, 10f, 10f);
        camera.fovy = 45f;

        Vector3 playerPosition = .(0f, 1f, 2f);
        Vector3 playerSize = .(1f, 2f, 1f);
        Color playerColor = .Green;

        Vector3 enemyBoxPos = .(-4f, 1f, 0f);
        Vector3 enemyBoxSize = .(2f, 2f, 2f);

        Vector3 enemySpherePos = .(4f, 0f, 0f);
        float enemySphereSize = 1.5f;

        bool collision = false;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsKeyDown(.Right))
                playerPosition.x += 0.2f;
            if (IsKeyDown(.Left))
                playerPosition.x -= 0.2f;
            if (IsKeyDown(.Down))
                playerPosition.z += 0.2f;
            if (IsKeyDown(.Up))
                playerPosition.z -= 0.2f;

            collision = false;

            BoundingBox playerBox = .(
                .(playerPosition.x - playerSize.x / 2, playerPosition.y - playerSize.y / 2, playerPosition.z - playerSize.z / 2),
                .(playerPosition.x + playerSize.x / 2, playerPosition.y + playerSize.y / 2, playerPosition.z + playerSize.z / 2)
                );

            BoundingBox enemyBox = .(
                .(enemyBoxPos.x - enemyBoxSize.x / 2, enemyBoxPos.y - enemyBoxSize.y / 2, enemyBoxPos.z - enemyBoxSize.z / 2),
                .(enemyBoxPos.x + enemyBoxSize.x / 2, enemyBoxPos.y + enemyBoxSize.y / 2, enemyBoxPos.z + enemyBoxSize.z / 2)
                );

            if (CheckCollisionBoxes(playerBox, enemyBox))
                collision = true;

            if (CheckCollisionBoxSphere(playerBox, enemySpherePos, enemySphereSize))
                collision = true;

            playerColor = collision ? .Red : .Green;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawCube(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, .Gray);
            DrawCubeWires(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, .DarkGray);

            DrawSphere(enemySpherePos, enemySphereSize, .Gray);
            DrawSphereWires(enemySpherePos, enemySphereSize, 16, 16, .DarkGray);

            DrawCubeV(playerPosition, playerSize, playerColor);

            DrawGrid(10, 1f);

            EndMode3D();

            DrawText("Move player with cursors to collide", 220, 40, 20, .Gray);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
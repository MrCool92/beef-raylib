/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_waving_cubes.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Codecat (@codecat) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace models_waving_cubes;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - waving cubes");
        defer CloseWindow();

        Camera3D camera = .();
        camera.position = .(30f, 20f, 30f);
        camera.fovy = 70f;

        const int numBlocks = 15;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            double time = GetTime();

            float scale = (2f + (float)Math.Sin(time)) * 0.7f;

            double cameraTime = time * 0.3;
            camera.position.x = (float)Math.Cos(cameraTime) * 40f;
            camera.position.z = (float)Math.Sin(cameraTime) * 40f;
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawGrid(10, 5f);

            for (int x < numBlocks)
            {
                for (int y < numBlocks)
                {
                    for (int z < numBlocks)
                    {
                        float blockScale = (x + y + z) / 30f;

                        float scatter = Math.Sin(blockScale * 20f + (float)(time * 4f));

                        Vector3 cubePos = .(
                            (float)(x - numBlocks / 2) * (scale * 3f) + scatter,
                            (float)(y - numBlocks / 2) * (scale * 2f) + scatter,
                            (float)(z - numBlocks / 2) * (scale * 3f) + scatter
                            );

                        Color cubeColor = ColorFromHSV((float)(((x + y + z) * 18) % 360), 0.75f, 0.9f);

                        float cubeSize = (2.4f - scale) * blockScale;

                        DrawCube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor);
                    }
                }
            }

            EndMode3D();

            DrawFPS(10, 10);
        }

        return 0;
    }
}
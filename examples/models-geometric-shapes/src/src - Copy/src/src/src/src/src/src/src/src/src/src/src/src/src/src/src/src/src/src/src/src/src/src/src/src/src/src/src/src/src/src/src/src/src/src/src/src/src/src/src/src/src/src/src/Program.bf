/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_geometric_shapes.c
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

namespace models_geometric_shapes;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - geometric shapes");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(0f, 10f, 10f);
        camera.fovy = 45f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawCube(.(-4f, 0f, 2f), 2f, 5f, 2f, .Red);
            DrawCubeWires(.(-4f, 0f, 2f), 2f, 5f, 2f, .Gold);
            DrawCubeWires(.(-4f, 0f, -2f), 3f, 6f, 2f, .Maroon);

            DrawSphere(.(-1f, 0f, -2f), 1f, .Green);
            DrawSphereWires(.(1f, 0f, 2f), 2f, 16, 16, .Lime);

            DrawCylinder(.(4f, 0f, -2f), 1f, 2f, 3f, 4, .SkyBlue);
            DrawCylinderWires(.(4f, 0f, -2f), 1f, 2f, 3f, 4, .DarkBlue);
            DrawCylinderWires(.(4.5f, -1f, 2f), 1f, 1f, 2f, 6, .Brown);

            DrawCylinder(.(1f, 0f, -4f), 0f, 1.5f, 3f, 8, .Gold);
            DrawCylinderWires(.(1f, 0f, -4f), 0f, 1.5f, 3f, 8, .Pink);

            DrawCapsule(.(-3f, 1.5f, -4f), .(-4f, -1f, -4f), 1.2f, 8, 8, .Violet);
            DrawCapsuleWires(.(-3f, 1.5f, -4f), .(-4f, -1f, -4f), 1.2f, 8, 8, .Purple);

            DrawGrid(10, 1f);

            EndMode3D();

            DrawFPS(10, 10);
        }

        return 0;
    }
}
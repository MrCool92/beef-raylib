/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_orthographic_projection.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Max Danielsson (@autious) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace models_ortographic_projection;

public static
{
    public const float FOVY_PERSPECTIVE = 45f;
    public const float WIDTH_ORTHOGRAPHIC = 10f;
}

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
        camera.fovy = FOVY_PERSPECTIVE;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.Space))
            {
                if (camera.projection == .Perspective)
                {
                    camera.fovy = WIDTH_ORTHOGRAPHIC;
                    camera.projection = .Orthographic;
                }
                else
                {
                    camera.fovy = FOVY_PERSPECTIVE;
                    camera.projection = .Perspective;
                }
            }

            BeginDrawing();
            defer  EndDrawing();

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

            DrawGrid(10, 1f);

            EndMode3D();

            DrawText("Press Spacebar to switch camera type", 10, GetScreenHeight() - 30, 20, .DarkGray);

            if (camera.projection == .Orthographic)
                DrawText("ORTHOGRAPHIC", 10, 40, 20, .Black);
            else if (camera.projection == .Perspective)
                DrawText("PERSPECTIVE", 10, 40, 20, .Black);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
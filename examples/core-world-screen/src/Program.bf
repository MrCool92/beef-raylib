/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_world_screen.c
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

namespace core_world_screen;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - core world screen");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(10f, 10f, 10f);
        camera.target = .Zero;
        camera.up = .Up;
        camera.fovy = 45f;
        camera.projection = .Perspective;

        Vector3 cubePosition = .Zero;
        Vector2 cubeScreenPosition = .Zero;

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .ThirdPerson);

            cubeScreenPosition = GetWorldToScreen(.(cubePosition.x, cubePosition.y + 2.5f, cubePosition.z), camera);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);
            DrawCube(cubePosition, 2f, 2f, 2f, .Red);
            DrawCubeWires(cubePosition, 2f, 2f, 2f, .Maroon);
            DrawGrid(10, 1f);
            EndMode3D();

            DrawText("Enemy: 100 / 100", (int32)cubeScreenPosition.x - MeasureText("Enemy: 100/100", 20) / 2, (int32)cubeScreenPosition.y, 20, .Black);

            DrawText(TextFormat("Cube position in screen space coordinates: [%i, %i]", (int32)cubeScreenPosition.x, (int32)cubeScreenPosition.y), 10, 10, 20, .Lime);
            DrawText("Text 2d should be always on top of the cube", 10, 40, 20, .Gray);
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_billboard.c
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
using Raylib.Raymath;

namespace models_billboard;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - drawing billboards");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(5f, 4f, 5f);
        camera.target = .(0f, 2f, 0f);
        camera.fovy = 45f;

        Texture2D bill = LoadTexture("../resources/billboard.png");
        defer UnloadTexture(bill);
        Vector3 billPositionStatic = .(0f, 2f, 0f);
        Vector3 billPositionRotating = .(1f, 2f, 1f);

        Rectangle source = .(0f, 0f, (float)bill.width, (float)bill.height);

        Vector3 billUp = .Up;

        Vector2 rotateOrigin = .();

        float distanceStatic;
        float distanceRotating;
        float rotation = 0f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            rotation += 0.4f;
            distanceStatic = Vector3Distance(camera.position, billPositionStatic);
            distanceRotating = Vector3Distance(camera.position, billPositionRotating);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawGrid(10, 1f);

            if (distanceStatic > distanceRotating)
            {
                DrawBillboard(camera, bill, billPositionStatic, 2.0f, .White);
                DrawBillboardPro(camera, bill, source, billPositionRotating, billUp, .One, rotateOrigin, rotation, .White);
            }
            else
            {
                DrawBillboardPro(camera, bill, source, billPositionRotating, billUp, .One, rotateOrigin, rotation, .White);
                DrawBillboard(camera, bill, billPositionStatic, 2.0f, .White);
            }

            EndMode3D();

            DrawFPS(10, 10);
        }

        return 0;
    }
}
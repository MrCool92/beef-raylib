/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_rlgl_solar_system.c
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
using Raylib.Rlgl;

namespace models_rlgl_solar_system;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        const float sunRadius = 4f;
        const float earthRadius = 0.6f;
        const float earthOrbitRadius = 8f;
        const float moonRadius = 0.16f;
        const float moonOrbitRadius = 1.5f;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - rlgl module usage with push/pop matrix transformations");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(16f, 16f, 16f);
        camera.fovy = 45f;

        float rotationSpeed = 0.2f;

        float earthRotation = 0f;
        float earthOrbitRotation = 0f;
        float moonRotation = 0f;
        float moonOrbitRotation = 0f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            earthRotation += (5f * rotationSpeed);
            earthOrbitRotation += (365 / 360f * (5f * rotationSpeed) * rotationSpeed);
            moonRotation += (2f * rotationSpeed);
            moonOrbitRotation += (8f * rotationSpeed);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            rlPushMatrix();
            rlScalef(sunRadius, sunRadius, sunRadius);
            DrawSphereBasic(.Gold);
            rlPopMatrix();

            rlPushMatrix();
            rlRotatef(earthOrbitRotation, 0f, 1f, 0f);
            rlTranslatef(earthOrbitRadius, 0f, 0f);

            rlPushMatrix();
            rlRotatef(earthRotation, 0.25f, 1f, 0f);
            rlScalef(earthRadius, earthRadius, earthRadius);

            DrawSphereBasic(.Blue);
            rlPopMatrix();

            rlRotatef(moonOrbitRotation, 0f, 1f, 0f);
            rlTranslatef(moonOrbitRadius, 0f, 0f);
            rlRotatef(moonRotation, 0f, 1f, 0f);
            rlScalef(moonRadius, moonRadius, moonRadius);

            DrawSphereBasic(.LightGray);
            rlPopMatrix();

            DrawCircle3D(.Zero, earthOrbitRadius, .Right, 90f, Fade(.Red, 0.5f));
            DrawGrid(20, 1f);

            EndMode3D();

            DrawText("EARTH ORBITING AROUND THE SUN!", 400, 10, 20, .Maroon);
            DrawFPS(10, 10);
        }

        return 0;
    }

    private static void DrawSphereBasic(Color color)
    {
        int32 rings = 16;
        int32 slices = 16;

        rlCheckRenderBatchLimit((rings + 2) * slices * 6);

        rlBegin(RL_TRIANGLES);
        rlColor4ub(color.r, color.g, color.b, color.a);

        for (int i = 0; i < (rings + 2); i++)
        {
            for (int j = 0; j < slices; j++)
            {
                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * i)) * Math.Sin(DEG2RAD * (j * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * i)),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * i)) * Math.Cos(DEG2RAD * (j * 360 / slices)));
                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Sin(DEG2RAD * ((j + 1) * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Cos(DEG2RAD * ((j + 1) * 360 / slices)));
                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Sin(DEG2RAD * (j * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Cos(DEG2RAD * (j * 360 / slices)));

                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * i)) * Math.Sin(DEG2RAD * (j * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * i)),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * i)) * Math.Cos(DEG2RAD * (j * 360 / slices)));
                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i))) * Math.Sin(DEG2RAD * ((j + 1) * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * (i))),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i))) * Math.Cos(DEG2RAD * ((j + 1) * 360 / slices)));
                rlVertex3f(Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Sin(DEG2RAD * ((j + 1) * 360 / slices)),
                    Math.Sin(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))),
                    Math.Cos(DEG2RAD * (270 + (180 / (rings + 1)) * (i + 1))) * Math.Cos(DEG2RAD * ((j + 1) * 360 / slices)));
            }
        }
        rlEnd();
    }
}
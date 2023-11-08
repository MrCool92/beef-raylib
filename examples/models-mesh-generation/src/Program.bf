/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_mesh_generation.c
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

namespace models_mesh_generation;

public static
{
    public const int NUM_MODELS = 9;
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - mesh generation");
        defer CloseWindow();

        Image @checked = GenImageChecked(2, 2, 1, 1, .Red, .Green);
        Texture2D texture = LoadTextureFromImage(@checked);
        defer UnloadTexture(texture);
        UnloadImage(@checked);

        Model[NUM_MODELS] models = .();

        models[0] = LoadModelFromMesh(GenMeshPlane(2, 2, 5, 5));
        models[1] = LoadModelFromMesh(GenMeshCube(2f, 1f, 2f));
        models[2] = LoadModelFromMesh(GenMeshSphere(2, 32, 32));
        models[3] = LoadModelFromMesh(GenMeshHemiSphere(2, 16, 16));
        models[4] = LoadModelFromMesh(GenMeshCylinder(1, 2, 16));
        models[5] = LoadModelFromMesh(GenMeshTorus(0.25f, 4f, 16, 32));
        models[6] = LoadModelFromMesh(GenMeshKnot(1f, 2f, 16, 128));
        models[7] = LoadModelFromMesh(GenMeshPoly(5, 2f));
        models[8] = LoadModelFromMesh(GenMeshCustom());

        for (int i < NUM_MODELS)
        {
            models[i].materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;
            defer:: UnloadModel(models[i]);
        }

        Camera camera = .();
        camera.position = .(5f, 5f, 5f);
        camera.fovy = 45f;

        Vector3 position = .Zero;

        int currentModel = 0;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .Orbital);

            if (IsMouseButtonPressed(.Left))
                currentModel = (currentModel + 1) % NUM_MODELS;

            if (IsKeyPressed(.Right))
            {
                if (++currentModel >= NUM_MODELS)
                    currentModel = 0;
            }
            else if (IsKeyPressed(.Left))
            {
                if (--currentModel < 0)
                    currentModel = NUM_MODELS - 1;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(models[currentModel], position, 1.0f, .White);
            DrawGrid(10, 1);

            EndMode3D();

            DrawRectangle(30, 400, 310, 30, Fade(.SkyBlue, 0.5f));
            DrawRectangleLines(30, 400, 310, 30, Fade(.DarkBlue, 0.5f));
            DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL MODELS", 40, 410, 10, .Blue);

            switch (currentModel)
            {
            case 0: DrawText("PLANE", 680, 10, 20, .DarkBlue);
            case 1: DrawText("CUBE", 680, 10, 20, .DarkBlue);
            case 2: DrawText("SPHERE", 680, 10, 20, .DarkBlue);
            case 3: DrawText("HEMISPHERE", 640, 10, 20, .DarkBlue);
            case 4: DrawText("CYLINDER", 680, 10, 20, .DarkBlue);
            case 5: DrawText("TORUS", 680, 10, 20, .DarkBlue);
            case 6: DrawText("KNOT", 680, 10, 20, .DarkBlue);
            case 7: DrawText("POLY", 680, 10, 20, .DarkBlue);
            case 8: DrawText("Custom (triangle)", 580, 10, 20, .DarkBlue);
            default:
            }
        }

        return 0;
    }

    private static Mesh GenMeshCustom()
    {
        Mesh mesh = .();
        mesh.triangleCount = 1;
        mesh.vertexCount = mesh.triangleCount * 3;
        mesh.vertices = (float*)MemAlloc((uint32)mesh.vertexCount * 3 * sizeof(float));
        mesh.texcoords = (float*)MemAlloc((uint32)mesh.vertexCount * 2 * sizeof(float));
        mesh.normals = (float*)MemAlloc((uint32)mesh.vertexCount * 3 * sizeof(float));

        mesh.vertices[0] = 0;
        mesh.vertices[1] = 0;
        mesh.vertices[2] = 0;
        mesh.normals[0] = 0;
        mesh.normals[1] = 1;
        mesh.normals[2] = 0;
        mesh.texcoords[0] = 0;
        mesh.texcoords[1] = 0;

        mesh.vertices[3] = 1;
        mesh.vertices[4] = 0;
        mesh.vertices[5] = 2;
        mesh.normals[3] = 0;
        mesh.normals[4] = 1;
        mesh.normals[5] = 0;
        mesh.texcoords[2] = 0.5f;
        mesh.texcoords[3] = 1.0f;

        mesh.vertices[6] = 2;
        mesh.vertices[7] = 0;
        mesh.vertices[8] = 0;
        mesh.normals[6] = 0;
        mesh.normals[7] = 1;
        mesh.normals[8] = 0;
        mesh.texcoords[4] = 1;
        mesh.texcoords[5] = 0;

        UploadMesh(&mesh, false);

        return mesh;
    }
}
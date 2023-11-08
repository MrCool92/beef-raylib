/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_mesh_picking.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Joel Davis (@joeld42) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;
using Raylib.Raymath;

namespace models_mesh_picking;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - mesh picking");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(20f, 20f, 20f);
        camera.target = .(0f, 8f, 0f);
        camera.up = .(0f, 1.6f, 0f);
        camera.fovy = 45f;

        Ray ray = .();

        Model tower = LoadModel("../resources/models/obj/turret.obj");
        defer UnloadModel(tower);
        Texture2D texture = LoadTexture("../resources/models/obj/turret_diffuse.png");
        defer UnloadTexture(texture);
        tower.materials[0].maps[(int32)MaterialMapIndex.Albedo].texture = texture;

        Vector3 towerPos = .Zero;
        BoundingBox towerBBox = GetMeshBoundingBox(tower.meshes[0]);

        Vector3 g0 = .(-50f, 0f, -50f);
        Vector3 g1 = .(-50f, 0f,  50f);
        Vector3 g2 = .(50f, 0f,  50f);
        Vector3 g3 = .(50f, 0f, -50f);

        Vector3 ta = .(-25f, 0.5f, 0f);
        Vector3 tb = .(-4f, 2.5f, 1f);
        Vector3 tc = .(-8f, 6.5f, 0f);

        Vector3 bary = .Zero;

        Vector3 sp = .(-30f, 5f, 5f);
        float sr = 4f;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsCursorHidden())
                UpdateCamera(&camera, .FirstPerson);

            if (IsMouseButtonPressed(.Right))
            {
                if (IsCursorHidden())
                    EnableCursor();
                else
                    DisableCursor();
            }

            RayCollision collision = .();
            char8* hitObjectName = "None";
            collision.distance = float.MaxValue;
            collision.hit = false;
            Color cursorColor = .White;

            ray = GetMouseRay(GetMousePosition(), camera);

            RayCollision groundHitInfo = GetRayCollisionQuad(ray, g0, g1, g2, g3);

            if ((groundHitInfo.hit) && (groundHitInfo.distance < collision.distance))
            {
                collision = groundHitInfo;
                cursorColor = .Green;
                hitObjectName = "Ground";
            }

            RayCollision triHitInfo = GetRayCollisionTriangle(ray, ta, tb, tc);

            if ((triHitInfo.hit) && (triHitInfo.distance < collision.distance))
            {
                collision = triHitInfo;
                cursorColor = .Purple;
                hitObjectName = "Triangle";

                bary = Vector3Barycenter(collision.point, ta, tb, tc);
            }

            RayCollision sphereHitInfo = GetRayCollisionSphere(ray, sp, sr);

            if ((sphereHitInfo.hit) && (sphereHitInfo.distance < collision.distance))
            {
                collision = sphereHitInfo;
                cursorColor = .Orange;
                hitObjectName = "Sphere";
            }

            RayCollision boxHitInfo = GetRayCollisionBox(ray, towerBBox);

            if ((boxHitInfo.hit) && (boxHitInfo.distance < collision.distance))
            {
                collision = boxHitInfo;
                cursorColor = .Orange;
                hitObjectName = "Box";

                RayCollision meshHitInfo = .();
                for (int m < tower.meshCount)
                {
                    meshHitInfo = GetRayCollisionMesh(ray, tower.meshes[m], tower.transform);
                    if (meshHitInfo.hit)
                    {
                        if ((!collision.hit) || (collision.distance > meshHitInfo.distance))
                            collision = meshHitInfo;

                        break;
                    }
                }

                if (meshHitInfo.hit)
                {
                    collision = meshHitInfo;
                    cursorColor = .Orange;
                    hitObjectName = "Mesh";
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawModel(tower, towerPos, 1f, .White);

            DrawLine3D(ta, tb, .Purple);
            DrawLine3D(tb, tc, .Purple);
            DrawLine3D(tc, ta, .Purple);

            DrawSphereWires(sp, sr, 8, 8, .Purple);

            if (boxHitInfo.hit)
                DrawBoundingBox(towerBBox, .Lime);

            if (collision.hit)
            {
                DrawCube(collision.point, 0.3f, 0.3f, 0.3f, cursorColor);
                DrawCubeWires(collision.point, 0.3f, 0.3f, 0.3f, .Red);

                Vector3 normalEnd;
                normalEnd.x = collision.point.x + collision.normal.x;
                normalEnd.y = collision.point.y + collision.normal.y;
                normalEnd.z = collision.point.z + collision.normal.z;

                DrawLine3D(collision.point, normalEnd, .Red);
            }

            DrawRay(ray, .Maroon);

            DrawGrid(10, 10f);

            EndMode3D();

            DrawText(TextFormat("Hit Object: %s", hitObjectName), 10, 50, 10, .Black);

            if (collision.hit)
            {
                int32 ypos = 70;

                DrawText(TextFormat("Distance: %3.2f", collision.distance), 10, ypos, 10, .Black);

                DrawText(TextFormat("Hit Pos: %3.2f %3.2f %3.2f",
                    collision.point.x,
                    collision.point.y,
                    collision.point.z), 10, ypos + 15, 10, .Black);

                DrawText(TextFormat("Hit Norm: %3.2f %3.2f %3.2f",
                    collision.normal.x,
                    collision.normal.y,
                    collision.normal.z), 10, ypos + 30, 10, .Black);

                if (triHitInfo.hit && TextIsEqual(hitObjectName, "Triangle"))
                    DrawText(TextFormat("Barycenter: %3.2f %3.2f %3.2f",  bary.x, bary.y, bary.z), 10, ypos + 45, 10, .Black);
            }

            DrawText("Right click mouse to toggle camera controls", 10, 430, 10, .Gray);

            DrawText("(c) Turret 3D model by Alberto Cano", screenWidth - 200, screenHeight - 20, 10, .Gray);

            DrawFPS(10, 10);
        }

        return 0;
    }
}
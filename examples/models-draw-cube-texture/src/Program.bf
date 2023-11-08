/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_draw_cube_texture.c
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

namespace models_draw_cube_texture;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - draw cube texture");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .(0f, 10f, 10f);
        camera.fovy = 45f;

        Texture2D texture = LoadTexture("../resources/cubicmap_atlas.png");
        defer UnloadTexture(texture);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            DrawCubeTexture(texture, .(-2f, 2f, 0f), 2f, 4f, 2f, .White);

            DrawCubeTextureRec(texture, .(0, texture.height / 2, texture.width / 2, texture.height / 2), .(2f, 1f, 0f), 2f, 2f, 2f, .White);

            DrawGrid(10, 1f);

            EndMode3D();

            DrawFPS(10, 10);
        }

        return 0;
    }

    private static void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color)
    {
        float x = position.x;
        float y = position.y;
        float z = position.z;

        rlSetTexture(texture.id);

        rlBegin(RL_QUADS);
        rlColor4ub(color.r, color.g, color.b, color.a);

        rlNormal3f(0f, 0f, 1f);
        rlTexCoord2f(0f, 0f); rlVertex3f(x - width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f(1f, 0f); rlVertex3f(x + width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f(1f, 1f); rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(0f, 1f); rlVertex3f(x - width / 2, y + height / 2, z + length / 2);

        rlNormal3f(0f, 0f, -1f);
        rlTexCoord2f(1f, 0f); rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(1f, 1f); rlVertex3f(x - width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(0f, 1f); rlVertex3f(x + width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(0f, 0f); rlVertex3f(x + width / 2, y - height / 2, z - length / 2);

        rlNormal3f(0f, 1f, 0.0f);
        rlTexCoord2f(0f, 1f); rlVertex3f(x - width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(0f, 0f); rlVertex3f(x - width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(1f, 0f); rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(1f, 1f); rlVertex3f(x + width / 2, y + height / 2, z - length / 2);

        rlNormal3f(0f, -1f, 0f);
        rlTexCoord2f(1f, 1f); rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(0f, 1f); rlVertex3f(x + width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(0f, 0f); rlVertex3f(x + width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f(1f, 0f); rlVertex3f(x - width / 2, y - height / 2, z + length / 2);

        rlNormal3f(1f, 0f, 0f);
        rlTexCoord2f(1f, 0f); rlVertex3f(x + width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(1f, 1f); rlVertex3f(x + width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(0f, 1f); rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(0f, 0f); rlVertex3f(x + width / 2, y - height / 2, z + length / 2);

        rlNormal3f(-1f, 0f, 0f);
        rlTexCoord2f(0f, 0f); rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(1f, 0f); rlVertex3f(x - width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f(1f, 1f); rlVertex3f(x - width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(0f, 1f); rlVertex3f(x - width / 2, y + height / 2, z - length / 2);
        rlEnd();

        rlSetTexture(0);
    }

    private static void DrawCubeTextureRec(Texture2D texture, Rectangle source, Vector3 position, float width, float height, float length, Color color)
    {
        float x = position.x;
        float y = position.y;
        float z = position.z;
        float texWidth = (float)texture.width;
        float texHeight = (float)texture.height;

        rlSetTexture(texture.id);

        rlBegin(RL_QUADS);
        rlColor4ub(color.r, color.g, color.b, color.a);

        rlNormal3f(0f, 0f, 1f);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z + length / 2);

        rlNormal3f(0f, 0f, -1f);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z - length / 2);

        rlNormal3f(0f, 1f, 0f);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z - length / 2);

        rlNormal3f(0f, -1f, 0f);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z + length / 2);

        rlNormal3f(1f, 0f, 0f);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z - length / 2);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x + width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x + width / 2, y - height / 2, z + length / 2);

        rlNormal3f(-1f, 0f, 0f);
        rlTexCoord2f(source.x / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z - length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, (source.y + source.height) / texHeight);
        rlVertex3f(x - width / 2, y - height / 2, z + length / 2);
        rlTexCoord2f((source.x + source.width) / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z + length / 2);
        rlTexCoord2f(source.x / texWidth, source.y / texHeight);
        rlVertex3f(x - width / 2, y + height / 2, z - length / 2);

        rlEnd();

        rlSetTexture(0);
    }
}
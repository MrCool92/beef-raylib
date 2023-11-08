/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/audio/audio_module_playing.c
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

namespace audio_module_playing;

public static
{
    public const int MAX_CIRCLES = 64;
}

public struct CircleWave
{
    public Vector2 position;
    public float radius;
    public float alpha;
    public float speed;
    public Color color;
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        SetConfigFlags(.Msaa4xHint);

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - module playing (streaming)");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        Color[14] colors = .(.Orange, .Red, .Gold, .Lime, .Blue, .Violet, .Brown, .LightGray, .Pink,
            .Yellow, .Green, .SkyBlue, .Purple, .Beige);

        CircleWave[MAX_CIRCLES] circles = .();

        for (int i = MAX_CIRCLES - 1; i >= 0; i--)
        {
            circles[i].alpha = 0.0f;
            circles[i].radius = (float)GetRandomValue(10, 40);
            circles[i].position.x = (float)GetRandomValue((int32)circles[i].radius, (int32)(screenWidth - circles[i].radius));
            circles[i].position.y = (float)GetRandomValue((int32)circles[i].radius, (int32)(screenHeight - circles[i].radius));
            circles[i].speed = (float)GetRandomValue(1, 100) / 2000.0f;
            circles[i].color = colors[GetRandomValue(0, 13)];
        }

        Music music = LoadMusicStream("../resources/mini1111.xm");
        defer UnloadMusicStream(music);
        music.looping = false;
        float pitch = 1f;

        PlayMusicStream(music);
        float timePlayed = 0f;
        bool pause = false;

        SetTargetFPS(60);
        while (!WindowShouldClose())
        {
            UpdateMusicStream(music);

            if (IsKeyPressed(.Space))
            {
                StopMusicStream(music);
                PlayMusicStream(music);
            }

            if (IsKeyPressed(.P))
            {
                pause = !pause;

                if (pause)
                    PauseMusicStream(music);
                else
                    ResumeMusicStream(music);
            }

            if (IsKeyDown(.Down))
                pitch -= 0.01f;
            else if (IsKeyDown(.Up))
                pitch += 0.01f;

            SetMusicPitch(music, pitch);

            timePlayed = GetMusicTimePlayed(music) / GetMusicTimeLength(music) * (screenWidth - 40);

            for (int i = MAX_CIRCLES - 1; (i >= 0) && !pause; i--)
            {
                circles[i].alpha += circles[i].speed;
                circles[i].radius += circles[i].speed * 10.0f;

                if (circles[i].alpha > 1.0f) circles[i].speed *= -1;

                if (circles[i].alpha <= 0.0f)
                {
                    circles[i].alpha = 0.0f;
                    circles[i].radius = (float)GetRandomValue(10, 40);
                    circles[i].position.x = (float)GetRandomValue((int32)circles[i].radius, (int32)(screenWidth - circles[i].radius));
                    circles[i].position.y = (float)GetRandomValue((int32)circles[i].radius, (int32)(screenHeight - circles[i].radius));
                    circles[i].color = colors[GetRandomValue(0, 13)];
                    circles[i].speed = (float)GetRandomValue(1, 100) / 2000.0f;
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            for (int i = MAX_CIRCLES - 1; i >= 0; i--)
                DrawCircleV(circles[i].position, circles[i].radius, Fade(circles[i].color, circles[i].alpha));

            DrawRectangle(20, screenHeight - 20 - 12, screenWidth - 40, 12, .LightGray);
            DrawRectangle(20, screenHeight - 20 - 12, (int32)timePlayed, 12, .Maroon);
            DrawRectangleLines(20, screenHeight - 20 - 12, screenWidth - 40, 12, .Gray);
        }

        return 0;
    }
}
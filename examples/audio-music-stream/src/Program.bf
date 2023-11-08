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

namespace audio_music_stream;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - music playing (streaming)");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        Music music = LoadMusicStream("../resources/country.mp3");
        defer UnloadMusicStream(music);

        PlayMusicStream(music);

        float timePlayed = 0f;
        bool pause = false;

        SetTargetFPS(30);

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

            timePlayed = GetMusicTimePlayed(music) / GetMusicTimeLength(music);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, .LightGray);

            DrawRectangle(200, 200, 400, 12, .LightGray);
            DrawRectangle(200, 200, (int32)(timePlayed * 400.0f), 12, .Maroon);
            DrawRectangleLines(200, 200, 400, 12, .Gray);

            DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, .LightGray);
            DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, .LightGray);
        }

        return 0;
    }
}
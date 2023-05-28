/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/audio/audio_sound_loading.c
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

namespace audio_sound_loading;

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - sound loading and playing");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        Sound fxWav = LoadSound("../resources/sound.wav");
        defer UnloadSound(fxWav);

        Sound fxOgg = LoadSound("../resources/target.ogg");
        defer UnloadSound(fxOgg);

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.Space))
                PlaySound(fxWav);
            if (IsKeyPressed(.Enter))
                PlaySound(fxOgg);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText("Press SPACE to PLAY the WAV sound!", 200, 180, 20, .LightGray);
            DrawText("Press ENTER to PLAY the OGG sound!", 200, 220, 20, .LightGray);
        }

        return 0;
    }
}
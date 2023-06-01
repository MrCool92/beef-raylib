/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/audio/audio_mixed_processor.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*        - fixed sound not unloading
*
*    Credits:
*        hkc (@hatkidchan) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace audio_mixed_processor;

public static
{
    public static float exponent = 1f;
    public static float[] averageVolume = new float[400] ~ delete _;
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - processing mixed output");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        AttachAudioMixedProcessor( => ProcessAudio);
        defer DetachAudioMixedProcessor( => ProcessAudio);

        Music music = LoadMusicStream("../resources/country.mp3");
        defer UnloadMusicStream(music);

        Sound sound = LoadSound("../resources/coin.wav");
        defer UnloadSound(sound);

        PlayMusicStream(music);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateMusicStream(music);

            if (IsKeyPressed(.Left))
                exponent -= 0.05f;

            if (IsKeyPressed(.Right))
                exponent += 0.05f;

            if (exponent <= 0.5f)
                exponent = 0.5f;

            if (exponent >= 3f)
                exponent = 3f;

            if (IsKeyPressed(.Space))
                PlaySound(sound);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, .LightGray);

            DrawText(TextFormat("EXPONENT = %.2f", exponent), 215, 180, 20, .LightGray);

            DrawRectangle(199, 199, 402, 34, .LightGray);
            for (int32 i < 400)
                DrawLine(201 + i, (int32)(232 - averageVolume[i] * 32), 201 + i, 232, .Maroon);
            DrawRectangleLines(199, 199, 402, 34, .Gray);

            DrawText("PRESS SPACE TO PLAY OTHER SOUND", 200, 250, 20, .LightGray);
            DrawText("USE LEFT AND RIGHT ARROWS TO ALTER DISTORTION", 140, 280, 20, .LightGray);
        }

        return 0;
    }

    private static void ProcessAudio(void* buffer, uint32 frames)
    {
        float* samples = (float*)buffer;
        float average = 0f;

        for (uint32 frame < frames)
        {
            float* left = &samples[frame * 2 + 0];
            float* right = &samples[frame * 2 + 1];

            *left = Math.Pow(Math.Abs(*left), exponent) * ((*left < 0f) ? -1f : 1f);
            *right = Math.Pow(Math.Abs(*right), exponent) * ((*right < 0f) ? -1f : 1f);

            average += Math.Abs(*left) / frames;
            average += Math.Abs(*right) / frames;
        }

        for (int i < 399)
            averageVolume[i] = averageVolume[i + 1];

        averageVolume[399] = average;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/audio/audio_stream_effects.c
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

namespace audio_stream_effects;

public static
{
    public static float* delayBuffer = null;
    public static uint delayBufferSize = 0;
    public static uint delayReadIndex = 2;
    public static uint delayWriteIndex = 0;
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - stream effects");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        Music music = LoadMusicStream("../resources/country.mp3");
        defer UnloadMusicStream(music);

        delayBufferSize = 48000 * 2;
        delayBuffer = scope float[delayBufferSize]*;

        PlayMusicStream(music);

        float timePlayed = 0;
        bool pause = false;

        bool enableEffectLPF = false;
        bool enableEffectDelay = false;

        SetTargetFPS(60);

        while (!WindowShouldClose()) // Detect window close button or ESC key
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

            if (IsKeyPressed(.F))
            {
                enableEffectLPF = !enableEffectLPF;
                if (enableEffectLPF)
                    AttachAudioStreamProcessor(music.stream, => AudioProcessEffectLPF);
                else
                    DetachAudioStreamProcessor(music.stream, => AudioProcessEffectLPF);
            }

            if (IsKeyPressed(.D))
            {
                enableEffectDelay = !enableEffectDelay;
                if (enableEffectDelay)
                    AttachAudioStreamProcessor(music.stream, => AudioProcessEffectDelay);
                else
                    DetachAudioStreamProcessor(music.stream, => AudioProcessEffectDelay);
            }

            timePlayed = GetMusicTimePlayed(music) / GetMusicTimeLength(music);

            if (timePlayed > 1f)
                timePlayed = 1f;

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText("MUSIC SHOULD BE PLAYING!", 245, 150, 20, .LightGray);

            DrawRectangle(200, 180, 400, 12, .LightGray);
            DrawRectangle(200, 180, (int32)(timePlayed * 400f), 12, .Maroon);
            DrawRectangleLines(200, 180, 400, 12, .Gray);

            DrawText("PRESS SPACE TO RESTART MUSIC", 215, 230, 20, .LightGray);
            DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 260, 20, .LightGray);

            DrawText(TextFormat("PRESS F TO TOGGLE LPF EFFECT: %s", enableEffectLPF ? "ON" : "OFF"), 200, 320, 20, .Gray);
            DrawText(TextFormat("PRESS D TO TOGGLE DELAY EFFECT: %s", enableEffectDelay ? "ON" : "OFF"), 180, 350, 20, .Gray);
        }

        return 0;
    }

    private static void AudioProcessEffectLPF(void* buffer, uint32 frames)
    {
        static float[2] low = .(0f, 0f);
        static let cutoff = 70f / 44100f;
        let k = cutoff / (cutoff + 0.1591549431f);

        for (uint32 i = 0; i < frames * 2; i += 2)
        {
            float l = ((float*)buffer)[i];
            float r = ((float*)buffer)[i + 1];
            low[0] += k * (l - low[0]);
            low[1] += k * (r - low[1]);
            ((float*)buffer)[i] = low[0];
            ((float*)buffer)[i + 1] = low[1];
        }
    }

    private static void AudioProcessEffectDelay(void* buffer, uint32 frames)
    {
        for (uint32 i = 0; i < frames * 2; i += 2)
        {
            float leftDelay = delayBuffer[delayReadIndex++];
            float rightDelay = delayBuffer[delayReadIndex++];

            if (delayReadIndex == delayBufferSize)
                delayReadIndex = 0;

            ((float*)buffer)[i] = 0.5f * ((float*)buffer)[i] + 0.5f * leftDelay;
            ((float*)buffer)[i + 1] = 0.5f * ((float*)buffer)[i + 1] + 0.5f * rightDelay;

            delayBuffer[delayWriteIndex++] = ((float*)buffer)[i];
            delayBuffer[delayWriteIndex++] = ((float*)buffer)[i + 1];
            if (delayWriteIndex == delayBufferSize)
                delayWriteIndex = 0;
        }
    }
}
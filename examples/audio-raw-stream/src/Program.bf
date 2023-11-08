/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/audio/audio_raw_stream.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*
*    Credits:
*        Ramon Santamaria (@raysan5) and James Hofmann (@triplefox) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace audio_raw_stream;

public static
{
    public const int MAX_SAMPLES = 512;
    public const int MAX_SAMPLES_PER_UPDATE = 4096;

    public static float frequency = 440f;
    public static float audioFrequency = 440f;
    public static float oldFrequency = 1f;
    public static float sineIdx = 0f;
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [audio] example - raw audio streaming");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        SetAudioStreamBufferSizeDefault(MAX_SAMPLES_PER_UPDATE);

        AudioStream stream = LoadAudioStream(44100, 16, 1);
        defer UnloadAudioStream(stream);

        SetAudioStreamCallback(stream, => AudioInputCallback);

        int16* data = scope int16[MAX_SAMPLES]*;

        PlayAudioStream(stream);

        Vector2 mousePosition = .(-100f, -100f);

        int waveLength = 1;
        Vector2 position = .Zero;

        SetTargetFPS(30);

        while (!WindowShouldClose())
        {
            mousePosition = GetMousePosition();

            if (IsMouseButtonDown(.Left))
            {
                float fp = mousePosition.y;
                frequency = 40f + fp;

                float pan = mousePosition.x / (float)screenWidth;
                SetAudioStreamPan(stream, pan);
            }

            if (frequency != oldFrequency)
            {
                waveLength = (int)(22050 / frequency);

                if (waveLength > MAX_SAMPLES / 2)
                    waveLength = MAX_SAMPLES / 2;

                if (waveLength < 1)
                    waveLength = 1;

                for (int i < waveLength * 2)
                    data[i] = (int16)(Math.Sin(((2 * Math.PI_f * (float)i / waveLength))) * 32000);

                for (int j = waveLength * 2; j < MAX_SAMPLES; j++)
                    data[j] = 0;

                oldFrequency = frequency;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText(TextFormat("sine frequency: %i", (int32)frequency), GetScreenWidth() - 220, 10, 20, .Red);
            DrawText("click mouse button to change frequency or pan", 10, 10, 20, .DarkGray);

            for (int i < screenWidth)
            {
                position.x = i;
                position.y = 250 + 50f * data[i * MAX_SAMPLES / screenWidth] / 32000f;

                DrawPixelV(position, .Red);
            }
        }

        return 0;
    }

    private static void AudioInputCallback(void* buffer, uint32 frames)
    {
        audioFrequency = frequency + (audioFrequency - frequency) * 0.95f;
        audioFrequency += 1f;
        audioFrequency -= 1f;
        float incr = audioFrequency / 44100f;
        int16* d = (int16*)buffer;

        for (uint32 i = 0; i < frames; i++)
        {
            d[i] = (int16)(32000f * Math.Sin(2 * Math.PI_f * sineIdx));
            sineIdx += incr;

            if (sineIdx > 1f)
                sineIdx -= 1f;
        }
    }
}
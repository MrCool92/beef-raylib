/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/b59fab7ee6035886554778e8adc540deb3f29f4a/examples/others/embedded_files_loading.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Kristian Holmgren (@defutura) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

using static resources.AudioData;
using static resources.ImageData;
namespace embedded_files_loading;

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [others] example - embedded files loading");
        defer CloseWindow();

        InitAudioDevice();
        defer CloseAudioDevice();

        Wave wave = .()
            {
                data = ((Span<uint8>)AUDIO_DATA).Ptr,
                frameCount = AUDIO_FRAME_COUNT,
                sampleRate = AUDIO_SAMPLE_RATE,
                sampleSize = AUDIO_SAMPLE_SIZE,
                channels = AUDIO_CHANNELS
            };

        Sound sound = LoadSoundFromWave(wave);
        defer UnloadSound(sound);

        Image image = .()
            {
                data = ((Span<uint8>)IMAGE_DATA).Ptr,
                width = IMAGE_WIDTH,
                height = IMAGE_HEIGHT,
                format = (PixelFormat)IMAGE_FORMAT,
                mipmaps = 1
            };

        Texture2D texture = LoadTextureFromImage(image);
        defer UnloadTexture(texture);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.Space))
                PlaySound(sound);

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawTexture(texture, screenWidth / 2 - texture.width / 2, 40, .White);

            DrawText("raylib logo and sound loaded from header files", 150, 320, 20, .LightGray);
            DrawText("Press SPACE to PLAY the sound!", 220, 370, 20, .LightGray);
        }

        return 0;
    }
}
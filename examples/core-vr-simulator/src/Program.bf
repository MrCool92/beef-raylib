/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_vr_simulator.c
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

namespace core_vr_simulator;

#if BF_PLATFORM_WINDOWS || BF_PLATFORM_MACOS || BF_PLATFORM_LINUX
    #define PLATFORM_DESKTOP
#endif

public static
{
#if PLATFORM_DESKTOP
    public const int32 GLSL_VERSION = 330;
#else
    public const int32 GLSL_VERSION = 100;
#endif
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - vr simulator");
        defer CloseWindow();

        VrDeviceInfo device = VrDeviceInfo()
            {
                hResolution = 2160,
                vResolution = 1200,
                hScreenSize = 0.133793f,
                vScreenSize = 0.0669f,
                vScreenCenter = 0.04678f,
                eyeToScreenDistance = 0.041f,
                lensSeparationDistance = 0.07f,
                interpupillaryDistance = 0.07f,

                lensDistortionValues = .(1f, 0.22f, 0.24f, 0f),
                chromaAbCorrection = .(0.996f, -0.004f, 1.014f, 0f)
            };

        VrStereoConfig config = LoadVrStereoConfig(device);
        defer UnloadVrStereoConfig(config);

        Shader distortion = LoadShader(null, TextFormat("../resources/distortion%i.fs", GLSL_VERSION));
        defer UnloadShader(distortion);

        SetShaderValue(distortion, GetShaderLocation(distortion, "leftLensCenter"), &config.leftLensCenter[0], .UniformVec2);
        SetShaderValue(distortion, GetShaderLocation(distortion, "rightLensCenter"), &config.rightLensCenter[0], .UniformVec2);
        SetShaderValue(distortion, GetShaderLocation(distortion, "leftScreenCenter"), &config.leftScreenCenter[0], .UniformVec2);
        SetShaderValue(distortion, GetShaderLocation(distortion, "rightScreenCenter"), &config.rightScreenCenter[0], .UniformVec2);

        SetShaderValue(distortion, GetShaderLocation(distortion, "scale"), &config.scale[0], .UniformVec2);
        SetShaderValue(distortion, GetShaderLocation(distortion, "scaleIn"), &config.scaleIn[0], .UniformVec2);
        SetShaderValue(distortion, GetShaderLocation(distortion, "deviceWarpParam"), &device.lensDistortionValues[0], .UniformVec4);
        SetShaderValue(distortion, GetShaderLocation(distortion, "chromaAbParam"), &device.chromaAbCorrection[0], .UniformVec4);

        RenderTexture2D target = LoadRenderTexture(device.hResolution, device.vResolution);
        defer UnloadRenderTexture(target);

        Rectangle sourceRec = .(0f, 0f, (float)target.texture.width, -(float)target.texture.height);
        Rectangle destRec = .(0f, 0f, (float)GetScreenWidth(), (float)GetScreenHeight());

        Camera camera = .();
        camera.position = .(5f, 2f, 5f);
        camera.target = .(0f, 2f, 0f);

        Vector3 cubePosition = .Zero;

        DisableCursor();

        SetTargetFPS(90);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .FirstPerson);

            BeginTextureMode(target);

            ClearBackground(.RayWhite);
            BeginVrStereoMode(config);

            BeginMode3D(camera);

            DrawCube(cubePosition, 2f, 2f, 2f, .Red);
            DrawCubeWires(cubePosition, 2f, 2f, 2f, .Maroon);
            DrawGrid(40, 1f);

            EndMode3D();

            EndVrStereoMode();

            EndTextureMode();

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);
            BeginShaderMode(distortion);

            DrawTexturePro(target.texture, sourceRec, destRec, .Zero, 0, .White);

            EndShaderMode();
            DrawFPS(10, 10);
        }

        return 0;
    }
}
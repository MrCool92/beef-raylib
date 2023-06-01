/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/models/models_skybox.c
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
using Raylib.Raymath;

namespace models_skybox;

public static
{
#if BF_PLATFORM_WINDOWS || BF_PLATFORM_MACOS || BF_PLATFORM_LINUX
    public const int GLSL_VERSION = 330;
#else
    public const int GLSL_VERSION = 100;
#endif
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [models] example - skybox loading and drawing");
        defer CloseWindow();

        Camera camera = .();
        camera.position = .One;
        camera.target = .(4f, 1f, 4f);
        camera.fovy = 45f;

        Mesh cube = GenMeshCube(1f, 1f, 1f);
        Model skybox = LoadModelFromMesh(cube);

        bool useHDR = true;

        skybox.materials[0].shader = LoadShader(
            TextFormat("../resources/shaders/glsl%i/skybox.vs", GLSL_VERSION),
            TextFormat("../resources/shaders/glsl%i/skybox.fs", GLSL_VERSION)
            );

        SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "environmentMap"), scope int[]* ((int32)MaterialMapIndex.Cubemap), .UniformInt);
        SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "doGamma"), scope int[]* (useHDR ? 1 : 0), .UniformInt);
        SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "vflipped"), scope int[]* (useHDR ? 1 : 0), .UniformInt);

        Shader shdrCubemap = LoadShader(
            TextFormat("../resources/shaders/glsl%i/cubemap.vs", GLSL_VERSION),
            TextFormat("../resources/shaders/glsl%i/cubemap.fs", GLSL_VERSION)
            );

        SetShaderValue(shdrCubemap, GetShaderLocation(shdrCubemap, "equirectangularMap"), scope int[]* (0), .UniformInt);

        String skyboxFileName = scope .();

        if (useHDR)
        {
            skyboxFileName = "../resources/dresden_square_2k.hdr";
            Texture2D panorama = LoadTexture(skyboxFileName);
            skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture = GenTextureCubemap(shdrCubemap, panorama, 1024, .UncompressedR8G8B8A8);
        }
        else
        {
            Image img = LoadImage("../resources/skybox.png");
            skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture = LoadTextureCubemap(img, .AutoDetect);
            UnloadImage(img);
        }

        DisableCursor();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            UpdateCamera(&camera, .FirstPerson);

            if (IsFileDropped())
            {
                FilePathList droppedFiles = LoadDroppedFiles();

                if (droppedFiles.count == 1)
                {
                    if (IsFileExtension(droppedFiles.paths[0], ".png;.jpg;.hdr;.bmp;.tga"))
                    {
                        UnloadTexture(skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture);
                        if (useHDR)
                        {
                            Texture2D panorama = LoadTexture(droppedFiles.paths[0]);
                            skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture = GenTextureCubemap(shdrCubemap, panorama, 1024, .UncompressedR8G8B8A8);
                            UnloadTexture(panorama);
                        }
                        else
                        {
                            Image img = LoadImage(droppedFiles.paths[0]);
                            skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture = LoadTextureCubemap(img, .AutoDetect);
                            UnloadImage(img);
                        }

                        droppedFiles.paths[0].ToString(skyboxFileName);
                    }
                }

                UnloadDroppedFiles(droppedFiles);
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            BeginMode3D(camera);

            rlDisableBackfaceCulling();
            rlDisableDepthMask();
            DrawModel(skybox, .Zero, 1f, .White);
            rlEnableBackfaceCulling();
            rlEnableDepthMask();

            DrawGrid(10, 1f);

            EndMode3D();

            if (useHDR)
                DrawText(TextFormat("Panorama image from hdrihaven.com: %s", GetFileName(skyboxFileName)), 10, GetScreenHeight() - 20, 10, .Black);
            else
                DrawText(TextFormat(": %s", GetFileName(skyboxFileName)), 10, GetScreenHeight() - 20, 10, .Black);

            DrawFPS(10, 10);
        }

        UnloadShader(shdrCubemap);
        UnloadShader(skybox.materials[0].shader);
        UnloadTexture(skybox.materials[0].maps[(int32)MaterialMapIndex.Cubemap].texture);

        UnloadModel(skybox);

        return 0;
    }

    private static TextureCubemap GenTextureCubemap(Shader shader, Texture2D panorama, int32 size, PixelFormat format)
    {
        TextureCubemap cubemap = .();

        rlDisableBackfaceCulling();

        uint32 rbo = rlLoadTextureDepth(size, size, true);
        cubemap.id = rlLoadTextureCubemap(null, size, format);

        uint32 fbo = rlLoadFramebuffer(size, size);
        rlFramebufferAttach(fbo, rbo, .Depth, .Renderbuffer, 0);
        rlFramebufferAttach(fbo, cubemap.id, .ColorChannel0, .CubemapPositiveX, 0);

        if (rlFramebufferComplete(fbo))
            TraceLog(.Info, "FBO: [ID %i] Framebuffer object created successfully", fbo);

        rlEnableShader(shader.id);

        Matrix matFboProjection = MatrixPerspective(90.0 * DEG2RAD, 1.0, RL_CULL_DISTANCE_NEAR, RL_CULL_DISTANCE_FAR);
        rlSetUniformMatrix(shader.locs[(int32)ShaderLocationIndex.MatrixProjection], matFboProjection);

        Matrix[6] fboViews = .(
            MatrixLookAt(.Zero, .(1f,  0f,  0f), .(0f, -1f,  0f)),
            MatrixLookAt(.Zero, .(-1f,  0f,  0f), .(0f, -1f,  0f)),
            MatrixLookAt(.Zero, .(0f,  1f,  0f), .(0f,  0f,  1f)),
            MatrixLookAt(.Zero, .(0f, -1f,  0f), .(0f,  0f, -1f)),
            MatrixLookAt(.Zero, .(0f,  0f,  1f), .(0f, -1f,  0f)),
            MatrixLookAt(.Zero, .(0f,  0f, -1f), .(0f, -1f,  0f))
            );

        rlViewport(0, 0, size, size);

        rlActiveTextureSlot(0);
        rlEnableTexture(panorama.id);

        for (int i < 6)
        {
            rlSetUniformMatrix(shader.locs[(int32)ShaderLocationIndex.MatrixView], fboViews[i]);

            rlFramebufferAttach(fbo, cubemap.id, .ColorChannel0, .CubemapPositiveX + i, 0);
            rlEnableFramebuffer(fbo);

            rlClearScreenBuffers();
            rlLoadDrawCube();
        }

        rlDisableShader();
        rlDisableTexture();
        rlDisableFramebuffer();
        rlUnloadFramebuffer(fbo);

        rlViewport(0, 0, rlGetFramebufferWidth(), rlGetFramebufferHeight());
        rlEnableBackfaceCulling();

        cubemap.width = size;
        cubemap.height = size;
        cubemap.mipmaps = 1;
        cubemap.format = format;

        return cubemap;
    }
}
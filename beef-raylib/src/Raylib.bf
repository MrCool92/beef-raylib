using System;

namespace Raylib;

static
{
    // Window-related functions
    /// Initialize window and OpenGL context
    [CLink, CallingConvention(.Cdecl)] public static extern void InitWindow(int32 width, int32 height, char8* title);
    /// Check if KEY_ESCAPE pressed or Close icon pressed
    [CLink, CallingConvention(.Cdecl)] public static extern bool WindowShouldClose();
    /// Close window and unload OpenGL context
    [CLink, CallingConvention(.Cdecl)] public static extern void CloseWindow();
    // TODO
    /// Check if one specific window flag is enabled
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsWindowState(ConfigFlags flag);
    /// Set window configuration state using flags (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetWindowState(ConfigFlags flags);
    /// Clear window configuration state flags
    [CLink, CallingConvention(.Cdecl)] public static extern void ClearWindowState(ConfigFlags flags);
    /// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void ToggleFullscreen();
    /// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void MaximizeWindow();
    /// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void MinimizeWindow();
    /// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void RestoreWindow();
    // TODO
    /// Set title for window (only PLATFORM_DESKTOP)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetWindowTitle(char8* title);
    // TODO
    /// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetWindowMinSize(int32 width, int32 height);
    // TODO
    /// Get current screen width
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetScreenWidth();
    /// Get current screen height
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetScreenHeight();
    //TODO

    // Custom frame control functions
    /// Swap back buffer with front buffer (screen drawing)
    [CLink, CallingConvention(.Cdecl)] public static extern void SwapScreenBuffer();
    /// Register all input events
    [CLink, CallingConvention(.Cdecl)] public static extern void PollInputEvents();
    /// Wait for some time (halt program execution)
    [CLink, CallingConvention(.Cdecl)] public static extern void WaitTime(double seconds);

    // Cursor-related functions
    // TODO
    /// Check if cursor is not visible
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsCursorHidden();
    /// Enables cursor (unlock cursor)
    [CLink, CallingConvention(.Cdecl)] public static extern void EnableCursor();
    /// Disables cursor (lock cursor)
    [CLink, CallingConvention(.Cdecl)] public static extern void DisableCursor();
    // TODO

    // Drawing-related functions
    /// Set background color (framebuffer clear color)
    [CLink, CallingConvention(.Cdecl)] public static extern void ClearBackground(Color color);
    /// Setup canvas (framebuffer) to start drawing
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginDrawing();
    /// End canvas drawing and swap buffers (double buffering)
    [CLink, CallingConvention(.Cdecl)] public static extern void EndDrawing();
    /// Begin 2D mode with custom camera (2D)
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginMode2D(Camera2D camera);
    /// Ends 2D mode with custom camera
    [CLink, CallingConvention(.Cdecl)] public static extern void EndMode2D();
    /// Begin 3D mode with custom camera (3D)
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginMode3D(Camera3D camera);
    /// Ends 3D mode and returns to default 2D orthographic mode
    [CLink, CallingConvention(.Cdecl)] public static extern void EndMode3D();
    /// Begin drawing to render texture
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginTextureMode(RenderTexture2D target);
    /// Ends drawing to render texture
    [CLink, CallingConvention(.Cdecl)] public static extern void EndTextureMode();
    /// Begin custom shader drawing
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginShaderMode(Shader shader);
    /// End custom shader drawing (use default shader)
    [CLink, CallingConvention(.Cdecl)] public static extern void EndShaderMode();
    // TODO
    /// Begin scissor mode (define screen area for following drawing)
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginScissorMode(int32 x, int32 y, int32 width, int32 height);
    /// End scissor mode
    [CLink, CallingConvention(.Cdecl)] public static extern void EndScissorMode();
    /// Begin stereo rendering (requires VR simulator)
    [CLink, CallingConvention(.Cdecl)] public static extern void BeginVrStereoMode(VrStereoConfig config);
    /// End stereo rendering (requires VR simulator)
    [CLink, CallingConvention(.Cdecl)] public static extern void EndVrStereoMode();

    // VR stereo config functions for VR simulator
    /// Load VR stereo config for VR simulator device parameters
    [CLink, CallingConvention(.Cdecl)] public static extern VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
    /// Unload VR stereo config
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadVrStereoConfig(VrStereoConfig config);

    // VR stereo config functions for VR simulator
    // TODO

    // Shader management functions
    /// Load shader from files and bind default locations
    [CLink, CallingConvention(.Cdecl)] public static extern Shader LoadShader(char8* vsFileName, char8* fsFileName);
    // TODO
    /// Get shader uniform location
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetShaderLocation(Shader shader, char8* uniformName);
    // TODO
    /// Set shader uniform value
    [CLink, CallingConvention(.Cdecl)] public static extern void SetShaderValue(Shader shader, int32 locIndex, void* value, ShaderUniformDataType uniformType);
    // TODO
    /// Unload shader from GPU memory (VRAM)
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadShader(Shader shader);

    // Screen-space-related functions
    /// Get a ray trace from mouse position
    [CLink, CallingConvention(.Cdecl)] public static extern Ray GetMouseRay(Vector2 mousePosition, Camera camera);
    // TODO
    /// Get the screen space position for a 3d world space position
    [CLink, CallingConvention(.Cdecl)] public static extern Vector2 GetWorldToScreen(Vector3 position, Camera camera);
    // TODO

    // Timing-related functions
    /// Set target FPS (maximum)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetTargetFPS(int32 fps);
    // TODO
    /// Get time in seconds for last frame drawn (delta time)
    [CLink, CallingConvention(.Cdecl)] public static extern float GetFrameTime();
    /// Get elapsed time in seconds since InitWindow()
    [CLink, CallingConvention(.Cdecl)] public static extern double GetTime();

    // Misc. functions
    /// Get a random value between min and max (both included)
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetRandomValue(int32 min, int32 max);
    // TODO
    /// Setup init configuration flags (view FLAGS)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetConfigFlags(ConfigFlags flags);

    /// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
    [CLink, CallingConvention(.Cdecl)] public static extern void TraceLog(TraceLogLevel logLevel, char8* text, ...);
    // TODO
    /// Internal memory allocator
    [CLink, CallingConvention(.Cdecl)] public static extern void* MemAlloc(uint32 size);
    // TODO

    // Set custom callbacks
    /// Set custom trace log
    [CLink, CallingConvention(.Cdecl)] public static extern void SetTraceLogCallback(TraceLogCallback callback);
    // TODO

    // Files management functions
    /// Load file data as byte array (read)
    [CLink, CallingConvention(.Cdecl)] public static extern uint8* LoadFileData(char8* fileName, ref uint32 bytesRead);
    /// Unload file data allocated by LoadFileData()
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadFileData(uint8* data);
    /// Save data to file from byte array (write), returns true on success
    [CLink, CallingConvention(.Cdecl)] public static extern bool SaveFileData(char8* fileName, void* data, uint32 bytesToWrite);
    // TODO
    /// Check file extension (including point: .png, .wav)
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsFileExtension(char8* fileName, char8* ext);
    // TODO
    [CLink, CallingConvention(.Cdecl)] public static extern char8* GetFileName(char8* filePath);
    // TODO
    /// Check if a file has been dropped into window
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsFileDropped();
    /// Load dropped filepaths
    [CLink, CallingConvention(.Cdecl)] public static extern FilePathList LoadDroppedFiles();
    /// Unload dropped filepaths
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadDroppedFiles(FilePathList files);
    // TODO

    // Compression/Encoding functionality
    // TODO

    // Input-related functions: keyboard
    /// Check if a key has been pressed once
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsKeyPressed(KeyboardKey key);
    /// Check if a key is being pressed
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsKeyDown(KeyboardKey key);
    // TODO
    [CLink, CallingConvention(.Cdecl)] public static extern void SetExitKey(KeyboardKey key);
    // TODO

    // Input-related functions: gamepads
    /// Check if a gamepad is available
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGamepadAvailable(int32 gamepad);
    /// Get gamepad internal name id
    [CLink, CallingConvention(.Cdecl)] public static extern char8* GetGamepadName(int32 gamepad);
    /// Check if a gamepad button has been pressed once
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGamepadButtonPressed(int32 gamepad, GamepadButton button);
    /// Check if a gamepad button is being pressed
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGamepadButtonDown(int32 gamepad, GamepadButton button);
    /// Check if a gamepad button has been released once
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGamepadButtonReleased(int32 gamepad, GamepadButton button);
    /// Check if a gamepad button is NOT being pressed
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGamepadButtonUp(int32 gamepad, GamepadButton button);
    /// Get the last gamepad button pressed
    [CLink, CallingConvention(.Cdecl)] public static extern GamepadButton GetGamepadButtonPressed();
    /// Get gamepad axis count for a gamepad
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetGamepadAxisCount(int32 gamepad);
    /// Get axis movement value for a gamepad axis
    [CLink, CallingConvention(.Cdecl)] public static extern float GetGamepadAxisMovement(int32 gamepad, GamepadAxis axis);
    /// Set internal gamepad mappings (SDL_GameControllerDB)
    [CLink, CallingConvention(.Cdecl)] public static extern int32 SetGamepadMappings(char8* mappings);

    // Input-related functions: mouse
    /// Check if a mouse button has been pressed once
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsMouseButtonPressed(MouseButton button);
    /// Check if a mouse button is being pressed
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsMouseButtonDown(MouseButton button);
    /// Check if a mouse button has been released once
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsMouseButtonReleased(MouseButton button);
    // TODO
    /// Get mouse position X
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetMouseX();
    /// Get mouse position Y
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetMouseY();
    /// Get mouse position XY
    [CLink, CallingConvention(.Cdecl)] public static extern Vector2 GetMousePosition();
    // TODO
    /// Get mouse wheel movement for X or Y, whichever is larger
    [CLink, CallingConvention(.Cdecl)] public static extern float GetMouseWheelMove();
    // TODO

    // Input-related functions: touch
    // TODO
    /// Get touch position XY for a touch point index (relative to screen size)
    [CLink, CallingConvention(.Cdecl)] public static extern Vector2 GetTouchPosition(int32 index);
    // TODO
    /// Get number of touch points
    [CLink, CallingConvention(.Cdecl)] public static extern int32 GetTouchPointCount();

    // TODO
    /// Check if a gesture have been detected
    [CLink, CallingConvention(.Cdecl)] public static extern bool IsGestureDetected(Gesture gesture);
    /// Get latest detected gesture
    [CLink, CallingConvention(.Cdecl)] public static extern Gesture GetGestureDetected();
    // TODO

    /// Update camera position for selected mode
    [CLink, CallingConvention(.Cdecl)] public static extern void UpdateCamera(Camera* camera, CameraMode mode);
    // TODO

    // Set texture and rectangle to be used on shapes drawing
    // TODO

    // Basic shapes drawing functions
    // TODO
    /// Draw a pixel (Vector version)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawPixelV(Vector2 position, Color color);
    // TODO
    /// Draw a line
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawLine(int32 startPosX, int32 startPosY, int32 endPosX, int32 endPosY, Color color);
    // TODO
    /// Draw a color-filled circle
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCircle(int32 centerX, int32 centerY, float radius, Color color);
    // TODO
    /// Draw a color-filled circle (Vector version)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCircleV(Vector2 center, float radius, Color color);
    /// Draw circle outline
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCircleLines(int32 centerX, int32 centerY, float radius, Color color);
    // TODO
    /// Draw a color-filled rectangle
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRectangle(int32 posX, int32 posY, int32 width, int32 height, Color color);
    // TODO
    /// Draw a color-filled rectangle
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRectangleRec(Rectangle rec, Color color);
    /// Draw a color-filled rectangle with pro parameters
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);
    // TODO
    /// Draw rectangle outline
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRectangleLines(int32 posX, int32 posY, int32 width, int32 height, Color color);
    /// Draw rectangle outline with extended parameters
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);
    // TODO
    /// Draw a color-filled triangle (vertex in counter-clockwise order!)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
    // TODO

    // Basic shapes collision detection functions
    // TODO
    /// Check collision between circle and rectangle
    [CLink, CallingConvention(.Cdecl)] public static extern bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);
    /// Check if point is inside rectangle
    [CLink, CallingConvention(.Cdecl)] public static extern bool CheckCollisionPointRec(Vector2 point, Rectangle rec);
    // TODO

    // Image loading functions
    /// Load image from file into CPU memory (RAM)
    [CLink, CallingConvention(.Cdecl)] public static extern Image LoadImage(char8* fileName);
    // TODO
    /// Load image from GPU texture data
    [CLink, CallingConvention(.Cdecl)] public static extern Image LoadImageFromTexture(Texture2D texture);
    // TODO
    /// Unload image from CPU memory (RAM)
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadImage(Image image);
    /// Export image data to file, returns true on success
    [CLink, CallingConvention(.Cdecl)] public static extern bool ExportImage(Image image, char8* fileName);
    // TODO

    // Image generation functions
    // TODO
    /// Generate image: checked
    [CLink, CallingConvention(.Cdecl)] public static extern Image GenImageChecked(int32 width, int32 height, int32 checksX, int32 checksY, Color col1, Color col2);
    // TODO

    // Image manipulation functions
    // TODO
    /// Flip image vertically
    [CLink, CallingConvention(.Cdecl)] public static extern void ImageFlipVertical(Image* image);
    // TODO
    /// Load color data from image as a Color array (RGBA - 32bit)
    [CLink, CallingConvention(.Cdecl)] public static extern Color* LoadImageColors(Image image);
    /// Unload color data loaded with LoadImageColors()
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadImageColors(Color* colors);
    // TODO

    // Image drawing functions
    // TODO

    // Texture loading functions
    /// Load texture from file into GPU memory (VRAM)
    [CLink, CallingConvention(.Cdecl)] public static extern Texture2D LoadTexture(char8* fileName);
    /// Load texture from image data
    [CLink, CallingConvention(.Cdecl)] public static extern Texture2D LoadTextureFromImage(Image image);
    /// Load cubemap from image, multiple image cubemap layouts supported
    [CLink, CallingConvention(.Cdecl)] public static extern TextureCubemap LoadTextureCubemap(Image image, CubemapLayout layout);
    /// Load texture for rendering (framebuffer)
    [CLink, CallingConvention(.Cdecl)] public static extern RenderTexture2D LoadRenderTexture(int32 width, int32 height);
    // TODO
    //// Unload texture from GPU memory (VRAM)
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadTexture(Texture2D texture);
    // TODO
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadRenderTexture(RenderTexture2D target);
    // TODO

    // Texture configuration functions
    // TODO
    /// Set texture scaling filter mode
    [CLink, CallingConvention(.Cdecl)] public static extern void SetTextureFilter(Texture2D texture, TextureFilter filter);
    // TODO

    // Texture drawing functions
    /// Draw a Texture2D
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawTexture(Texture2D texture, int32 posX, int32 posY, Color tint);
    // TODO
    /// Draw a Texture2D with extended parameters
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
    /// Draw a part of a texture defined by a rectangle
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
    /// Draw a part of a texture defined by a rectangle with 'pro' parameters
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
    // TODO

    // Color/pixel related functions
    /// Get color with alpha applied, alpha goes from 0.0f to 1.0f
    [CLink, CallingConvention(.Cdecl)] public static extern Color Fade(Color color, float alpha);
    // TODO
    /// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
    [CLink, CallingConvention(.Cdecl)] public static extern Color ColorFromHSV(float hue, float saturation, float value);
    // TODO

    // Font loading/unloading functions
    // TODO

    // Text drawing functions
    /// Draw current FPS
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawFPS(int32 posX, int32 posY);
    /// Draw text (using default font)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawText(char8* text, int32 posX, int32 posY, int32 fontSize, Color color);
    // TODO

    // Text font info functions
    /// Measure string width for default font
    [CLink, CallingConvention(.Cdecl)] public static extern int32 MeasureText(char8* text, int32 fontSize);
    // TODO

    // Text codepoints management functions (unicode characters)
    // TODO

    // Text strings management functions (no UTF-8 strings, only byte chars)
    /// Copy one string to another, returns bytes copied
    [CLink, CallingConvention(.Cdecl)] public static extern int32 TextCopy(char8* dst, char8* src);
    /// Check if two text string are equal
    [CLink, CallingConvention(.Cdecl)] public static extern bool TextIsEqual(char8* text1, char8* text2); // Check if two text string are equal
    // TODO
    /// Text formatting with variables (sprintf() style)
    [CLink, CallingConvention(.Cdecl)] public static extern char8* TextFormat(char8* text, ...);

    // Basic geometric 3D shapes drawing functions
    /// Draw a line in 3D world space
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);
    // TODO
    /// Draw a circle in 3D world space
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
    // TODO
    /// Draw cube
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCube(Vector3 position, float width, float height, float length, Color color);
    /// Draw cube (Vector version)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCubeV(Vector3 position, Vector3 size, Color color);
    // TODO
    /// Draw cube wires
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);
    // TODO
    /// Draw sphere
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawSphere(Vector3 centerPos, float radius, Color color);
    // TODO
    /// Draw sphere wires
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawSphereWires(Vector3 centerPos, float radius, int32 rings, int32 slices, Color color);
    // TODO
    /// Draw a cylinder/cone
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
    // TODO
    /// Draw a cylinder/cone wires
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
    // TODO
    /// Draw a capsule with the center of its sphere caps at startPos and endPos
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
    /// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
    /// Draw a plane XZ
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawPlane(Vector3 centerPos, Vector2 size, Color color);
    /// Draw a ray line
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawRay(Ray ray, Color color);
    /// Draw a grid (centered at (0, 0, 0))
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawGrid(int32 slices, float spacing);

    // Model management functions
    /// Load model from files (meshes and materials)
    [CLink, CallingConvention(.Cdecl)] public static extern Model LoadModel(char8* fileName);
    /// Load model from generated mesh (default material)
    [CLink, CallingConvention(.Cdecl)] public static extern Model LoadModelFromMesh(Mesh mesh);
    // TODO
    /// Unload model (including meshes) from memory (RAM and/or VRAM)
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadModel(Model model);
    /// Compute model bounding box limits (considers all meshes)
    [CLink, CallingConvention(.Cdecl)] public static extern BoundingBox GetModelBoundingBox(Model model);

    // Model drawing functions
    /// Draw a model (with texture if set)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawModel(Model model, Vector3 position, float scale, Color tint);
    /// Draw a model with extended parameters
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
    // TODO
    /// Draw bounding box (wires)
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawBoundingBox(BoundingBox @box, Color color);
    /// Draw a billboard texture
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint);
    // TODO
    /// Draw a billboard texture defined by source and rotation
    [CLink, CallingConvention(.Cdecl)] public static extern void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint);

    // Mesh management functions
    /// Upload mesh vertex data in GPU and provide VAO/VBO ids
    [CLink, CallingConvention(.Cdecl)] public static extern void UploadMesh(Mesh* mesh, bool dynamic);
    // TODO
    /// Compute mesh bounding box limits
    [CLink, CallingConvention(.Cdecl)] public static extern BoundingBox GetMeshBoundingBox(Mesh mesh);
    // TODO

    // Mesh generation functions
    /// Generate polygonal mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshPoly(int32 sides, float radius);
    /// Generate plane mesh (with subdivisions)
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshPlane(float width, float length, int32 resX, int32 resZ);
    /// Generate cuboid mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshCube(float width, float height, float length);
    /// Generate sphere mesh (standard sphere)
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshSphere(float radius, int32 rings, int32 slices);
    /// Generate half-sphere mesh (no bottom cap)
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshHemiSphere(float radius, int32 rings, int32 slices);
    /// Generate cylinder mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshCylinder(float radius, float height, int32 slices);
    /// Generate cone/pyramid mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshCone(float radius, float height, int32 slices);
    /// Generate torus mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshTorus(float radius, float size, int32 radSeg, int32 sides);
    /// Generate trefoil knot mesh
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshKnot(float radius, float size, int32 radSeg, int32 sides);
    /// Generate heightmap mesh from image data
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshHeightmap(Image heightmap, Vector3 size);
    /// Generate cubes-based map mesh from image data
    [CLink, CallingConvention(.Cdecl)] public static extern Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);

    // Material loading/unloading functions
    // TODO
    [CLink, CallingConvention(.Cdecl)] public static extern void SetMaterialTexture(Material* material, MaterialMapIndex mapType, Texture2D texture);
    // TODO

    // Model animations loading/unloading functions
    /// Load model animations from file
    [CLink, CallingConvention(.Cdecl)] public static extern ModelAnimation* LoadModelAnimations(char8* fileName, uint32* animCount);
    /// Update model animation pose
    [CLink, CallingConvention(.Cdecl)] public static extern void UpdateModelAnimation(Model model, ModelAnimation anim, int32 frame);
    /// Unload animation data
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadModelAnimation(ModelAnimation anim);
    /// Unload animation array data
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadModelAnimations(ModelAnimation* animations, uint32 count);
    // TODO

    // Collision detection functions
    // TODO
    // Check collision between two bounding boxes
    [CLink, CallingConvention(.Cdecl)] public static extern bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);
    /// Check collision between box and sphere
    [CLink, CallingConvention(.Cdecl)] public static extern bool CheckCollisionBoxSphere(BoundingBox @box, Vector3 center, float radius);
    /// Get collision info between ray and sphere
    [CLink, CallingConvention(.Cdecl)] public static extern RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);
    /// Get collision info between ray and box
    [CLink, CallingConvention(.Cdecl)] public static extern RayCollision GetRayCollisionBox(Ray ray, BoundingBox @box);
    // Get collision info between ray and mesh
    [CLink, CallingConvention(.Cdecl)] public static extern RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);
    /// Get collision info between ray and triangle
    [CLink, CallingConvention(.Cdecl)] public static extern RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
    /// Get collision info between ray and quad
    [CLink, CallingConvention(.Cdecl)] public static extern RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);

    // Audio device management functions
    /// Initialize audio device and context
    [CLink, CallingConvention(.Cdecl)] public static extern void InitAudioDevice();
    /// Close the audio device and context
    [CLink, CallingConvention(.Cdecl)] public static extern void CloseAudioDevice();
    /// Check if audio device has been initialized successfully
    //[CLink, CallingConvention(.Cdecl)] public static extern bool IsAudioDeviceReady();
    /// Set master volume (listener)
    //[CLink, CallingConvention(.Cdecl)] public static extern void SetMasterVolume(float volume);

    // Wave/Sound loading/unloading functions
    // TODO
    /// Load sound from file
    [CLink, CallingConvention(.Cdecl)] public static extern Sound LoadSound(char8* fileName);
    /// Load sound from wave data
    [CLink, CallingConvention(.Cdecl)] public static extern Sound LoadSoundFromWave(Wave wave);
    // TODO
    /// Unload sound
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadSound(Sound sound);
    // TODO

    // Wave/Sound management functions
    /// Play a sound
    [CLink, CallingConvention(.Cdecl)] public static extern void PlaySound(Sound sound);
    // TODO

    // Music management functions
    /// Load music stream from file
    [CLink, CallingConvention(.Cdecl)] public static extern Music LoadMusicStream(char8* fileName);
    // TODO
    /// Unload music stream
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadMusicStream(Music music);
    /// Start music playing
    [CLink, CallingConvention(.Cdecl)] public static extern void PlayMusicStream(Music music);
    // TODO
    /// Updates buffers for music streaming
    [CLink, CallingConvention(.Cdecl)] public static extern void UpdateMusicStream(Music music);
    /// Stop music playing
    [CLink, CallingConvention(.Cdecl)] public static extern void StopMusicStream(Music music);
    /// Pause music playing
    [CLink, CallingConvention(.Cdecl)] public static extern void PauseMusicStream(Music music);
    /// Resume playing paused music
    [CLink, CallingConvention(.Cdecl)] public static extern void ResumeMusicStream(Music music);
    // TODO
    /// Set pitch for a music (1.0 is base level)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetMusicPitch(Music music, float pitch);
    /// Get music time length (in seconds)
    [CLink, CallingConvention(.Cdecl)] public static extern float GetMusicTimeLength(Music music);
    /// Get current music time played (in seconds)
    [CLink, CallingConvention(.Cdecl)] public static extern float GetMusicTimePlayed(Music music);

    // AudioStream management functions
    [CLink, CallingConvention(.Cdecl)] public static extern AudioStream LoadAudioStream(uint32 sampleRate, uint32 sampleSize, uint32 channels);
    // TODO
    [CLink, CallingConvention(.Cdecl)] public static extern void UnloadAudioStream(AudioStream stream);
    // TODO
    /// Play audio stream
    [CLink, CallingConvention(.Cdecl)] public static extern void PlayAudioStream(AudioStream stream);
    // TODO
    /// Set pan for audio stream (0.5 is centered)
    [CLink, CallingConvention(.Cdecl)] public static extern void SetAudioStreamPan(AudioStream stream, float pan);
    /// Default size for new audio streams
    [CLink, CallingConvention(.Cdecl)] public static extern void SetAudioStreamBufferSizeDefault(int32 size);
    /// Audio thread callback to request new data
    [CLink, CallingConvention(.Cdecl)] public static extern void SetAudioStreamCallback(AudioStream stream, AudioCallback callback);

    /// Attach audio stream processor to stream
    [CLink, CallingConvention(.Cdecl)] public static extern void AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor);
    /// Detach audio stream processor from stream
    [CLink, CallingConvention(.Cdecl)] public static extern void DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor);

    /// Attach audio stream processor to the entire audio pipeline
    [CLink, CallingConvention(.Cdecl)] public static extern void AttachAudioMixedProcessor(AudioCallback processor);
    /// Detach audio stream processor from the entire audio pipeline
    [CLink, CallingConvention(.Cdecl)] public static extern void DetachAudioMixedProcessor(AudioCallback processor);
}


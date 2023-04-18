/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_custom_logging.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Pablo Marcos Oltra (@pamarcos) and Ramon Santamaria (@raysan5) for providing original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_custom_logging;

class Program
{

#if BF_PLATFORM_WINDOWS
    [CLink, Import("msvcrt.dll")]
#else
    [CLink]
#endif
    public static extern int32 vprintf(char8* format, void* args);

    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        SetTraceLogCallback( => CustomLog);

        InitWindow(screenWidth, screenHeight, "raylib [core] example - custom logging");
        defer CloseWindow();

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);
            DrawText("Check out the console output to see the custom logger in action!", 60, 200, 20, .LightGray);
        }

        return 0;
    }

    public static void CustomLog(TraceLogLevel logLevel, char8* text, void* args)
    {
        String timeStr = scope String();
        DateTime.Now.ToString(timeStr, "yyyy/MM/dd HH:mm:ss");
        Console.Write($"[{timeStr}] ");

        switch (logLevel)
        {
        case .Info:
            Console.Write("[INFO]: ");
        case .Error:
            Console.Write("[ERROR]: ");
        case .Warning:
            Console.Write("[WARN]: ");
        case .Debug:
            Console.Write("[DEBUG]: ");
        default: break;
        }

        vprintf(text, args);
        Console.WriteLine();
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/others/easings_testbed.c
*
*    Changes:
*        - ported
*        - removed comments
*
*    Credits:
*        Juan Miguel López (@flashback-fx ) and Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using System.Collections;
using Raylib;
using Raylib.Reasings;

namespace easings_testbed;

public static
{
    public const int32 FONT_SIZE = 20;
    public const float D_STEP = 20f;
    public const float D_STEP_FINE = 2f;
    public const float D_MIN = 1f;
    public const float D_MAX = 10000f;

    public static Dictionary<EasingType, Easing> Easings = new .()
        {
            (.LinearNone,   .() { name = "EaseLinearNone",   func = => EaseLinearNone   }),
            (.LinearIn,     .() { name = "EaseLinearIn",     func = => EaseLinearIn     }),
            (.LinearOut,    .() { name = "EaseLinearOut",    func = => EaseLinearOut    }),
            (.LinearInOut,  .() { name = "EaseLinearInOut",  func = => EaseLinearInOut  }),
            (.SineIn,       .() { name = "EaseSineIn",       func = => EaseSineIn       }),
            (.SineOut,      .() { name = "EaseSineOut",      func = => EaseSineOut      }),
            (.SineInOut,    .() { name = "EaseSineInOut",    func = => EaseSineInOut    }),
            (.CircIn,       .() { name = "EaseCircIn",       func = => EaseCircIn       }),
            (.CircOut,      .() { name = "EaseCircOut",      func = => EaseCircOut      }),
            (.CircInOut,    .() { name = "EaseCircInOut",    func = => EaseCircInOut    }),
            (.CubicIn,      .() { name = "EaseCubicIn",      func = => EaseCubicIn      }),
            (.CubicOut,     .() { name = "EaseCubicOut",     func = => EaseCubicOut     }),
            (.CubicInOut,   .() { name = "EaseCubicInOut",   func = => EaseCubicInOut   }),
            (.QuadIn,       .() { name = "EaseQuadIn",       func = => EaseQuadIn       }),
            (.QuadOut,      .() { name = "EaseQuadOut",      func = => EaseQuadOut      }),
            (.QuadInOut,    .() { name = "EaseQuadInOut",    func = => EaseQuadInOut    }),
            (.ExpoIn,       .() { name = "EaseExpoIn",       func = => EaseExpoIn       }),
            (.ExpoOut,      .() { name = "EaseExpoOut",      func = => EaseExpoOut      }),
            (.ExpoInOut,    .() { name = "EaseExpoInOut",    func = => EaseExpoInOut    }),
            (.BackIn,       .() { name = "EaseBackIn",       func = => EaseBackIn       }),
            (.BackOut,      .() { name = "EaseBackOut",      func = => EaseBackOut      }),
            (.BackInOut,    .() { name = "EaseBackInOut",    func = => EaseBackInOut    }),
            (.BounceOut,    .() { name = "EaseBounceOut",    func = => EaseBounceOut    }),
            (.BounceIn,     .() { name = "EaseBounceIn",     func = => EaseBounceIn     }),
            (.BounceInOut,  .() { name = "EaseBounceInOut",  func = => EaseBounceInOut  }),
            (.ElasticIn,    .() { name = "EaseElasticIn",    func = => EaseElasticIn    }),
            (.ElasticOut,   .() { name = "EaseElasticOut",   func = => EaseElasticOut   }),
            (.ElasticInOut, .() { name = "EaseElasticInOut", func = => EaseElasticInOut }),
            (.None,         .() { name = "None",             func = => NoEase           })
        } ~ delete _;

    static float NoEase(float t, float b, float c, float d)
    {
        return b;
    }
}

/// Easing types
[AllowDuplicates]
enum EasingType : int32
{
    LinearNone = 0,
    LinearIn,
    LinearOut,
    LinearInOut,
    SineIn,
    SineOut,
    SineInOut,
    CircIn,
    CircOut,
    CircInOut,
    CubicIn,
    CubicOut,
    CubicInOut,
    QuadIn,
    QuadOut,
    QuadInOut,
    ExpoIn,
    ExpoOut,
    ExpoInOut,
    BackIn,
    BackOut,
    BackInOut,
    BounceOut,
    BounceIn,
    BounceInOut,
    ElasticIn,
    ElasticOut,
    ElasticInOut,
    Count,
    None = Count
}

public struct Easing
{
    public char8* name;
    public function float(float, float, float, float) func;
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [easings] example - easings testbed");

        Vector2 ballPosition = .(100f, 200f);
        float t = 0f;
        float d = 300f;
        bool paused = true;
        bool boundedT = true;

        EasingType easingX = .None;
        EasingType easingY = .None;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            if (IsKeyPressed(.T))
                boundedT = !boundedT;

            if (IsKeyPressed(.Right))
            {
                easingX++;

                if (easingX > .None)
                    easingX = 0;
            }
            else if (IsKeyPressed(.Left))
            {
                if (easingX == 0)
                    easingX = .None;
                else
                    easingX--;
            }

            if (IsKeyPressed(.Down))
            {
                easingY++;

                if (easingY > .None)
                    easingY = 0;
            }
            else if (IsKeyPressed(.Up))
            {
                if (easingY == 0)
                    easingY = .None;
                else
                    easingY--;
            }

            if (IsKeyPressed(.W) && d < D_MAX - D_STEP)
                d += D_STEP;
            else if (IsKeyPressed(.Q) && d > D_MIN + D_STEP)
                d -= D_STEP;

            if (IsKeyDown(.S) && d < D_MAX - D_STEP_FINE)
                d += D_STEP_FINE;
            else if (IsKeyDown(.A) && d > D_MIN + D_STEP_FINE)
                d -= D_STEP_FINE;

            if (IsKeyPressed(.Space) || IsKeyPressed(.T) ||
                IsKeyPressed(.Right) || IsKeyPressed(.Left) ||
                IsKeyPressed(.Down) || IsKeyPressed(.Up) ||
                IsKeyPressed(.W) || IsKeyPressed(.Q) ||
                IsKeyDown(.S)  || IsKeyDown(.A) ||
                (IsKeyPressed(.End) && (boundedT == true) && (t >= d)))
            {
                t = 0f;
                ballPosition.x = 100f;
                ballPosition.y = 100f;
                paused = true;
            }

            if (IsKeyPressed(.Enter))
                paused = !paused;

            if (!paused && ((boundedT && t < d) || !boundedT))
            {
                ballPosition.x = Easings[easingX].func(t, 100f, 700f - 100f, d);
                ballPosition.y = Easings[easingY].func(t, 100f, 400f - 100f, d);
                t += 1f;
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawText(TextFormat("Easing x: %s", Easings[easingX].name), 0, FONT_SIZE * 2, FONT_SIZE, .LightGray);
            DrawText(TextFormat("Easing y: %s", Easings[easingY].name), 0, FONT_SIZE * 3, FONT_SIZE, .LightGray);
            DrawText(TextFormat("t (%c) = %.2f d = %.2f", (boundedT == true) ? 'b' : 'u', t, d), 0, FONT_SIZE * 4, FONT_SIZE, .LightGray);

            DrawText("Use ENTER to play or pause movement, use SPACE to restart", 0, GetScreenHeight() - FONT_SIZE * 2, FONT_SIZE, .LightGray);
            DrawText("Use D and W or A and S keys to change duration", 0, GetScreenHeight() - FONT_SIZE * 3, FONT_SIZE, .LightGray);
            DrawText("Use LEFT or RIGHT keys to choose easing for the x axis", 0, GetScreenHeight() - FONT_SIZE * 4, FONT_SIZE, .LightGray);
            DrawText("Use UP or DOWN keys to choose easing for the y axis", 0, GetScreenHeight() - FONT_SIZE * 5, FONT_SIZE, .LightGray);

            DrawCircleV(ballPosition, 16f, .Maroon);
        }

        return 0;
    }
}
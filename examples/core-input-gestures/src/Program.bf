/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_gestures.c
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

namespace core_input_gestures;

public static
{
    public const int MAX_GESTURE_STRINGS = 20;
}

class Program
{
    public static int Main(String[] args)
    {
        const int screenWidth = 800;
        const int screenHeight = 450;

        InitWindow(screenWidth, screenHeight, "raylib [core] example - input gestures");
        defer CloseWindow();

        Vector2 touchPosition = Vector2.Zero;
        Rectangle touchArea = Rectangle(220, 10, screenWidth - 230.0f, screenHeight - 20.0f);

        int gesturesCount = 0;
        char8[MAX_GESTURE_STRINGS][32] gestureStrings;

        Gesture currentGesture = .None;
        Gesture lastGesture = .None;

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            lastGesture = currentGesture;
            currentGesture = GetGestureDetected();
            touchPosition = GetTouchPosition(0);

            if (CheckCollisionPointRec(touchPosition, touchArea) && (currentGesture != .None))
            {
                if (currentGesture != lastGesture)
                {
                    switch (currentGesture)
                    {
                    case .Tap:        TextCopy(&gestureStrings[gesturesCount], "GESTURE TAP");
                    case .Doubletap:  TextCopy(&gestureStrings[gesturesCount], "GESTURE DOUBLETAP");
                    case .Hold:       TextCopy(&gestureStrings[gesturesCount], "GESTURE HOLD");
                    case .Drag:       TextCopy(&gestureStrings[gesturesCount], "GESTURE DRAG");
                    case .SwipeRight: TextCopy(&gestureStrings[gesturesCount], "GESTURE SWIPE RIGHT");
                    case .SwipeLeft:  TextCopy(&gestureStrings[gesturesCount], "GESTURE SWIPE LEFT");
                    case .SwipeUp:    TextCopy(&gestureStrings[gesturesCount], "GESTURE SWIPE UP");
                    case .SwipeDown:  TextCopy(&gestureStrings[gesturesCount], "GESTURE SWIPE DOWN");
                    case .PinchIn:    TextCopy(&gestureStrings[gesturesCount], "GESTURE PINCH IN");
                    case .PinchOut:   TextCopy(&gestureStrings[gesturesCount], "GESTURE PINCH OUT");
                    default:
                    }

                    gesturesCount++;

                    if (gesturesCount >= MAX_GESTURE_STRINGS)
                    {
                        for (int i < MAX_GESTURE_STRINGS)
                            TextCopy(&gestureStrings[i], "\0");

                        gesturesCount = 0;
                    }
                }
            }

            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            DrawRectangleRec(touchArea, .Gray);
            DrawRectangle(225, 15, screenWidth - 240, screenHeight - 30, .RayWhite);

            DrawText("GESTURES TEST AREA", screenWidth - 270, screenHeight - 40, 20, Fade(.Gray, 0.5f));

            for (int i < gesturesCount)
            {
                DrawRectangle(10, 30 + 20 * (int32)i, 200, 20, Fade(.LightGray, (i % 2 == 00) ? 0.5f : 0.3f));
                DrawText(&gestureStrings[i], 35, 36 + 20 * (int32)i, 10, (i < gesturesCount - 1) ? .DarkGray : .Maroon);
            }

            DrawRectangleLines(10, 29, 200, screenHeight - 50, .Gray);
            DrawText("DETECTED GESTURES", 50, 15, 10, .Gray);

            if (currentGesture != .None)
                DrawCircleV(touchPosition, 30, .Maroon);
        }

        return 0;
    }
}
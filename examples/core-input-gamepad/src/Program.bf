/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_input_gamepad.c
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

namespace core_input_gamepad;

public static
{
    public const String XBOX360LegacyNameId = "Xbox Controller";
    public const String XBOX360NameId = "Xbox 360 Controller";
    public const String PS3NameId = "PLAYSTATION(R)3 Controller";
}

class Program
{
    public static int Main(String[] args)
    {
        const int32 screenWidth = 800;
        const int32 screenHeight = 450;

        SetConfigFlags(.Msaa4xHint);

        InitWindow(screenWidth, screenHeight, "raylib [core] example - gamepad input");
        defer CloseWindow();

        Texture2D texPs3Pad = LoadTexture("../resources/ps3.png");
        defer UnloadTexture(texPs3Pad);

        Texture2D texXboxPad = LoadTexture("../resources/xbox.png");
        defer UnloadTexture(texXboxPad);

        SetTargetFPS(60);

        while (!WindowShouldClose())
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(.RayWhite);

            if (IsGamepadAvailable(0))
            {
                DrawText(TextFormat("GP1: %s", GetGamepadName(0)), 10, 10, 10, .Black);

                if (TextIsEqual(GetGamepadName(0), XBOX360NameId) || TextIsEqual(GetGamepadName(0), XBOX360LegacyNameId))
                {
                    DrawTexture(texXboxPad, 0, 0, .DarkGray);

                    if (IsGamepadButtonDown(0, .Middle))
                        DrawCircle(394, 89, 19, .Red);

                    if (IsGamepadButtonDown(0, .MiddleRight))
                        DrawCircle(436, 150, 9, .Red);
                    if (IsGamepadButtonDown(0, .MiddleLeft))
                        DrawCircle(352, 150, 9, .Red);
                    if (IsGamepadButtonDown(0, .RightFaceLeft))
                        DrawCircle(501, 151, 15, .Blue);
                    if (IsGamepadButtonDown(0, .RightFaceDown))
                        DrawCircle(536, 187, 15, .Lime);
                    if (IsGamepadButtonDown(0, .RightFaceRight))
                        DrawCircle(572, 151, 15, .Maroon);
                    if (IsGamepadButtonDown(0, .RightFaceUp))
                        DrawCircle(536, 115, 15, .Gold);

                    DrawRectangle(317, 202, 19, 71, .Black);
                    DrawRectangle(293, 228, 69, 19, .Black);
                    if (IsGamepadButtonDown(0, .LeftFaceUp))
                        DrawRectangle(317, 202, 19, 26, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceDown))
                        DrawRectangle(317, 202 + 45, 19, 26, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceLeft))
                        DrawRectangle(292, 228, 25, 19, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceRight))
                        DrawRectangle(292 + 44, 228, 26, 19, .Red);

                    if (IsGamepadButtonDown(0, .LeftTrigger1))
                        DrawCircle(259, 61, 20, .Red);
                    if (IsGamepadButtonDown(0, .RightTrigger1))
                        DrawCircle(536, 61, 20, .Red);

                    DrawCircle(259, 152, 39, .Black);
                    DrawCircle(259, 152, 34, .LightGray);
                    DrawCircle(259 + (int32)(GetGamepadAxisMovement(0, .LeftX) * 20), 152 + (int32)(GetGamepadAxisMovement(0, .LeftY) * 20), 25, .Black);

                    DrawCircle(461, 237, 38, .Black);
                    DrawCircle(461, 237, 33, .LightGray);
                    DrawCircle(461 + (int32)(GetGamepadAxisMovement(0, .RightX) * 20), 237 + (int32)(GetGamepadAxisMovement(0, .RightY) * 20), 25, .Black);

                    DrawRectangle(170, 30, 15, 70, .Gray);
                    DrawRectangle(604, 30, 15, 70, .Gray);
                    DrawRectangle(170, 30, 15, (int32)(((1 + GetGamepadAxisMovement(0, .LeftTrigger)) / 2) * 70), .Red);
                    DrawRectangle(604, 30, 15, (int32)(((1 + GetGamepadAxisMovement(0, .RightTrigger)) / 2) * 70), .Red);
                }
                else if (TextIsEqual(GetGamepadName(0), PS3NameId.CStr()))
                {
                    DrawTexture(texPs3Pad, 0, 0, .DarkGray);

                    if (IsGamepadButtonDown(0, .Middle))
                        DrawCircle(396, 222, 13, .Red);

                    if (IsGamepadButtonDown(0, .Middle))
                        DrawRectangle(328, 170, 32, 13, .Red);
                    if (IsGamepadButtonDown(0, .MiddleRight))
                        DrawTriangle(Vector2(436, 168), Vector2(436, 185), Vector2(464, 177), .Red);
                    if (IsGamepadButtonDown(0, .RightFaceUp))
                        DrawCircle(557, 144, 13, .Lime);
                    if (IsGamepadButtonDown(0, .RightFaceRight))
                        DrawCircle(586, 173, 13, .Red);
                    if (IsGamepadButtonDown(0, .RightFaceDown))
                        DrawCircle(557, 203, 13, .Violet);
                    if (IsGamepadButtonDown(0, .RightFaceLeft))
                        DrawCircle(527, 173, 13, .Pink);

                    DrawRectangle(225, 132, 24, 84, .Black);
                    DrawRectangle(195, 161, 84, 25, .Black);
                    if (IsGamepadButtonDown(0, .LeftFaceUp))
                        DrawRectangle(225, 132, 24, 29, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceDown))
                        DrawRectangle(225, 132 + 54, 24, 30, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceLeft))
                        DrawRectangle(195, 161, 30, 25, .Red);
                    if (IsGamepadButtonDown(0, .LeftFaceRight))
                        DrawRectangle(195 + 54, 161, 30, 25, .Red);

                    if (IsGamepadButtonDown(0, .LeftTrigger1))
                        DrawCircle(239, 82, 20, .Red);
                    if (IsGamepadButtonDown(0, .RightTrigger1))
                        DrawCircle(557, 82, 20, .Red);

                    DrawCircle(319, 255, 35, .Black);
                    DrawCircle(319, 255, 31, .LightGray);
                    DrawCircle(319 + (int32)(GetGamepadAxisMovement(0, .LeftX) * 20), 255 + (int32)(GetGamepadAxisMovement(0, .LeftY) * 20), 25, .Black);

                    DrawCircle(475, 255, 35, .Black);
                    DrawCircle(475, 255, 31, .LightGray);
                    DrawCircle(475 + (int32)(GetGamepadAxisMovement(0, .RightX) * 20), 255 + (int32)(GetGamepadAxisMovement(0, .RightY) * 20), 25, .Black);

                    DrawRectangle(169, 48, 15, 70, .Gray);
                    DrawRectangle(611, 48, 15, 70, .Gray);
                    DrawRectangle(169, 48, 15, (int32)(((1 - GetGamepadAxisMovement(0, .LeftTrigger)) / 2) * 70), .Red);
                    DrawRectangle(611, 48, 15, (int32)(((1 - GetGamepadAxisMovement(0, .RightTrigger)) / 2) * 70), .Red);
                }
                else
                {
                    DrawText("- GENERIC GAMEPAD -", 280, 180, 20, .Gray);
                }

                DrawText(TextFormat("DETECTED AXIS [%i]:", GetGamepadAxisCount(0)), 10, 50, 10, .Maroon);

                for (int i < GetGamepadAxisCount(0))
                {
                    DrawText(TextFormat("AXIS %i: %.02f", i, GetGamepadAxisMovement(0, (GamepadAxis)i)), 20, 70 + 20 * (int32)i, 10, .DarkGray);
                }

                if (GetGamepadButtonPressed() != .Unknown)
                    DrawText(TextFormat("DETECTED BUTTON: %i", GetGamepadButtonPressed()), 10, 430, 10, .Red);
                else
                    DrawText("DETECTED BUTTON: NONE", 10, 430, 10, .Gray);
            }
        }

        return 0;
    }
}
/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/core/core_basic_screen_manager.c
*
*    Changes:
*        - ported
*        - removed comments
*        - refactored
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing the original example
* 
********************************************************************************************/

using System;
using Raylib;

namespace core_basic_screen_manager;

class Program
{
	enum GameScreen
	{
		Logo = 0,
		Title,
		Gameplay,
		Ending
	};

	public static int Main(String[] args)
	{
		const int screenWidth = 800;
		const int screenHeight = 450;

		InitWindow(screenWidth, screenHeight, "raylib [core] example - basic screen manager");
        defer CloseWindow();

		SetTargetFPS(60);

        GameScreen currentScreen = .Logo;
        int framesCounter = 0;

		while (!WindowShouldClose())
		{
			switch(currentScreen)
			{
				case .Logo:
					framesCounter++;
					if (framesCounter > 120)
					    currentScreen = .Title;

				case .Title:
					if (IsKeyPressed(.Enter) || IsGestureDetected(.Tap))
					    currentScreen = .Gameplay;

				case .Gameplay:
					if (IsKeyPressed(.Enter) || IsGestureDetected(.Tap))
					    currentScreen = .Ending;

				case .Ending:
					if (IsKeyPressed(.Enter) || IsGestureDetected(.Tap))
					    currentScreen = .Title;
			}

		    BeginDrawing();
            defer EndDrawing();

			ClearBackground(.RayWhite);
			switch(currentScreen)
			{
			    case .Logo:
			        DrawText("LOGO SCREEN", 20, 20, 40, .LightGray);
			        DrawText("WAIT for 2 SECONDS...", 290, 220, 20, .Gray);

			    case .Title:
			        DrawRectangle(0, 0, screenWidth, screenHeight, .Green);
			        DrawText("TITLE SCREEN", 20, 20, 40, .DarkGreen);
			        DrawText("PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN", 120, 220, 20, .DarkGreen);

			    case .Gameplay:
			        DrawRectangle(0, 0, screenWidth, screenHeight, .Purple);
			        DrawText("GAMEPLAY SCREEN", 20, 20, 40, .Maroon);
			        DrawText("PRESS ENTER or TAP to JUMP to ENDING SCREEN", 130, 220, 20, .Maroon);

			    case .Ending:
			        DrawRectangle(0, 0, screenWidth, screenHeight, .Blue);
			        DrawText("ENDING SCREEN", 20, 20, 40, .DarkBlue);
			        DrawText("PRESS ENTER or TAP to RETURN to TITLE SCREEN", 120, 220, 20, .DarkBlue);
			}
		}

		return 0;
	}
}
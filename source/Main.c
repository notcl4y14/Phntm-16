#include <stdio.h>
#include <raylib.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include "Memory.h"
#include "Public.h"
#include "API.h"

int main ()
{
	printf("Hello World!\n");

	InitWindow(256 * P_WINDOW_SCALE, 256 * P_WINDOW_SCALE, "PHNTM-16");
	SetTargetFPS(P_WINDOW_FPS);

	RenderTexture2D canvas = LoadRenderTexture(256, 256);
	__P_API_CANVAS = &canvas;

	BeginTextureMode(canvas);
	ClearBackground(P_COLOR_DARKER_BLUE);
	EndTextureMode();

	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	lua_pushcfunction(L, &rect);
	lua_setglobal(L, "rect");
	luaL_dostring(L, "rect(0, 0, 20, 20)");

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(BLACK);
		DrawTexturePro
		(
			canvas.texture,
			(Rectangle) {0, 0, 256, -256},
			(Rectangle) {0, 0, 256 * P_WINDOW_SCALE, 256 * P_WINDOW_SCALE},
			(Vector2) {0, 0},
			0.0f,
			WHITE
		);
		EndDrawing();
	}

	CloseWindow();
	lua_close(L);
	return 0;
}
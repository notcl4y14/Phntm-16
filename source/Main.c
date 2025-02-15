#include <stdio.h>
#include <raylib.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include "Memory.h"
#include "Public.h"
#include "API.h"

void load_lua (lua_State* L)
{
	lua_pushcfunction(L, &pLua_rect);
	lua_setglobal(L, "rect");

	lua_pushcfunction(L, &pLua_color);
	lua_setglobal(L, "color");
	
	luaL_dostring(L, "function _init() end");
	luaL_dostring(L, "function _tick() end");
}

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

	load_lua(L);

	char* code =
	"w = 24\n"
	"h = 24\n"
	"c = 0\n"
	"function _tick()\n"
	"	color(c)\n"
	"	rect(c, 128 - h / 2, c + w, 128 + h / 2)\n"
	"	c = c + 1\n"
	"	if c > 256 - 24 then\n"
	"		c = 0\n"
	"	end\n"
	"end\n";

	luaL_dostring(L, code);

	luaL_dostring(L, "_init()");

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(BLACK);

		luaL_dostring(L, "_tick()");

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
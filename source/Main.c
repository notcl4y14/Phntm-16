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

	lua_pushcfunction(L, &pLua_peek);
	lua_setglobal(L, "peek");

	lua_pushcfunction(L, &pLua_poke);
	lua_setglobal(L, "poke");
	
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
	
	P_Memory memory = pCreateMemory(0xffffff, 2);
	P_Memory chunk_screenData = pMemoryGetChunk(&memory, 0, 256 * 256);

	__P_API_MEMORY = &memory;
	__P_API_CHUNK_SCREENDATA = &chunk_screenData;

	// printf("%d/%d, %d\n", chunk_screenData.size, memory.size, chunk_screenData.size < memory.size);

	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	load_lua(L);

	char* code =
	"w = 24\n"
	"h = 24\n"
	"c = 0\n"
	"function _tick()\n"
	"	poke(10, 12)\n"
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
		luaL_dostring(L, "_tick()");

		// Rendering screen data onto the Texture
		BeginTextureMode(canvas);

			for (int i = 0; i < 256 * 256; i++)
			{
				int rx = i % 256;
				int ry = i / 256;
				P_uchar color = *pMemoryGet(&chunk_screenData, i);
				DrawRectangle(rx, ry, 1, 1, pColorGet(color));
			}
		
		EndTextureMode();

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

	// printf("%d, %d, %d\n", pMemoryGet(&memory, 0), pMemoryGet(&chunk_screenData, 0), pMemoryGet(&memory, 0) == pMemoryGet(&chunk_screenData, 0));

	CloseWindow();
	lua_close(L);
	pFreeMemory(&memory);
	return 0;
}
#include "Public.h"
#include "API.h"

RenderTexture2D* __P_API_CANVAS;
P_Memory* __P_API_MEMORY;
P_Memory* __P_API_CHUNK_SCREENDATA;
int __P_API_COLOR = 0;

int pLua_color (lua_State* L)
{
	int v = lua_tonumber(L, 1);

	__P_API_COLOR = v % 16;

	return 1;
}

int pLua_rect (lua_State* L)
{
	int x1 = lua_tonumber(L, 1);
	int y1 = lua_tonumber(L, 2);
	int x2 = lua_tonumber(L, 3);
	int y2 = lua_tonumber(L, 4);

	// BeginTextureMode(*__P_API_CANVAS);
	// DrawRectangle(x1, y1, x2 - x1, y2 - y1, pColorGet(__P_API_COLOR));
	// EndTextureMode();

	for (int x = x1; x < x2; x++)
	{
		for (int y = y1; y < y2; y++)
		{
			int location = y * 256 + x;
			pMemorySet(__P_API_CHUNK_SCREENDATA, location, __P_API_COLOR);
		}
	}

	return 1;
}

int pLua_peek (lua_State* L)
{
	int location = lua_tonumber(L, 1);
	P_uchar* _value = pMemoryGet(__P_API_MEMORY, location);

	// https://stackoverflow.com/a/17071522/22146374
	int value = _value[0] | _value[1] << 8;

	lua_pushnumber(L, value);

	return 1;
}

int pLua_poke (lua_State* L)
{
	int location = lua_tonumber(L, 1);
	int value = lua_tonumber(L, 2);

	// https://stackoverflow.com/a/3919816/22146374
	P_uchar v1 = (P_uchar)value;
	P_uchar v2 = (P_uchar)(value >> 8);

	// printf("%d, %d,%d\n", value, v1, v2);

	pMemorySetOffset(__P_API_MEMORY, location, v1, 0);
	pMemorySetOffset(__P_API_MEMORY, location, v2, 1);

	return 1;
}
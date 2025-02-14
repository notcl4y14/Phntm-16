#include "Public.h"
#include "API.h"

RenderTexture2D* __P_API_CANVAS;

int rect (lua_State* L)
{
	int x1 = lua_tonumber(L, 1);
	int y1 = lua_tonumber(L, 2);
	int x2 = lua_tonumber(L, 3);
	int y2 = lua_tonumber(L, 4);

	BeginTextureMode(*__P_API_CANVAS);
	DrawRectangle(x1, y1, x2 - x1, y2 - y1, P_COLOR_WHITE);
	EndTextureMode();

	return 1;
}
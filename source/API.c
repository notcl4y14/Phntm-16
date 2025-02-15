#include "Public.h"
#include "API.h"

// RenderTexture2D* __P_API_CANVAS;
// int __P_API_COLOR = 0;

// Color getColor (int color)
// {
// 	switch (color)
// 	{
// 		case 0: return P_COLOR_DARKER_BLUE;
// 		case 1: return P_COLOR_PURPLE;
// 		case 2: return P_COLOR_RED;
// 		case 3: return P_COLOR_ORANGE;
// 		case 4: return P_COLOR_YELLOW;
// 		case 5: return P_COLOR_LIME;
// 		case 6: return P_COLOR_GREEN;
// 		case 7: return P_COLOR_TEAL;
// 		case 8: return P_COLOR_DARK_BLUE;
// 		case 9: return P_COLOR_BLUE;
// 		case 10: return P_COLOR_LIGHT_BLUE;
// 		case 11: return P_COLOR_LIGHTER_BLUE;
// 		case 12: return P_COLOR_WHITE;
// 		case 13: return P_COLOR_LIGHT_GRAY;
// 		case 14: return P_COLOR_GRAY;
// 		case 15: return P_COLOR_DARK_GRAY;
// 		default: return BLACK;
// 	}
// }

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

	BeginTextureMode(*__P_API_CANVAS);
	DrawRectangle(x1, y1, x2 - x1, y2 - y1, pColorGet(__P_API_COLOR));
	EndTextureMode();

	return 1;
}
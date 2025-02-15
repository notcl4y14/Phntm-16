#include "Public.h"

Color pColorGet (int v)
{
	switch (v)
	{
		case 0: return P_COLOR_DARKER_BLUE;
		case 1: return P_COLOR_PURPLE;
		case 2: return P_COLOR_RED;
		case 3: return P_COLOR_ORANGE;
		case 4: return P_COLOR_YELLOW;
		case 5: return P_COLOR_LIME;
		case 6: return P_COLOR_GREEN;
		case 7: return P_COLOR_TEAL;
		case 8: return P_COLOR_DARK_BLUE;
		case 9: return P_COLOR_BLUE;
		case 10: return P_COLOR_LIGHT_BLUE;
		case 11: return P_COLOR_LIGHTER_BLUE;
		case 12: return P_COLOR_WHITE;
		case 13: return P_COLOR_LIGHT_GRAY;
		case 14: return P_COLOR_GRAY;
		case 15: return P_COLOR_DARK_GRAY;
		default: return BLACK;
	}
}
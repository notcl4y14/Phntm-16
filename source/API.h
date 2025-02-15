#include <raylib.h>
#include <lua.h>

#ifndef PHANTOM_API_H
#define PHANTOM_API_H

extern RenderTexture2D* __P_API_CANVAS;
extern int __P_API_COLOR;

int pLua_color(lua_State* L);
int pLua_rect(lua_State* L);

#endif
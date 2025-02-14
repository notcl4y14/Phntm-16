#include <raylib.h>
#include <lua.h>

#ifndef PHANTOM_API_H
#define PHANTOM_API_H

extern RenderTexture2D* __P_API_CANVAS;

int rect(lua_State* L);

#endif
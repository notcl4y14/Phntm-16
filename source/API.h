#include <raylib.h>
#include <lua.h>
#include "Memory.h"

#ifndef PHANTOM_API_H
#define PHANTOM_API_H

extern RenderTexture2D* __P_API_CANVAS;
extern P_Memory* __P_API_MEMORY;
extern P_Memory* __P_API_CHUNK_SCREENDATA;
extern P_Memory* __P_API_CHUNK_SPRITEDATA;
extern int __P_API_COLOR;

int pLua_color(lua_State* L);
int pLua_rect(lua_State* L);
int pLua_peek(lua_State* L);
int pLua_poke(lua_State* L);
int pLua_spr(lua_State* L);

#endif
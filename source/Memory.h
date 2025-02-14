#include "Public.h"

#ifndef PHANTOM_MEMORY_H
#define PHANTOM_MEMORY_H

typedef struct
{
	unsigned char* data;
	int size;
	int byte_size;

	int count;
} P_Memory;

P_Memory pCreateMemory(int size, int byte_size);
void pFreeMemory(P_Memory* p);

void pMemorySet(P_Memory* p, int location, P_uchar value);
P_uchar* pMemoryGet(P_Memory* p, int location);

P_Memory pMemoryGetChunk(P_Memory* p, int start, int end);

#endif
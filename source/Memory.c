#include "Memory.h"
#include <stdlib.h>

P_Memory pCreateMemory(int size, int byte_size)
{
	P_Memory p;

	p.size = size;
	p.byte_size = byte_size;
	p.count = 0;
	p.data = calloc(size, byte_size);

	return p;
}

void pFreeMemory(P_Memory* p)
{
	free(p->data);
}

void pMemorySet(P_Memory* p, int location, P_uchar value)
{
	p->data[location * p->byte_size] = value;
}

P_uchar* pMemoryGet(P_Memory* p, int location)
{
	return &p->data[location * p->byte_size];
}

P_Memory pMemoryGetChunk(P_Memory* p, int start, int end)
{
	P_Memory _p;

	_p.size = end - start;
	_p.byte_size = p->byte_size;
	_p.count = 0;
	_p.data = &p->data[(end - start) * _p.byte_size];

	return _p;
}
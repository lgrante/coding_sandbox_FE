#include <emscripten/emscripten.h>
#include <stdio.h>


EMSCRIPTEN_KEEPALIVE int test()
{
	return 42;
}

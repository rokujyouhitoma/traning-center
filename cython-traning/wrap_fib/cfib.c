#include "cfib.h"

unsigned long cfib(unsigned long n)
{
    int a=1, b=1, i=0, tmp=0;
    for(i=0; i<n; i++) {
        tmp = a; a += b; b = tmp;
    }
    return a;
}

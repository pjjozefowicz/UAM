#include "avg.h"
#include "macros.h"

int avg(int tab[])
{
	int sum = 0;
        for (int i = 0; i < TSIZE; i++) {
		sum += tab[i];
        }
        return sum/TSIZE;
}


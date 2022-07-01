#include "min.h"
#include "macros.h"

int min(int tab[]) 
{

	int min = tab[0];
        for (int i = 1; i < TSIZE; i++) {
		if (tab[i] < min)
			min = tab[i];
	}
	return min;
}

#include "max.h"
#include "macros.h"

int max(int tab[])
{
        int max = 0;
        for (int i = 0; i < TSIZE; i++) {
                if (tab[i] > max)
                        max = tab[i];
        }
        return max;
}


#include <stdio.h>

#define D_COUNT 5  //ilość par (x, f(x)) na wejsciu


float tabX[D_COUNT] = {0, 1, 2, 4, 5};
float tabY[D_COUNT] = {7, 3, -1, 3, -3};
float result[D_COUNT];


float diffQ(int, int, int);  	//oblicz ilorazy różnicowe i zapisz wybrane do tablicy wynikowej 
void reverse();			//odwróć tablice
float valueAt(int, int);	//oblicz wartość wielomianu w punkcie

int main()
{
	int i;

	diffQ(0, D_COUNT-1, 0);
	reverse(result);
	printf("Wspolczynniki wielomianu: ");
	for(i = 0; i < D_COUNT; i++)
		printf("%g ", result[i]);

	printf("\nWartosc L(3): %g\n", valueAt(3, D_COUNT-1));

	return 0;
}


float diffQ(int a, int b, int h)	//zmienna h sluzy do wyznaczania gornej krawedzi trojkatnej tablicy
{
	float k;
	int p;

	if (a == b) {
		if (h == D_COUNT-1)
			result[h] = tabY[a];
		return tabY[a];
	}
	else {
		p = h;
		k = (diffQ(a+1, b, -1) - diffQ(a, b-1, ((p<0) ? -1 : ++p))) / (tabX[b] - tabX[a]);
		if (h >= 0)
			result[h] = k;
		return k;	
	}
}

float valueAt(int x, int n)
{
	float k;
	int j;

	k = result[n];
	for (j = n-1; j >= 0; j--)
		k = k * (x - tabX[j]) + result[j];
	return k;
}

void reverse()
{
	int i, j;
	float c;

	for (i = 0, j = D_COUNT-1; i < j; i++, j--)
		c = result[i], result[i] = result[j], result[j] = c;
}

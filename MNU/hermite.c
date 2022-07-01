#include <stdio.h>

#define CCOUNT 9 	//ilosc wejsciowych par (x, f(x))
#define XCOUNT 5    	//ilosc (roznych) x 

float diffQ(int, int, int);  	//oblicz ilorazy różnicowe i zapisz wybrane do tablicy wynikowej 
void reverse();			//odwróć tablice
float valueAt(int, int);	//oblicz wartość wielomianu w punkcie
int factorial(int);		//oblicz silnie
float zeroS(int, int);		//oblicz il.roznicowy kiedy dzielimy przez zero	

float tabX[CCOUNT] = {0, 0, 1, 2, 4, 4, 5, 5, 5};
float tabY[CCOUNT] = {7, 7, 3, -1, 3, 3, -3, -3, -3};
float result[CCOUNT];

float T[3][3] = {	//wiersz tablicy T kojarzy x z kolejnymi wartosciami pochodnych wyzszych rzedów z f(x)  
	{0, 3},
	{4, 1},
	{5, 1, 2}
	};


int main()
{	
	int i;

	diffQ(0, CCOUNT-1, 0);
	reverse(result);	
	printf("Wspolczynniki wielomianu: ");
	for(i = 0; i < CCOUNT; i++)
		printf("%g ", result[i]);

	printf("\nWartosc H(0): %g\n", valueAt(0, CCOUNT-1));
	printf("Wartosc H(1): %g\n", valueAt(1, CCOUNT-1));
	printf("Wartosc H(2): %g\n", valueAt(2, CCOUNT-1));
	printf("Wartosc H(4): %g\n", valueAt(4, CCOUNT-1));
	printf("Wartosc H(5): %g\n", valueAt(5, CCOUNT-1));

	return 0;
}


float diffQ(int a, int b, int h)	//zmienna h sluzy do wyznaczania gornej krawedzi trojkatnej tablicy
{
	float k, r;
	int p, d;

	if (a == b) {	
		if (h == CCOUNT-1)
			result[h] = tabY[a];
		return tabY[a];
	}
	else {
		p = h;
		k = (diffQ(a+1, b, -1) - diffQ(a, b-1, ((p<0) ? -1 : ++p)));	
		d = tabX[b] - tabX[a];
		if (d == 0)
			r = zeroS((b-a)+1, tabX[b]);
		else
			r = k/d;
		if (h >= 0)
			result[h] = r;
		return r;	
	}
}

float zeroS(int i, int x)
{
	int j;
	for (j = 0; j < XCOUNT; j++)
		if (T[j][0] == x) 
			break;
	return T[j][i-1]/factorial(i-1);
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

int factorial(int n) 
{
	int i, fact = 1;

	for (i = 1; i <= n; i++)
    		fact = fact * i;
	return fact;	
}

void reverse()
{
	int i, j;
	float c;

	for (i = 0, j = CCOUNT-1; i < j; i++, j--)
		c = result[i], result[i] = result[j], result[j] = c;
}


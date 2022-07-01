#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minimum(int *tab, int n) {

	int m = INT_MAX;
	int i;

	for (i=0; i<n; i++) 
		if (m > tab[i])
			m = tab[i];

	return m;
}

int maksimum(int *tab, int n) {

	int m = INT_MIN;
	int i;

	for (i=0; i<n; i++) 
		if (m < tab[i])
			m = tab[i];

	return m;
}

int sredni(int *tab, int n) {

	int avg = 0;
	int i;

	for (i=0; i<n; i++)
		avg += tab[i];

	return avg/n;
}


int main ()
{
	int *tabl, i, n;

	printf("Tablice... znajdz wszystkie bledy :)\n");
	printf("Podaj dlugosc tablicy od 0 do 100 \n");
	scanf("%d", &n);

	tabl = (int*)malloc(n*sizeof(int));

	for (i=0; i<n; i++) {
		printf("Podaj %d element tablicy \n", i+1);
		scanf("%d", &tabl[i]);
	}

	printf("min tablicy to: %d\n", minimum(tabl, n));
	printf("max tablicy to: %d\n", maksimum(tabl, n));
	printf("avg tablicy to: %d\n", sredni(tabl, n));

	free(tabl);

	return 0;
}

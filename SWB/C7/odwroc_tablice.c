#include <stdio.h>
#include <math.h>

void wyswietl(int *t, int length) {

	for (int i=0; i<length; i++)
		printf("%d ", t[i]);
	printf("\n");
}

int main()
{
	int n, temp, i, j;

	printf("Tablice... znajdz wszystkie bledy :)\n");
	printf("Podaj dlugosc tablicy od 0 do 100 \n");
	scanf("%d", &n);

	int *tablica = (int*)malloc(n*sizeof(int));

	for(int i=0; i<n; i++)
		tablica[i]=i;

	printf("Aktualna tablica to:\n");
	wyswietl(tablica, n);

	printf("\nOdwracamy tabice\n");

	for (i = 0, j = n-1; i < j; i++, j--) {
		temp = tablica[i];
		tablica[i] = tablica[j];
		tablica[j] = temp;
	}

	printf("Odwrocona tablica to:\n");
	wyswietl(tablica, n);
	free(tablica);

	return 0;
}

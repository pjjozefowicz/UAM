#include <iostream>
#include <cstdlib>
#include <ctime>
#include "sortowanie.h"
#include "../libs/libswbmath/src/min.h"
#include "../libs/libswbmath/src/max.h"
#include "../libs/libswbmath/src/avg.h"
#include "../libs/libswbmath/src/macros.h"

using namespace std;

void randomize(int tab[]) {

	srand(time(NULL));

	for (int i = 0; i < TSIZE; i++)
		tab[i] = rand() % 100 + 1;
}

void print(int tab[]) {

	for (int i = 0; i < TSIZE; i++)
		cout << tab[i] << " ";
	cout<<endl<<endl;
}




int main() {

	int tab[TSIZE];

	randomize(tab);
	print(tab);

    Quicksort sort;
	sort.quickSort(tab, 0, TSIZE-1);

	print(tab);

	cout << "Min: " << min(tab) << endl;
	cout << "Max: " << max(tab) << endl;
	cout << "Average: " << avg(tab) << endl;
}

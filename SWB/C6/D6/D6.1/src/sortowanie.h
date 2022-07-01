#ifndef __SORTOWANIE_H
#define __SORTOWANIE_H

class Quicksort {
public: 
	void swap(int* a, int* b);
	int partition (int arr[], int low, int high);
	void quickSort(int arr[], int low, int high);
};

#endif

#include <iostream>
#include <vector>
#include <cstdlib>
#include <stdio.h>
#include <string.h>
#include "infoelement.h"
#include "heap.h"

using namespace std;




int MAX_PRIORITY = 1000000;
BinaryMinHeap *queue1;
BinaryMinHeap *queue2;

void losujElementy(int count, char* prefix, BinaryMinHeap *queue) {
	char str[100];
	for (int i = 0; i < count; i++) {
		int priority = rand() % MAX_PRIORITY;
	//	sprintf(str, "napis do wyswietlenia: %s %d", prefix, priority);
		sprintf(str,"%d", priority);
		
		queue->insert(new InfoElement(strdup(str), priority));
	}
}

void usuwajElementy(BinaryMinHeap* q1, BinaryMinHeap* q2) {

	/*for (int i = 0; i <= MAX_PRIORITY; i++) {
		while (!q1->isEmpty() && q1->getMinimum()->time < i) {
		//	printf("Minimum to: %s\n", q1->getMinimum()->info);
			q1->removeMin();
		}
		while (!q2->isEmpty() && q2->getMinimum()->time < i) {
		//	printf("Minimum to: %s\n", q2->getMinimum()->info);
			q2->removeMin();
		}
	}*/

		while(!q1->isEmpty()) {
			//printf("Minimum to: %s\n", q1->getMinimum()->info);
			q1->removeMin();
		}

		while(!q2->isEmpty()) {
			//printf("Minimum to: %s\n", q2->getMinimum()->info);
			q2->removeMin();
		}
}

void usuwajCichoElementy(BinaryMinHeap* q1, BinaryMinHeap* q2) {

	/*for (int i = 0; i <= MAX_PRIORITY; i++) {
		while (!q1->isEmpty() && q1->getMinimum()->time < i) {
		//	printf("Minimum to: %s\n", q1->getMinimum()->info);
			q1->removeMin();
		}
		while (!q2->isEmpty() && q2->getMinimum()->time < i) {
		//	printf("Minimum to: %s\n", q2->getMinimum()->info);
			q2->removeMin();
		}
	}*/

		while(!q1->isEmpty()) {
		//	printf("Minimum to: %s\n", q1->getMinimum()->info);
			q1->removeMin();
		}

		while(!q2->isEmpty()) {
		//	printf("Minimum to: %s\n", q2->getMinimum()->info);
			q2->removeMin();
		}
	
}


int main() {
	srand((unsigned) time(NULL));

	queue1 = new BinaryMinHeap();
	queue2 = new BinaryMinHeap();

	losujElementy(30000, "kolejka1", queue1);
	losujElementy(30000, "kolejka2", queue2);
	
	printf("Wylosowałem elementy\n");

	printf("Minimum to: %s\n", queue1->getMinimum()->info);

	queue1->removeMin();
	
	printf("Minimum to: %s\n", queue1->getMinimum()->info);

	queue1->removeMin();

	usuwajElementy(queue1,queue2);

	losujElementy(350000, "kolejka1", queue1);
	losujElementy(350000, "kolejka2", queue2);

	usuwajCichoElementy(queue1,queue2);

	return 0;
}

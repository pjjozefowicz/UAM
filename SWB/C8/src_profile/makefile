# Main makefile
CC=g++
CFLAGS=-c -Wall

heapproject: heapproject.o heap.o infoelement.o 
	$(CC) -pg -g $^ -o $@

%.o: %.cpp %.h
	$(CC) -pg -g $(CFLAGS) $< -o $@

run_memory_leak: heapproject
	valgrind  --leak-check=full ./$<

run_callgrind: heapproject
	valgrind --tool=callgrind ./$<

clean:
	rm -f ./*.o heapproject gmon.out

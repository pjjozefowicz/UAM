# Main makefile

all: double_free_gdb double_free_lite strip 

double_free_gdb: double_free.c
	g++ -g double_free.c -o double_free_gdb

double_free_lite: double_free.c
	g++ double_free.c -o double_free_lite

strip: double_free_lite
	strip -g double_free_lite

clean:
	rm -f double_free_lite double_free_gdb core

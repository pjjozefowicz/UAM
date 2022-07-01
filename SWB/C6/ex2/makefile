# Main makefile
CC=g++
CFLAGS=-c -Wall
ODIR=obj/
BDIR=bin/
OBJ:=$(patsubst %.cpp,$(ODIR)%.o,$(wildcard *.cpp))

$(BDIR)main: $(OBJ)
	$(CC) $^ -o $@

$(ODIR)%.o: %.cpp %.h
	$(CC) $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -f obj/*
	rm -f bin/*

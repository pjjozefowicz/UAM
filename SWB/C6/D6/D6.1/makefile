# Main makefile
CC=g++
CFLAGS=-c -Wall
SRCDIR=src/
OBJDIR=obj/
OBJ := $(patsubst $(SRCDIR)%.cpp,$(OBJDIR)%.o,$(wildcard $(SRCDIR)*.cpp))
MACROS=src/macros.h

all: cw7_dom1

cw7_dom1: $(OBJ)
	$(CC) $^ -o $@
	  
$(OBJDIR)cw7_dom1.o: $(SRCDIR)cw7_dom1.cpp | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR)%.o:  $(SRCDIR)%.cpp  $(SRCDIR)%.h $(MACROS) | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

.PHONY: clean
clean:
	rm -f cw7_dom1
	rm -f -r obj/

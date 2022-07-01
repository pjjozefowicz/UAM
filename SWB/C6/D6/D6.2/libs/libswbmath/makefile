CC=g++
CFLAGS=-c -Wall
SRCDIR:=src/
OBJDIR:=obj/
MACROS=macros.h
DSTDIR:=../
OBJ := $(patsubst $(SRCDIR)%.cpp,$(OBJDIR)%.o,$(wildcard $(SRCDIR)*.cpp))

all: build install

build: libswbmath.a

libswbmath.a: $(OBJ)
	ar rvs $@ $^
#$(CC) -c -Wall  $^ -o $@

$(OBJDIR)%.o: $(SRCDIR)%.cpp  $(SRCDIR)%.h $(SRCDIR)$(MACROS) | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

install: $(DSTDIR)libswbmath.a

$(DSTDIR)libswbmath.a: libswbmath.a
	cp -p $< $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

.PHONY: clean
clean:
	rm -f -r obj/
	rm -f *.a ../*.a


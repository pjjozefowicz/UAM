CC=g++
CFLAGS=-c -Wall
BINDIR:=bin
SRCDIR:=src
OBJDIR:=obj
DSTDIR:=..

all: build install

build: $(OBJDIR)/libPrint.o | $(BINDIR)
	ar rvs $(BINDIR)/libPrint.a $<	

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp %.h | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

install: $(DSTDIR)/libPrint.a 

$(DSTDIR)/libPrint.a: $(BINDIR)/libPrint.a
	cp $< $@

$(BINDIR):
	mkdir -p $(BINDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	rm -f -r obj bin ../*.a


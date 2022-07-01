# Main makefile
CC:=g++
CFLAGS:=-c -Wall
OBJDIR:=obj
BINDIR:=bin
SRCDIR:=src
OUTDIR:=out
OBJ := $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(wildcard $(SRCDIR)/*.cpp))

LIBBASEDIR:=libs
# Thanks to the structure of this makefile, we just need to add lib names in the line below; All the rest will be handled by subsequent makefiles and scripts.
LIBDIRS:=libswbmath
LIBS:= $(addprefix $(LIBBASEDIR)/, $(LIBDIRS))
LIBS:= $(addsuffix .a, $(LIBS))

#LIBS=lib/libswbmath.a

all: build install

install: $(BINDIR)/cw7_dom1

$(BINDIR)/cw7_dom1: $(OBJ) $(LIBS) |$(BINDIR)
	$(CC) $(OBJ) -static -Llibs/ -lswbmath -o $@

build: $(LIBS) $(OBJ)

$(OBJDIR)/sortowanie.o: $(SRCDIR)/sortowanie.cpp $(SRCDIR)/sortowanie.h |$(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR)/cw7_dom1.o: $(SRCDIR)/cw7_dom1.cpp |$(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

$(BINDIR):
	mkdir -p $(BINDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(LIBBASEDIR)/%.a:	
	@$(MAKE) -C $(LIBBASEDIR)/$*/

.PHONY:clean

clean:
	rm -f -r obj/ out/ bin/
#Run clean for every makefile in subdirectories. && is needed to interpret multiple commands in one line, true - to end the command with "&& true".
	@$(foreach path,$(LIBDIRS), $(MAKE) clean -C $(LIBBASEDIR)/$(path) &&) true 

CC=g++

ifeq ($(DEBUG),yes)
	CXXFLAGS=-Wall -g
	LDFLAGS=-Wall -g
else
	CXXFLAGS=-Wall
	LDFLAGS=-Wall
endif

INCPATH=inc
SRCPATH=src
OBJPATH=obj
LIBPATH=lib
BINPATH=bin

INC=$(INCPATH)/mathy.h
SRC=$(SRCPATH)/mathy.cc
OBJ=$(OBJPATH)/mathy.o
OUT=$(LIBPATH)/libmathy.so

INCLUDES=-I ./$(INCPATH)

DIR_GUARD=mkdir -pv $(@D)

default: $(OUT)

$(OUT): $(OBJ)
	@$(DIR_GUARD)
	@$(CC) $(LDFLAGS) -shared -o $@ $^ && echo "[OK]: $@"

$(OBJPATH)/%.o: $(SRCPATH)/%.cc $(INC)
	@$(DIR_GUARD)
	@$(CC) $(CXXFLAGS) $(INCLUDES) -fpic -c $< -o $@ && echo "[OK]: $@"

.PHONY: clean cleanall

clean:
	@rm -fv $(LIBPATH)/* && echo "[Clean]: $(LIBPATH)/"
	@rm -fv $(OBJPATH)/* && echo "[Clean]: $(OBJPATH)/"

cleanall: clean
	rm -f $(OUT)

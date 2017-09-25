CXX             := g++
LD              := g++

WARNINGS        := -Wall -Wextra \
                   -Warray-bounds \
                   -Weffc++ \
                   -Wno-parentheses \
                   -Wpedantic \
                   -Wwrite-strings
FLAGS           := -std=c++11 $(WARNINGS)
CXXFLAGS        := $(FLAGS)
LDFLAGS         := $(FLAGS)

ifeq ($(DEBUG),yes)
	CXXFLAGS := $(CXXFLAGS) -g
	LDFLAGS := $(LDFLAGS) -g
else
	CXXFLAGS := $(CXXFLAGS)
	LDFLAGS := $(LDFLAGS)
endif

PROJECT_DIR := $(PWD)/native-app
OUTPUT_DIR := $(PWD)/out

INCPATH=$(PROJECT_DIR)/inc
SRCPATH=$(PROJECT_DIR)/src

OBJPATH=$(OUTPUT_DIR)/obj
LIBPATH=$(OUTPUT_DIR)/lib
BINPATH=$(OUTPUT_DIR)/bin

INC=$(INCPATH)/mathy.h
SRC=$(SRCPATH)/mathy.cc

OBJ=$(OBJPATH)/mathy.o
OUT=$(LIBPATH)/libmathy.a

INCLUDES=-I $(INCPATH)

DIR_GUARD=mkdir -pv $(@D)

default: $(OUT)

$(OUT): $(OBJ)
	@$(DIR_GUARD)
	echo "$$<" $<
	echo "$$^" $^
	echo "$$@" $@
	$(AR) $(ARFLAGS) $@ $(OBJ) && echo "[OK]: $@"

$(OBJ): $(SRC)
	@$(DIR_GUARD)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@ && echo "[OK]: $@"

.PHONY: clean cleanall

clean:
	@rm -fv $(LIBPATH)/* && echo "[Clean]: $(LIBPATH)/"
	@rm -fv $(OBJPATH)/* && echo "[Clean]: $(OBJPATH)/"

cleanall: clean
	rm -f $(OUT)

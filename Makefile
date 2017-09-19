#-----------------------------------------------------------------------

CXX             := g++
LD              := g++

AR               = ar
ARFLAGS          = rcs

WARNINGS        := -Wall -Wextra \
                   -Warray-bounds \
                   -Weffc++ \
                   -Wno-parentheses \
                   -Wpedantic \
                   -Wwrite-strings

EXEC            := main
FLAGS           := -std=c++11 $(WARNINGS)
CXXFLAGS        := $(FLAGS)
LDFLAGS         := $(FLAGS)
INC             := -I inc
SRC             := $(wildcard src/*.cc)
OBJ             := $(SRC:src/%.cc=obj/%.o)

EXEC_TEST       := test
FLAGS_TEST      := $(FLAGS)
CXXFLAGS_TEST   := $(CXXFLAGS)
LDFLAGS_TEST    := $(LDFLAGS)
INC_TEST        := $(INC) -I inc
SRC_TEST        := $(wildcard tst/*.cc)
OBJ_TEST        := $(filter-out obj/main.o, $(OBJ)) $(SRC_TEST:tst/%.cc=obj/%.o)

DIR_GUARD		 = mkdir -pv $(@D)

.SUFFIXES:

#-----------------------------------------------------------------------

.PHONY: all
all: bin/$(EXEC) lib/libmathy.a lib/libmathy.so

bin/$(EXEC): $(OBJ)
	@$(DIR_GUARD)
	@echo "#" $(OBJ)
	@$(LD) $(LDFLAGS) $^ -o $@ && echo "[OK]: $@"
	@$@

lib/libmathy.a: obj/mathy.o
	@$(DIR_GUARD)
	@$(AR) $(ARFLAGS) $@ $(OBJ) && echo "[OK]: $@"

lib/libmathy.so: obj/mathy.o
	@$(DIR_GUARD)
	@$(CC) $(LDFLAGS) -shared -o $@ $^ && echo "[OK]: $@"

#-----------------------------------------------------------------------

.PHONY: test
test: bin/$(EXEC_TEST)

bin/$(EXEC_TEST): $(OBJ_TEST)
	@$(DIR_GUARD)
	@$(LD) $(LDFLAGS_TEST) $^ -o $@ && echo "[OK]: $@"
	@$@

#-----------------------------------------------------------------------

obj/%.o: src/%.cc
	@$(DIR_GUARD)
	@$(CXX) $(CXXFLAGS) -c $< $(INC) -o $@ && echo "[OK]: $@"

obj/%.o: tst/%.cc
	@$(DIR_GUARD)
	@echo "$$<" $<
	@echo "$$^" $^
	@echo "$$@" $@
	@$(CXX) $(CXXFLAGS_TEST) -c $< $(INC_TEST) -o $@ && echo "[OK]: $@"

#-----------------------------------------------------------------------

.PHONY: clean, clear
clean clear:
	@rm -fv bin/* && echo "[Clean]: bin/"
	@rm -fv lib/* && echo "[Clean]: lib/"
	@rm -fv obj/* && echo "[Clean]: obj/"

.PHONY: archive, zip
archive zip:
	@zip -x bin/* obj/* lib/* -q -r bin/$(EXEC)-$(shell date '+%F').zip . && echo "[OK]: bin/$(EXEC)-$(shell date '+%F').zip"

#-----------------------------------------------------------------------

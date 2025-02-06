SRC = $(wildcard src/*.cpp)

CC = g++

COMPILER_FLAGS = -w -Wall -O3 -pg

LINKER_FLAGS = -lSDL2
INCLUDE = -Iinclude/

OBJ_NAME = ref_main

all: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) $(LINKER_FLAGS) -o $(OBJ_NAME)

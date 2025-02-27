SRC = $(wildcard src/*.cpp)

CC = g++

COMPILER_FLAGS = -w -Wall -O3 -pg -g

LINKER_FLAGS = -lSDL2
INCLUDE = -Iinclude/

OBJ_NAME = ref_main

no_sdl: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) -o $(OBJ_NAME)

sdl: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) $(LINKER_FLAGS) -DSDL -o $(OBJ_NAME)

all: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) $(LINKER_FLAGS) -DSDL -o $(OBJ_NAME)

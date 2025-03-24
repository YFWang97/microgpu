SRC = $(wildcard src/*.cpp)

CC = g++

COMPILER_FLAGS = -Wall -O3 -g

LINKER_FLAGS = -lSDL2
INCLUDE = -Iinclude/

OBJ_NAME = ref_main

no_sdl: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) -o $(OBJ_NAME)

sdl: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) $(LINKER_FLAGS) -DSDL -o $(OBJ_NAME)

mac: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) -std=c++11 -DSDL -framework SDL2 -F /Library/Frameworks -I /Library/Frameworks/SDL2.framework/Headers -o $(OBJ_NAME)

all: $(OBJS)
	$(CC) $(SRC) $(COMPILER_FLAGS) $(INCLUDE) $(LINKER_FLAGS) -DSDL -o $(OBJ_NAME)


# Nombre del ejecutable
TARGET = cache_simulator

# Compilador
CC = g++

# Opciones del compilador
CFLAGS = -std=c++11 -Wall -Wextra -g

# Archivos fuente y de cabecera
SOURCES = $(wildcard *.cpp)
HEADERS = $(wildcard *.h)
OBJECTS = $(SOURCES:.cpp=.o)

# Bibliotecas necesarias (solo si usas funciones matemáticas)
LIBS =

# Reglas especiales
.PHONY: all clean cleanall run

all: $(TARGET)

%.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) $(LIBS) -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o core

cleanall: clean
	rm -f $(TARGET)

SOURCES = $(patsubst %.c,%.o,$(wildcard *.c))
CFLAGS = -m32 -lX11

all: generate

generate: $(SOURCES)
	../../bin/c-generate.rb *.c > unix.asm

clean:
	-rm $(SOURCES) unix.asm

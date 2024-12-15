GNAME ?= TestBoy
CONSOLE ?= gbc

.PHONY: all clean

all:
	rgbgfx -c '#ffffff, #c0c0c0, #5f5f5f, #000000' -o "./gfx/tiles/bg_tiles.2bpp" "./gfx/tiles/bg_tiles.png"
	rgbgfx -c '#ffffff, #c0c0c0, #5f5f5f, #000000' -o "./gfx/tiles/text-inverted.2bpp" "./gfx/tiles/text-inverted.png"
	rgbgfx -c '#ffffff, #c0c0c0, #5f5f5f, #000000' -o "./gfx/sprites/sprite1.2bpp" "./gfx/sprites/sprite1.png"
	rgbgfx -c '#ffffff, #c0c0c0, #5f5f5f, #000000' -o "./gfx/sprites/sprite2.2bpp" "./gfx/sprites/sprite2.png"
	rgbasm -o main.o main.asm
	rgblink -n $(GNAME).sym -m $(GNAME).map -o $(GNAME).$(CONSOLE) main.o
	rgbfix -t TESTBOY -v -p 0xFF $(GNAME).$(CONSOLE)

clean:
	rm -rf *.o
	rm -rf *.gb
	rm -rf *.gbc
	rm -rf *.sym
	rm -rf *.map
	rm -rf *.2bpp
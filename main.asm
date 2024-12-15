    include "inc/hardware.inc"
    
    SECTION "Main code", ROM0[$100]
    
    include "src/main.asm"
    include "src/updatekeys.asm"
    include "src/memcopy.asm"
    include "src/checkkeys.asm"
    include "src/ballscore.asm"
    include "src/updatescore.asm"
    include "inc/charmap.asm"
    include "src/texts.asm"

SECTION "Tile data", ROM0

    Tiles:: incbin "gfx/tiles/bg_tiles.2bpp"
    TilesEnd::

    Font:: incbin "gfx/tiles/text-inverted.2bpp"
    FontEnd::

SECTION "Sprites", ROM0

    Sprite1:: incbin "gfx/sprites/sprite1.2bpp"
    Sprite1End::

    Sprite2:: incbin "gfx/sprites/sprite2.2bpp"
    Sprite2End::

SECTION "Tilemap", ROM0

    include "gfx/tilemaps/bg_tilemap.asm"
    include "gfx/tilemaps/title_tilemap.asm"
    include "gfx/tilemaps/windows_tilemap.asm"

SECTION "Variables", WRAM0

    include "ram/wram.asm"

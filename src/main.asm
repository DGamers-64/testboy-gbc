
SStart::
    jp EntryPoint
    ds $150 - @, 0

EntryPoint::
    xor a
    ld [rNR52], a

	; Do not turn the LCD off outside of VBlank
WaitVBlank::
	ld a, [rLY]
	cp 144
	jp c, WaitVBlank

	; Turn the LCD off
	xor a
	ld [rLCDC], a

    ld [wSeed], a
    ld [wSeed + 1], a
    ld [wScore], a
    ld [wScore + 1], a

    ld de, Font
    ld hl, $8800
    ld bc, FontEnd - Font
    call Memcopy

    ld de, TitleTilemap
    ld hl, $9800
    ld bc, TitleTilemapEnd - TitleTilemap
    call Memcopy

	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a

TitleDone::
    ld a, [rLY]
    cp 144
    jp nc, TitleDone
WaitVBlankTitle::
    ld a, [rLY]
    cp 144
    jp c, WaitVBlankTitle

    call UpdateKeys

IncrementLowSeed::
    ld a, [wSeed + 1]
    inc a
    ld [wSeed + 1], a
    cp 1
    jp nc, ContinueTitleDone

    ld a, [wSeed]
    inc a
    ld [wSeed], a
    
ContinueTitleDone::
    ld a, [wCurKeys]
    and a, PADF_START
    jp z, TitleDone

    jp Game

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; JUEGO ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Game::
    xor a
	ld [rLCDC], a

    ; Copy the tile data
    ld de, Tiles
    ld hl, $9000
    ld bc, TilesEnd - Tiles
    call Memcopy

    ; Copy the tilemap
    ld de, Tilemap
    ld hl, $9800
    ld bc, TilemapEnd - Tilemap
    call Memcopy

    ld hl, wScoreText
    ld de, $9C00
    call DrawTextTilesLoop

    ; Copy the sprite data
    ld de, Sprite1
    ld hl, $8000
    ld bc, Sprite1End - Sprite1
    call Memcopy

    ld de, Sprite2
    ld bc, Sprite2End - Sprite2
    call Memcopy

    ld a, 7
    ld [rWX], a

    ld a, 136
    ld [rWY], a

	xor a
    ld b, 160
    ld hl, _OAMRAM
ClearOam::
    ld [hli], a
    dec b
    jp nz, ClearOam

    ; Sprite 1
	ld hl, _OAMRAM
    ld a, 40
    ld [hli], a
    ld a, 24
    ld [hli], a
    xor a
    ld [hli], a
    ld [hl], a

    call PrintSprite2

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_WINON | LCDCF_BG9800 | LCDCF_WIN9C00 | LCDCF_BG8800
	ld [rLCDC], a

    ; During the first (blank) frame, initialize display registers
    ld a, %11100100
    ld [rBGP], a
    ld a, %11100100
    ld [rOBP0], a

    ; Initialize global variables
    xor a
    ld [wCurKeys], a
    ld [wNewKeys], a
	ld [wFrameCounter], a
    ld [wDirection], a

Main::
    ld a, [rLY]
    cp 144
    jp nc, Main
WaitVBlank2::
    ld a, [rLY]
    cp 144
    jp c, WaitVBlank2

    call UpdateKeys

    ld a, [wFrameCounter]
    inc a
    ld [wFrameCounter], a
    cp 7
    jp nz, Main
    xor a
    ld [wFrameCounter], a

    call CheckKeys
    call UpdateScore

ChangeDirections::
    ld a, [wDirection]
    cp 1
    call z, Left

    ld a, [wDirection]
    cp 2
    call z, Right

    ld a, [wDirection]
    cp 3
    call z, Up

    ld a, [wDirection]
    cp 4
    call z, Down

    jp Main

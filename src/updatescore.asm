UpdateScore::
    ld a, [_OAMRAM]
    ld b, a
    ld a, [_OAMRAM + 1]
    ld c, a
    ld a, [_OAMRAM + 4]
    ld d, a
    ld a, [_OAMRAM + 5]
    ld e, a
CompareBallAndPJY::
    ld a, b
    sub d
    cp 0
    jp z, CompareBallAndPJX
    ret
CompareBallAndPJX::
    ld a, c
    sub e
    cp 0
    jp z, SumScore
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SumScore::
    call PrintSprite2
    ld a, [wScore + 1]
    inc a
    ld [wScore + 1], a
    push af
    call PrintSumScore
    pop af
    cp 0
    jp z, SumScoreDecimal
    ret
SumScoreDecimal::
    ld a, [wScore]
    inc a
    ld [wScore], a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SubScore::
    ld a, [wScore + 1]
    sub 1
    cp $FF
    jp z, SubScoreDecimal
    ld [wScore + 1], a
    call PrintSubScore
    ret
SubScoreDecimal::
    ld a, [wScore]
    cp 0
    ret z
    sub 1
    ld [wScore], a
    ld a, $FF
    ld [wScore + 1], a
    call PrintSubScore
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintSumScore::
    ld a, [$9C13]
    inc a
    cp $AA
    jp z, PrintSumScoreDecimal
    ld [$9C13], a
    ret
PrintSumScoreDecimal::
    ld a, $A0
    ld [$9C13], a
    ld a, [$9C12]
    inc a
    cp $AA
    jp z, PrintSumScoreCentenar
    ld [$9C12], a
    ret
PrintSumScoreCentenar::
    ld a, $A0
    ld [$9C12], a
    ld a, [$9C11]
    inc a
    cp $AA
    jp z, PrintSumScoreThousand
    ld [$9C11], a
    ret
PrintSumScoreThousand::
    ld a, $A0
    ld [$9C11], a
    ld a, [$9C10]
    inc a
    ld [$9C10], a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintSubScore::
    ld a, [$9C13]
    dec a
    cp $9F
    jp z, PrintSubScoreDecimal
    ld [$9C13], a
    ret
PrintSubScoreDecimal::
    ld a, $A9
    ld [$9C13], a
    ld a, [$9C12]
    dec a
    cp $9F
    jp z, PrintSubScoreCentenar
    ld [$9C12], a
    ret
PrintSubScoreCentenar::
    ld a, $A9
    ld [$9C12], a
    ld a, [$9C11]
    dec a
    cp $9F
    jp z, PrintSubScoreThousand
    ld [$9C11], a
    ret
PrintSubScoreThousand::
    ld a, $A9
    ld [$9C11], a
    ld a, [$9C10]
    dec a
    ld [$9C10], a
    ret

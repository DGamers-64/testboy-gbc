CheckKeys::
CheckLeft::
    ld a, [wCurKeys]
    and a, PADF_LEFT
    jp z, CheckRight
    ld a, 1
    ld [wDirection], a
    ret
Left::
    ld a, [_OAMRAM + 1]
    cp 16
    jp z, SubScore
    sub a, 8
    ld [_OAMRAM + 1], a
    ret

CheckRight::
    ld a, [wCurKeys]
    and a, PADF_RIGHT
    jp z, CheckUp
    ld a, 2
    ld [wDirection], a
    ret
Right::
    ld a, [_OAMRAM + 1]
    cp 152
    jp z, SubScore
    add a, 8
    ld [_OAMRAM + 1], a
    ret

CheckUp::
    ld a, [wCurKeys]
    and a, PADF_UP
    jp z, CheckDown
    ld a, 3
    ld [wDirection], a
    ret
Up::
    ld a, [_OAMRAM]
    cp 24
    jp z, SubScore
    sub a, 8
    ld [_OAMRAM + 0], a
    ret

CheckDown::
    ld a, [wCurKeys]
    and a, PADF_DOWN
    ret z
    ld a, 4
    ld [wDirection], a
    ret
Down::
    ld a, [_OAMRAM]
    cp 136
    jp z, SubScore
    add a, 8
    ld [_OAMRAM], a
    ret

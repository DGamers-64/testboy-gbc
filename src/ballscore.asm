GenerateRandomNumber::
  ld a, [wSeed]
  ld b, a
  ld a, [wSeed + 1]
  ld c, a
  add b
  rrc c
  ld [wSeed + 1], a
  add b
  ld [wSeed], a
  ret

GenerateRandomMultipleOf8X::
  call GenerateRandomNumber
  and %11111000
  cp 0
  jr z, GenerateRandomMultipleOf8X
  cp 8
  jr z, GenerateRandomMultipleOf8X
  cp 152
  jr nc, GenerateRandomMultipleOf8X
  ret

GenerateRandomMultipleOf8Y::
  call GenerateRandomNumber
  and %11111000
  cp 0
  jp z, GenerateRandomMultipleOf8Y
  cp 8
  jp z, GenerateRandomMultipleOf8Y
  cp 16
  jp z, GenerateRandomMultipleOf8Y
  cp 24
  jp z, GenerateRandomMultipleOf8Y
  cp 144
  jp nc, GenerateRandomMultipleOf8Y
  ret

PrintSprite2::
  ld hl, _OAMRAM + 4
  call GenerateRandomMultipleOf8Y
  ld [hli], a
  call GenerateRandomMultipleOf8X
  ld [hli], a
  ld a, 1
  ld [hli], a
  xor a
  ld [hl], a
  ret

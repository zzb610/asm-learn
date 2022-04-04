start:
 ; 378 / 37 
  mov ax, 378
  mov bl, 37
  div bl

current:
  times (512 - 2 - (current - start)) db 0
  db 0x55, 0xaa
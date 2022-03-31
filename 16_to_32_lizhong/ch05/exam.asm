start:
  mov ax, 0xb800
  mov ds, ax

  ; "Assembly"
  mov byte [0x0000], 'A'
  mov byte [0x0001], 0x04

  mov byte [0x0002], 's'
  mov byte [0x0003], 0x04

  mov byte [0x0004], 's'
  mov byte [0x0005], 0x04

  mov byte [0x0006], 'e'
  mov byte [0x0007], 0x04

  mov byte [0x0008], 'm'
  mov byte [0x0009], 0x04

  mov byte [0x000a], 'b'
  mov byte [0x000b], 0x04

  mov byte [0x000c], 'l'
  mov byte [0x000d], 0x04

  mov byte [0x000e], 'y'
  mov byte [0x000f], 0x04

again:
  jmp again

current:
  times (512 - 2 - (current - start)) db 0
  db 0x55, 0xAA
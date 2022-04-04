start:
  ; 65535
  mov ax, 65535
  xor dx, dx ; mov dx, 0
  mov bx, 10
  div bx ; 5 in dx, 63335 ax


current:
  times (512 - 2 - (current - start)) db 0
  db 0x55, 0xaa

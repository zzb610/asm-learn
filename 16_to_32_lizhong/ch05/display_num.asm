start:
  ; display 65535
  mov ax, 65535
  xor dx, dx

  ; data segment
  mov cx, cs
  mov ds, cx

  mov bx, 10

  ; 5 in dx, 6553 in ax 
  div bx
  mov byte [0x7c00+number+4], dl
  xor dx, dx

  div bx
  mov byte [0x7c00+number+3], dl
  xor dx, dx

  div bx
  mov byte [0x7c00+number+2], dl
  xor dx, dx

  div bx
  mov byte [0x7c00+number+1], dl
  xor dx, dx

  div bx
  mov byte [0x7c00+number], dl
  xor dx, dx

  ; display
  mov cx, 0xb800
  mov es, cx

  mov bl, [0x7c00+number]
  add bl, 0x30
  mov byte [es:0], bl
  mov byte [es:1], 0x2f

  mov bl, [0x7c00+number+1]
  add bl, 0x30
  mov byte [es:2], bl
  mov byte [es:3], 0x2f

  mov bl, [0x7c00+number+2]
  add bl, 0x30
  mov byte [es:4], bl
  mov byte [es:5], 0x2f

  mov bl, [0x7c00+number+3]
  add bl, 0x30
  mov byte [es:6], bl
  mov byte [es:7], 0x2f

  mov bl, [0x7c00+number+4]
  add bl, 0x30
  mov byte [es:8], bl
  mov byte [es:9], 0x2f

again:
  jmp again

number db 0, 0, 0, 0, 0

current:
  times (512-2-(current-start)) db 0
  db 0x55, 0xaa
jmp start

text db 'L', 0x07, 'a', 0x07, 'b', 0x07, 'e', 0x07, 'l', 0x07, ' ', 0x07, 'o', 0x07, 'f', 0x07, 'f', 0x07, 's', 0x07, 'e', 0x07, 't', 0x07, ':', 0x07

number times 5 db 0

start:
  ; display 'Lable offset: '
  mov ax, 0x07c0
  mov ds, ax
  mov ax, 0xb800
  mov es, ax

  mov si, text
  mov di, 0
  mov cx, (number - text) / 2
  cld
  rep movsw

  ; get number digit
  mov ax, number
  mov bx, ax
  mov si, 10
  mov cx, 5

div_digit:
  xor dx, dx
  div si
  mov [bx], dl
  inc bx
  loop div_digit

  ; display digit
  mov cx, 5
display_num:
  dec bx
  mov al, [bx]
  add al, 0x30
  mov ah, 0x2f
  mov [es:di], ax
  add di, 2
  loop display_num

jmp $

times (512 - 2 - ($ - $$)) db 0
db 0x55, 0xaa
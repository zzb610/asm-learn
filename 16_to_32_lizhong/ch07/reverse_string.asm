jmp start

string db "abcdefghijklmnopqrstuvwxyz"

start:

mov ax, 0x07c0
mov ds, ax
mov bx, string

xor si, 0
mov di, start - string - 1

reverse:
  mov al, [bx+si]
  mov ah, [bx+di]
  mov [bx+si], ah
  mov [bx+di], al

  inc si
  dec di
  cmp si, di
  jl reverse

mov cx, (start - string)
mov ax, 0xb800
mov es, ax
mov bx, string
xor si, si
xor di, di

display_string:
  mov al, [bx+si]
  mov ah, 0x27
  mov [es:di], ax
  add di, 2
  inc si
  loop display_string

jmp $

times (512-2-($-$$)) db 0

db 0x55, 0xaa
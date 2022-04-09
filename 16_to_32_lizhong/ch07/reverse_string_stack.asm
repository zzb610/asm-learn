jmp start

string db "abcdefghijklmnopqrstuvwxyz"

start:
  mov ax, 0x07c0
  mov ds, ax
  ; push chars to stack
  mov ax, cs
  mov ss, ax
  xor sp, sp

  mov cx, (start-string)
  mov bx, string
push_to_stack:
  xor ax, ax
  mov al, [bx]
  inc bx
  push ax
  loop push_to_stack

  mov cx, (start-string)
  mov bx, string
pop_out_stack:
  pop ax
  mov [bx], al
  inc bx
  loop pop_out_stack

  mov cx, (start-string)
  mov ax, 0xb800
  mov es, ax
  mov si, string
  xor di, di
display_string:
  mov al, [si]
  mov ah, 0x70
  mov [es:di], ax
  add di, 2
  inc si
  loop display_string

jmp $

times (512-2-($-$$)) db 0

db 0x55, 0xaa
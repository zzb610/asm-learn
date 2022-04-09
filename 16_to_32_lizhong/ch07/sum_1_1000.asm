jmp start

info db "sum 1 to 1000 is: "

start:

xor ax, ax
xor dx, dx
mov cx, 1000

sum:
  add ax, cx
  adc dx, 0
  loop sum

  mov bx, cs
  mov ss, bx
  xor sp, sp
  mov bx, 10
  xor cx, cx ; digit counter
  
digit:
  div bx
  push dx
  inc cx
  xor dx, dx
  cmp ax, 0
  ja digit

  push cx
  mov ax, 0xb800
  mov es, ax
  mov ax, 0x07c0
  mov ds, ax
  mov si, info
  xor di, di
  mov cx, (start-info)

display_info:
  mov al, [si]
  mov ah, 0x70
  mov [es:di], ax
  inc si
  add di, 2
  loop display_info
  pop cx
 
display_number:
  pop ax
  add al, 0x30
  mov ah, 0x70
  mov [es:di], ax
  add di, 2
  loop display_number


jmp $

times (512 - 2 - ($-$$)) db 0

db 0x55, 0xaa
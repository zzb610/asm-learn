jmp start

message db "sum of 1 to 100 is:"

start:
  ; display message
  mov ax, 0x07c0
  mov ds, ax
  mov ax, 0xb800
  mov es, ax
 
  mov cx, (start - message)
  mov si, message
  xor di, di
show_message:
  mov al, [si]
  mov ah, 0x70
  inc si
  mov [es:di], ax
  add di, 2
  loop show_message

  ; sum 1 to 100, result in ax
  xor ax, ax
  mov cx, 1
sum_1_100:
  add ax, cx
  inc cx
  ; cx <= 100, contiue loop
  cmp cx, 100
  jbe sum_1_100

  ; sum number digit, use stack
  mov bx, 10
  xor cx, cx
  mov ss, cx
  mov sp, cx
  ; digit counter
  xor cx, cx
digit:
  xor dx, dx
  div bx
  push dx
  inc cx
  cmp ax, 0
  jne digit

  ; show number
show_number:
  pop ax
  add ax, 0x30
  mov ah, 0x70
  mov [es:di], ax
  add di, 2
  loop show_number

jmp $

times (512-2-($-$$)) db 0

db 0x55, 0xaa

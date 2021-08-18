mov ax, 1000H
mov ss, ax
mov sp, 0010H
mov ax, 001AH
mov bx, 001BH
push ax
push bx
; mov ax, 0; sub ax,ax的机器码是两个字节 mov ax,0的机器码是三个字节
; mov bx, 0
sub ax, ax
sub bx, bx
pop bx
pop ax

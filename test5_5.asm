assume cs:code

a segment
    db 1,2,3,4,5,6,7,8
a ends

b segment
    db 1,2,3,4,5,6,7,8
b ends

cz segment
    db 0,0,0,0,0,0,0,0
cz ends

code segment

start:
    mov ax, a
    mov ds, ax
    mov ax, b
    mov es, ax
    mov bx, 0
    mov cx, 8
s: mov dl, ds:[bx]
    add dl, es:[bx]
    push ds
    mov ax, cz
    mov ds, ax
    mov ds:[bx], dl
    pop ds
    inc bx
    loop s
    mov ax,4c00h
    int 21h
code ends

end start

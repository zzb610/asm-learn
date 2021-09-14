ASSUME cs:code

code SEGMENT
    mov ax, 0ffffH ; data can not start with charactars
    mov ds, ax
    mov ah, 0H
    mov bx, 6
    mov al, [bx]
    mov dx, 0
    mov cx, 3
s: add dx, ax
    loop s
    mov ax, 4c00H
    int 21h
code ENDS

END
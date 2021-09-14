ASSUME cs:code

code SEGMENT
    mov ax, 2
    mov cx, 11
s:  add ax, ax
    loop s
    mov ax, 4c00H
code ENDS

END
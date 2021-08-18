ASSUME cs:code

code SEGMENT
    mov ax, 2
    add ax, ax
    mov ax, 4c00H
    int 21h
code ENDS

END
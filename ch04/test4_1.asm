ASSUME cs:code

code SEGMENT
    mov ax, 0020h
    mov ds, ax
    mov bx, 0
    mov cx, 64
s:  mov [bx], bx
    inc bx
    loop s
    mov ax, 4c00h
    int 21h
code ENDS

END

 
assume cs:code

code segment
    start:
        sub ax, ax
        mov ax, 2

        shl ax, 1
        mov bx, ax

        mov cl, 2
        shl ax, cl

        add ax, bx
        mov ax, 4c00H
        int 21H
code ends

end start
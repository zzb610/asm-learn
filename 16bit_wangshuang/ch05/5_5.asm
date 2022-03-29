ASSUME cs:code

code SEGMENT
    mov ax, 0ffffH
    mov ds, ax
    mov cx, 000bh
    mov bx, 0000h
    mov dx, 0000h
    s: 
        mov ah, 00h
        mov al, [bx]
        add dx, ax
        ; add bx, 1
        inc bx
        loop s
    mov ax, 4c00H
    int 21h
code ENDS

END
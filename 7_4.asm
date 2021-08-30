assume cs:code, ds:datasg

datasg segment
    db 'BaSic'
    db 'iNfOrMaTiOn'
datasg ends

code segment
    start:
        mov ax, datasg
        mov ds, ax
        mov bx, 0
        mov cx, 5

        
    s:  mov dl, ds:[bx]
        and dl, 11011111B
        mov ds:[bx], dl
        inc bx
        loop s

        mov bx, 5
        mov cx, 11

    s0: mov dl, ds:[bx]
        or dl, 00100000B
        mov ds:[bx], dl
        inc bx
        loop s0

        mov ax, 4c00h
        int 21h
code ends

end start
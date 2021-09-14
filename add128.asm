assume cs:code, ds:data

data segment
    dw 8 dup(1) 
    dw 8 dup(2)
data ends

code segment

    start:
        mov ax, data
        mov ds, ax

        mov si, 0
        mov di, 16

        call add128

        mov ax, 4c00H
        int 21H
    add128:
        push ax
        push cx
        push si
        push di

        sub ax, ax
        mov cx, 8 ; 8 x 16 = 128
    
    s: 
        mov ax, [si]
        adc ax, [di]
        mov [si], ax
        inc si
        inc si
        inc di
        inc di
   loop s

        pop di
        pop si
        pop cx
        pop ax

        ret
code ends

end start

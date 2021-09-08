assume cs:code, ds:data, ss:stack

data segment
    db 'welcome to masm!'
    db 00000010B
    db 00100100B
    db 01110001B
data ends

stack segment
    dw 10 dup(0)
stack ends

code segment
    start:
        mov ax, data
        mov ds, ax
        ; mov ax, stack
        ; mov ss, ax
        ; mov sp, 20
        mov ax, 0b800H
        mov es, ax

        mov cx, 3
        mov bx, 0  ;source data
        mov si, 16 ;color
        mov di, 160*10 + 30; ;dest data
        
    show_words:
        push cx
        push di
        push si

        mov bx, 0
        mov cx, 16
    copy_chars:
        mov dl, ds:[bx]
        mov dh, ds:[si]
        mov es:[di], dx 
        add di, 2
        inc bx
        loop copy_chars
             
 
        pop si
        pop di
        pop cx

        inc si
        add di,160

        loop show_words

        mov ax, 4c00H
        int 21H



code ends

end start
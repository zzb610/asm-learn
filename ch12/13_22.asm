assume cs:code, ds:data

data segment
    db 'conversation', 0
data ends

code segment
    start:
        ; copy code
        mov ax, cs
        mov ds, ax
        mov si, offset capital
        mov cx, offset capitalend - offset capital
        mov ax, 0
        mov es, ax
        mov di, 200H
        cld
        rep movsb
        ; set interrupt vector table
        mov ax, 0
        mov es, ax
        mov word ptr es:[7ch*4], 200H
        mov word ptr es:[7ch*4+2], 0

        ; trigger
        mov ax, data
        mov ds, ax
        mov si, 0
        int 7ch

        mov ax, 4c00H
        int 21H

    capital:
        push cx
        push si
        mov ch, 0
    change:
        mov cl, [si]
        jcxz ok
        and byte ptr [si], 11011111B
        inc si
        jmp short change
    ok:
        pop si
        pop cx
        iret
    capitalend:
        nop
code ends

end start


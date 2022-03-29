assume cs:code

code segment

start:

    ; copy code
    mov ax, cs
    mov ds, ax
    mov si, offset lp
    mov cx, offset lpend - offset lp
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

    mov ax, 0b800H
    mov es, ax
    mov di, 160 * 12
    mov bx, offset s - offset se
    mov cx, 80

s: 
    mov byte ptr es:[di], '!'
    add di, 2
    int 7ch
se:
    nop

    mov ax, 4c00H
    int 21H

lp:
    push bp
    mov bp, sp
    dec cx
    jcxz lpret
    add [bp+2], bx
lpret:

    pop bp
    iret
lpend:
    nop

code ends

end start
assume cs:code

code segment

    start:
        ; 拷贝中断处理程序到 0:200H
        mov ax, cs
        mov ds, ax
        mov si, offset do0
        mov ax, 0
        mov es, ax
        mov di, 200H
        mov cx, offset do0end - offset do0
        cld
        rep movsb
        
        ; 设置中断向量表
        mov ax, 0
        mov es, ax
        mov word ptr es:[0*4], 200H
        mov word ptr es:[0*4 + 2], 0

        ; 触发除0异常
        mov ax, 100
        mov bx, 0
        div bx

        mov ax, 4c00H
        int 21H

    do0: 
        jmp short do0start
        db "overflow!"

    do0start:
        mov ax, cs
        mov ds, ax
        mov si, 202h

        mov ax, 0b800h
        mov es, ax
        mov di, 12 * 160 + 36 * 2

        mov cx, 9
        ; 颜色
        mov ah, 00100100B
    s:  mov al, [si]
        mov es:[di], ax     
        inc si
        add di, 2
        loop s

        mov ax, 4c00H
        int 21H
    do0end:
        nop
code ends

end start
assume cs:code

code segment
    start:
        ; 拷贝代码
        mov ax, cs
        mov ds, ax
        mov si, offset sqr
        mov ax, 0
        mov es, ax
        mov di, 200H
        mov cx, offset sqrend - sqr
        cld
        rep movsb

        ; 设置终端向量表
        mov ax, 0
        mov es, ax
        mov word ptr es:[7ch * 4], 200H
        mov word ptr es:[7ch * 4 + 2], 0

        ; 触发系统中断
        mov ax, 3456
        int 7ch
        add ax, ax
        adc dx, dx
        mov ax, 4c00H
        int 21H

    sqr:
        mul ax
        iret
    sqrend:
        nop
code ends

end start
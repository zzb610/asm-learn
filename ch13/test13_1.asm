assume cs:code

data segment
    db 'conversation', 0
data ends

code segment
    start:

        ; copy code
        mov ax, cs
        mov ds, ax
        mov si, offset jmp_near_ptr_s
        mov cx, offset jmp_near_ptr_s_end - offset jmp_near_ptr_s
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
        mov ax, 0b800H
        mov es, ax
        mov di, 12 * 160
    
        mov ah, 00100100B
    s:
        cmp byte ptr [si], 0
        je ok
        mov al, [si]
        mov es:[di], ax
        inc si
        add di, 2

        mov bx, offset s - offset ok
        int 7cH
    ok:
        mov ax, 4c00H
        int 21H
    
    jmp_near_ptr_s:
        push bp
        mov bp, sp
        add [bp + 2], bx
    jmp_ret:
        pop bp
        iret    
    jmp_near_ptr_s_end:
        nop
code ends

end start
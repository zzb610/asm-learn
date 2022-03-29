assume cs:code

stack segment
    db 128 dup (0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        ; copy new code to 0:204H
        push cs
        pop ds

        mov ax, 0
        mov es, ax

        mov si, offset int9
        mov di, 204H
        mov cx, offset int9end - offset int9
        cld
        rep movsb
        
        ; save old int 9 entry address in interrupt vector table
        ; to 0:200H(CS) 0:202H(IP)
        ; CS address
        push es:[9*4]
        pop es:[200H]
        ; IP
        push es:[9*4+2]
        pop es:[202H]

        ; set interrupt vector table
        cli
        mov word ptr es:[9*4], 204H
        mov word ptr es:[9*4+2], 0
        sti

        mov ax, 4c00H
        int 21H
    
    int9:
        push ax
        push es
        push bx
        push cx
        ; keyboard scan code
        in al, 60H

        ; push flag register
        pushf

        ; call old int9
        ; push old CS, IP set new CS, IP
        call dword ptr cs:[200H]

        ; cmp al, 1EH
        ; jne int9ret

        ; in al, 60H
        cmp al, 1EH + 80H
        jne int9ret

        mov ax, 0b800H
        mov es, ax
        mov bx, 0
        mov cx, 2000
       
    s:  mov byte ptr es:[bx], 'A'
        add bx, 2
        loop s

    int9ret:
        pop cx
        pop bx
        pop es
        pop ax
        iret
    int9end:
        nop

code ends

end start
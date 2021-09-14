assume cs:code, ds:data

data segment
    db "Beginner's All-purpose Symblic Instruction Code.", 0
data ends

code segment
    start:
        mov ax, data
        mov ds, ax

        mov si, 0
        call letterc

        mov ax, 4c00H
        int 21H

        letterc:
            push si
            push ax
            push cx

            sub ax, ax
            mov ch, 0
        s:
            mov cl, [si]
            jcxz ok
            mov al, cl
            cmp al, 61H
            jb next
            cmp al, 7bH
            ja next
            and al, 11011111B
            mov [si], al     
        next:
            inc si
            loop s
        ok:
            pop cx
            pop ax
            pop si
            ret
code ends

end start
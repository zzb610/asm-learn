assume cs:code, ds:data

data segment
    db 10 dup(10)
data ends

code segment
    start:
        mov ax, 12666
        mov bx, data
        mov ds, bx
        mov si, 0
        call dtoc

        mov dh, 8
        mov dl, 3
        mov cl, 2
        call show_str

        mov ax, 4c00H
        int 21H

    dtoc:
        push ax
        push cx
        push si
        push bx
        push dx
   
        mov dx, 0
        mov bx, 10
        mov ch, 0

    to_stack:    
        div bx ; (dx)=rem (ax)=int 
        mov cl, al
        
        add dx, 30H
        mov [si], dx
        push dx
        mov dx, 0
        inc si
        jcxz stack_to_mem
        jmp to_stack

    stack_to_mem:
        mov cx, si
        mov si, 0
    s:  pop ds:[si]
        inc si
        loop s
        pop dx
        pop bx
        pop si
        pop cx
        pop bx
        ret

   show_str:
    push ax
    push si
    push cx
    push es
    push cx
    push di
    push dx
    push bx
    
    mov ax, 0b800H
    mov es, ax

    mov al, 160
    mul dh
    mov bx, ax
    
    mov al, 2
    mul dl
    add ax, bx

    mov di, ax

    mov ah, cl
    mov ch, 0
    
    copy_display:
        mov cl, ds:[si]
        jcxz ok
        mov al, cl
        mov es:[di], ax
        inc si
        add di, 2
        jmp short copy_display

    ok:
        pop bx
        pop dx
        pop di
        pop cx
        pop es
        pop cx
        pop si
        pop ax
        ret
code ends

end start
assume cs:code, ds:data 

data segment
    db 'welcome to masm!', 0
data ends

code segment

start:
    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov ax, data
    mov ds, ax
    mov si, 0
    call show_str
    mov ax, 4c00H
    int 21H

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

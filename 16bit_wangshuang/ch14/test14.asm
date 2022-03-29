assume cs:code

code segment

start:
    mov si, 0
    ; year
    mov dl, 9
    call show_time
    mov al, '/'
    mov byte ptr es:[160*12 + 40*2 + 4 + si], al
    add si, 6
    ; month
    mov dl, 8
    call show_time
    mov al, '/'
    mov byte ptr es:[160*12 + 40*2 + 4 + si], al
    add si, 6
    ; day
    mov dl, 7
    call show_time
    mov al, '/'
    mov byte ptr es:[160*12 + 40*2 + 4 + si], al
    add si, 8

    ; hour
    mov dx, 4
    call show_time
    mov al, ':'
    mov byte ptr es:[160*12 + 40*2 + 4 + si], al
    add si, 6
    ; minute
    mov dx, 2
    call show_time
    mov al, ':'
    mov byte ptr es:[160*12 + 40*2 + 4 + si], al
    add si, 6
    ; second
    mov dx, 0
    call show_time

    mov ax, 4c00H
    int 21H

show_time:
    ; dl time location
    ; si display location
    push ax
    push bx
    push cx
    push dx
 

    mov al, dl
    out 70H, al
    in al, 71H

    mov ah, al
    mov cl, 4
    shr ah, cl
    and al, 00001111b

    add ah, 30H
    add al, 30H

    mov bx, 0b800H
    mov es, bx
    mov byte ptr es:[160*12 + 40*2 + si], ah
    mov byte ptr es:[160*12 + 40*2 + 2 + si], al
   
 
    pop dx
    pop cx
    pop ax
    pop bx
    ret


code ends

end start

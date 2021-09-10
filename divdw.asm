assume cs:code

code segment

start:
    mov ax, 4240H
    mov dx, 000fH
    mov cx, 0aH
    call divdw
    mov ax, 4c00H
    int 21H

divdw:
    ; input H in dx, L in ax, divisor in cx
    ; result H in dx, L in ax, rem in cx
 
    push bx

    ; int(H/N)
    push ax
    mov ax, dx
    mov dx, 0
    div cx ; (dx)=0 (ax)=H
    mov bx, ax ; save int(H/N) bx
    pop ax ; (ax)=L (dx)=rem(H/N)

    ; [rem(H/N)*65526 + L] / N
    div cx ; (ax)=[rem(H/N)*65526 + L]/N  (dx)=rem((ax)=[rem(H/N)*65526 + L]/N)

    mov cx, dx
    mov dx, bx

    pop bx
    ret
code ends

end start
assume cs:code, ds:data

data segment

    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1944', '1995'

    ; 
    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 11830000, 1843000, 2759000, 3753000, 4649000, 5937000 
    ;
    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800

data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

buffer segment
    db 31 dup(0)
buffer ends

code segment
    start:
        mov ax, data
        mov ds, ax
        mov ax, table
        mov es, ax
        call data_to_table

        mov ax, buffer
        mov ds, ax

        mov bx, 0
        mov cx, 21

        mov dh, 2
    show:
        mov dl, 0
        ; year
        mov ax, es:[0 + bx]
        mov ds:[0], ax
        mov ax, es:[2 + bx]
        mov ds:[2], ax
        mov ds:[4], 0
        push cx
        mov cl, 2
        call show_str
        pop cx

        ; income
        push dx
        mov ax, es:[5 + bx]
        mov dx, es:[7 + bx]
        call dtoc
        pop dx
        add dl, 5
        push cx
        mov cl, 2
        call show_str
        pop cx
        
        ; employee number
        push dx
        mov ax, es:[10 + bx]
        mov dx, 0
        call dtoc
        pop dx
        add dl, 10
        push cx
        mov cl, 2
        call show_str
        pop cx
        
        ; avg income
        push dx
        mov ax, es:[13 + bx]
        mov dx, 0
        call dtoc
        pop dx

        add dl, 10
        push cx
        mov cl, 2
        call show_str
        pop cx

        inc dh
        add bx, 16
        loop show
   

        mov ax, 4c00H
        int 21H
    
    data_to_table:
        push ax
        push bx
        push cx
        push si
        push di

        mov cx, 21
        mov bx, 0
        mov si, 0
        mov di, 0
    move_data:   
        ; year
        mov ax, ds:[0 + si]
        mov es:[bx + 0], ax
        mov ax, ds:[2 + si]
        mov es:[bx + 2], ax

        ; income
        mov ax, ds:[84 + si]
        mov es:[bx + 5], ax
        mov ax, ds:[86 + si]
        mov es:[bx + 7], ax
    

        ; employee number
        mov ax, ds:[168 + di]
        mov es:[bx + 10], ax
        
        ; avg income
        mov ax, ds:[84 + si]
        mov dx, ds:[86 + si]
        push bx
        mov bx, ds:[168 + di]
        div bx
        pop bx
        mov es:[bx + 13], ax

        add di, 2
        add si, 4
        add bx, 16
        loop move_data
        
        pop di
        pop si
        pop cx
        pop bx
        pop ax

        ret

    dtoc:
        ; input H in dx, L in ax
        push ax
        push cx
        push si
        push dx
        push bx
   
        mov ch, 0

    to_stack:    
        
        push cx
        mov cx, 10
        call divdw ; (dx)=H (ax)=L (cx)=rem
        add cx, 30H
        mov bx, cx ; save rem + 30H
        pop cx

        push bx
        mov cl, al
        inc si
        jcxz stack_to_mem
        jmp to_stack

    stack_to_mem:
        mov cx, si
        mov si, 0

    s:  pop ds:[si]
        inc si
        loop s

        pop bx
        pop dx
        pop si
        pop cx
        pop ax       
        ret

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

   show_str:
    push ax
    push si
   
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
        pop si
        pop ax
        ret
code ends

end start
assume cs:codesg, ds:data

data segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1944', '1995'

    ; 
    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 11830000, 1843000, 2759000, 3753000, 4649000, 5937000 
    ;
    dw 3, 7, 9, 13, 28, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800

data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

stacksg segment
    dw 8 dup (0)
stacksg ends

codesg segment
    start:
        mov ax, data
        mov ds, ax
        mov ax, table
        mov es, ax
        mov ax, stacksg
        mov ss, ax
        mov sp, 16

        mov cx, 21
        mov bx, 0
        mov si, 0
        mov di, 0
    s:   
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
        loop s 

    mov ax, 4c00h
    int 21h   
codesg ends

end start
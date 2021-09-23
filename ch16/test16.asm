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

        mov si, offset int7ch
        mov di, 204H
        mov cx, offset int7chend - offset int7ch
        cld
        rep movsb
        
        ; save old int7ch entry address in interrupt vector table
        ; to 0:200H(CS) 0:202H(IP)
        ; CS address
        push es:[7cH*4]
        pop es:[200H]
        ; IP
        push es:[7cH*4+2]
        pop es:[202H]

        ; set interrupt vector table
        cli
        mov word ptr es:[7cH*4], 204H
        mov word ptr es:[7cH*4+2], 0
        sti

        ; trigger 7ch
        mov ah, 0
        mov al, 4
        int 7cH
        mov ax, 4c00H
        int 21H

        org 204H
        ; table 的偏移地址是编译时计算出来的
        ; 我们把int7ch装载到0:204处, 我们期望table的偏移地址是cs:[206H]
        ; 但编译时 table计算的值是相对于 start的偏移
        ; 使用伪指令 org 204H 告诉编译器从204H 开始重新计算标号/偏移

int7ch:
    ; 2B
    jmp short set
    table dw sub1, sub2, sub3 , sub4
    set:
        push bx
       
        cmp ah, 3
        ja sret
       
        mov bl, ah
        mov bh, 0
        add bx, bx

       
        call word ptr table[bx] 

       
    sret:
     
        pop bx
        iret
sub1:
    push bx
    push es
    push cx
    mov bx, 0b800H
    mov es, bx
    mov bx, 0
    mov cx, 2000
sub1s:
    mov byte ptr es:[bx], ' '
    add bx, 2
    loop sub1s
    pop cx
    pop es
    pop bx
    ret

sub2:
    push bx
    push es
    push cx
    mov bx, 0b800H
    mov es, bx
    mov bx, 1
    mov cx, 2000
sub2s:
    and byte ptr es:[bx], 11111000B
    or es:[bx], al
    add bx, 2
    loop sub2s
    pop cx
    pop es
    pop bx
    ret

sub3:
    push cx
    push bx
    push es

    mov cl, 4
    shl al, cl
    mov bx, 0b800H
    mov es, bx
    mov bx, 1
    mov cx, 2000
sub3s:
    and byte ptr es:[bx], 10001111B
    or es:[bx], al
    add bx, 2
    loop sub3s

    pop es
    pop bx
    pop cx
    ret

sub4:
    push cx
    push si
    push es
    push ds
    push di

    mov si, 0b800H
    mov es, si
    mov ds, si
    mov si, 160
    mov di, 0
    cld
    mov cx, 24
sub4s:
    push cx
    mov cx, 160
    rep movsb
    pop cx
    loop sub4s
    mov cx, 80
    mov si, 0
sub4s1:
    mov byte ptr [160*24+si], ' '
    add si, 2
    loop sub4s1

    pop di
    pop ds
    pop es
    pop si
    pop cx
    ret

int7chend:
    nop

code ends

end start
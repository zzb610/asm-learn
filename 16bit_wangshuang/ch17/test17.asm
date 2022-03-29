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
        mov dx, 1439
        int 7ch
        
        org 204H
        ; table 的偏移地址是编译时计算出来的
        ; 我们把int7ch装载到0:204处, 我们期望table的偏移地址是cs:[206H]
        ; 但编译时 table计算的值是相对于 start的偏移
        ; 使用伪指令 org 204H 告诉编译器从204H 开始重新计算标号/偏移
int7ch:
    ; param
    ; dx 逻辑扇区号
    ; ah 传递功能号 0读 1写
    ; es:bx 指向读入写出的数据

    param segment
        dw 3 dup(0)
    param ends

    push ax
    push bx
    push si
    push ds
    push cx

    mov ax, param
    mov ds, ax

    mov si, 0

    ; 面号
    mov bx, 1440
    mov ax, dx
    mov dx, 0
    div bx ; int in ax, rem in dx
    mov word ptr [si], ax
    

    mov ax, dx
    mov bx, 18
    div bl ; int in al, rem in ah
    ; 磁道号
    mov byte ptr [si + 2], al
    mov byte ptr [si + 3], 0
    ; 扇区号
    add ah, 1
    mov byte ptr [si + 4], ah
    mov byte ptr [si + 5], 0

    pop cx
    pop ds
    pop si
    pop bx    
    pop ax

    mov si, 0
    ; 扇区数
    mov byte ptr al, 1
    ; 磁道号
    mov byte ptr ch, [si + 2]
    ; 扇区号
    mov byte ptr cl, [si + 4]
    ; 驱动器号
    mov dl, 0
    ; 面号
    mov byte ptr dh, [si]
    ; 功能号
    cmp ah, 0
    je read
    cmp ah, 1
    je write
    jmp int7chret
read:
    mov ah, 2
    int 13
    jmp int7chret
write:
    mov ah, 3
    int 13
int7chret:
    iret

int7chend:
    nop

code ends

end start
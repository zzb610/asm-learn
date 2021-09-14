data SEGMENT
    hello  DB 'Hello World!$' ;注意要以$结束
data ENDS
code SEGMENT
    ASSUME CS:CODE,DS:DATA
start:
    mov ax, 2;
    mov ax, ax;
    mov ax, ax;
    mov ax, ax
    int 21h      ;调用4C00h号功能，结束程序
code ENDS
END start
 
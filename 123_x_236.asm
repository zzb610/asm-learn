ASSUME cs:code

code SEGMENT
;     mov ax, 123
;     mov cx, 235
; s:  add ax, 123
;     loop s
;     mov ax, 4c00H
;     int 21H
    mov ax, 0
    mov cx, 123
s: add ax, 236
    loop s
add ax, ax
code ENDS

END
mov ax, 0x30
mov dx, 0xC0
add ax, dx

times 502 db 0

db 0x55 
db 0xAA
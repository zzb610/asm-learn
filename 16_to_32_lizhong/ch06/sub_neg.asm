jmp start

data1 db -1
data2 db -25

start:

  mov dx, 5

  neg dx

  mov dx, 5
  xor ax, ax
  sub ax, dx
  mov dx, ax

  jmp $

times (512-2-($-$$)) db 0

db 0x55, 0xaa

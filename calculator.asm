code segment:
  mov bx,0h
  mov ax,0h
  mov cx,0h
  mov dx,0h
  call read

letter_input:
  sub al,"A"
  add al, 10d
  jmp read_cont

pushvalue:
 cmp bx, 0h
 je read
 push bx
 mov bx,0h
 jmp read

addition:
  pop ax
  pop bx
  add ax,bx
  push ax
  mov bx, 0h
  jmp read

myret:
  ret

multiplication:
  mov dx,0h
  pop ax
  pop bx
  mul bx
  push ax
  mov bx, 0h
  jmp read

division:
  mov dx,0h
  pop bx
  pop ax
  div bx
  push ax
  mov bx, 0h
  jmp read

  read:
    mov ah,01h  ;
    int 21h     ; okudugumuz sayi AL'de
    cmp al,2Bh
    je addition
    cmp al,20h
    je pushvalue
    cmp al,0Dh  ;
    je print
    cmp al,2Ah  ;
    je multiplication
    cmp al,2Fh  ;
    je division
    cmp al,5Eh  ;
    je myxor
    cmp al,26h  ;
    je myand
    cmp al,7Ch  ;
    je myor
    cmp al,40h
    jg letter_input
    sub al,'0' ;
    jmp read_cont

  read_cont:
    mov cx,0h
    mov cl,al
    mov ax,10h ; bx okunan sayıyı biriktirdiğimiz yer
    mul bx   ;  al deki değer ile çarpıyor, ax'e yazıyor
    add cx,ax   ;
    mov bx,cx
    jmp read    ; bx önceden sıfırlanıyor.

myxor:
  pop ax
  pop bx
  xor ax,bx
  push ax
  mov bx, 0h
  jmp read

myand:
  pop ax
  pop bx
  and ax,bx
  push ax
  mov bx, 0h
  jmp read

myor:
  pop ax
  pop bx
  or ax,bx
  push ax
  mov bx, 0h
  jmp read

print:
  mov ah,02h
  mov dl, 10d
  int 21h
  pop ax
  mov bx,10h
  mov cx,0h
  mov dx,0h
  div bx
  push dx
  inc cx
  cmp ax,0h
  je print_finish
  mov dx,0h
  div bx
  push dx
  inc cx
  cmp ax,0h
  je print_finish
  mov dx,0h
  div bx
  push dx
  inc cx
  cmp ax,0h
  je print_finish
  push ax
  inc cx
  jmp print_finish


print_finish:
  mov ah,02h
  pop dx
  cmp dl,9h
  jg letter_output
  add dl, '0'
print_cont:
  int 21h
  dec cx
  jnz print_finish
  int 20h

letter_output:
  sub dl, 10d
  add dl, "A"
  jmp print_cont

code ends

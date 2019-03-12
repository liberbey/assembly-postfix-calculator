code segment:
  mov bx,0h
  mov ax,0h
  mov cx,0h
  mov dx,0h
  call read ;
  ;call print
  ;ad to stack one by one
  ;if seen any operation, go to operation
  ;do it again untill enter
  ;take last num from stack
  ;print it
  ;push 0010h
  ;push 1000h
  ;jmp addition

read:
  mov ah,01h  ;
  int 21h     ; okudugumuz sayi AL'de
  cmp al,2Bh
  je addition
  cmp al,20h
  je pushvalue
  cmp al,0Dh  ;
  je print
  sub al,'0'  ;
  mov cx,0h
  mov cl,al
  mov ax,10h ; bx okunan sayıyı biriktirdiğimiz yer
  mul bx   ;  al deki değer ile çarpıyor, ax'e yazıyor
  add cx,ax   ;
  mov bx,cx
  jmp read    ; bx önceden sıfırlanıyor.

pushvalue:
 push bx
 mov bx,0h
 jmp read

print:  ; top of stack ekrana yazdır.
  pop cx          ; cx = 5555
  mov ax, cx
  mov bx, 1000h
  div bx          ; ax = 0005,  dx = 0555
  mov cx, dx
  mov dl, al      ; ax = 0005,  dx = 0555
  add dl,'0'
  mov ah,02h
  int 21h

  mov dx,cx
  mov bx, 100h
  mov ax, dx
  mov dx, 0h      ; ax = 0555,  dx = 0000
  div bx          ;
  mov cx, dx
  mov dl, al
  add dl,'0'
  mov ah,02h
  int 21h

  mov dx,cx
  mov bx, 10h
  mov ax, dx
  mov dx, 0h      ; ax = 0555,  dx = 0000
  div bx          ;
  mov cx, dx
  mov dl, al
  add dl,'0'
  mov ah,02h
  int 21h

  mov dx,cx
  mov ax, dx     ;
  mov dl, al
  add dl,'0'
  mov ah,02h
  int 21h
  int 20h

addition:
  pop ax
  pop bx
  add ax,bx
  push ax
  jmp read

subtraction:   ; ax-bx => ax
  pop ax
  pop bx
  sub ax,bx
  push ax
  jmp myret


myret:
  ret
;multiplication:
;division:
;xor:
;and:
;or:
code ends

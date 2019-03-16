code segment:
  mov bx,0h
  mov ax,0h
  mov cx,0h
  mov dx,0h ; all registers are 0
  call read ; calls read

letter_input:
  sub al,"A"
  add al, 10d ; to convert the value
  jmp read_cont

pushvalue:
 cmp bx, 0h ; if the last input was an operation, go back to read
 je read
 push bx ; push the last given input to the stack
 mov bx,0h ; make bx 0, because it is used in taking input
 jmp read

addition:
  pop ax ; take the top of stack
  pop bx ; take the top of stack
  add ax,bx ; add them
  push ax ; push it to stack
  mov bx, 0h
  jmp read

myret: ; return label
  ret

multiplication:
  mov dx,0h ; make dx zero, just in case
  pop ax ; take the top of stack
  pop bx ; take the top of stack
  mul bx ; multiply them
  push ax ; push back to stack
  mov bx, 0h
  jmp read

division:
  mov dx,0h ; make dx zero, just in case
  pop bx ; take the top of stack
  pop ax ; take the top of stack
  div bx ; divide ax by bx
  push ax ; push the result to the stack
  mov bx, 0h
  jmp read

read:
  mov ah,01h  ; to take inpur
  int 21h     ; takes input
  cmp al,2Bh  ; compare with +
  je addition
  cmp al,20h  ; compare with ' '
  je pushvalue
  cmp al,0Dh  ; compare with enter
  je print
  cmp al,2Ah  ; compare with *
  je multiplication
  cmp al,2Fh  ; compare with /
  je division
  cmp al,5Eh  ; compare with ^
  je myxor
  cmp al,26h  ; compare with &
  je myand
  cmp al,7Ch  ; compare with |
  je myor
  cmp al,40h  ; compare with 40h to understand of the input is a letter or number
  jg letter_input
  sub al,'0'  ; if it is not a letter, subtract 0 to convert its value
  jmp read_cont

read_cont:
  mov cx,0h
  mov cl,al  ; put the input in cl
  mov ax,10h
  mul bx     ; if the given input is digit of a large number, multiply the first digits with 10h, if it is not the result will be 0
  add cx,ax  ; then add the input to the result of multiplication
  mov bx,cx  ; move the input to bx
  jmp read   ; back to read

myxor:
  pop ax ; take the top of stack
  pop bx ; take the top of stack
  xor ax,bx ; xor operation
  push ax ; push the result in stack
  mov bx, 0h
  jmp read

myand:
  pop ax ; take the top of stack
  pop bx ; take the top of stack
  and ax,bx ; and operation
  push ax ; push the result in stack
  mov bx, 0h
  jmp read

myor:
  pop ax ; take the top of stack
  pop bx ; take the top of stack
  or ax,bx ; or operation
  push ax ; push the result in stack
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

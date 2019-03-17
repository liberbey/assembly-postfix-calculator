# Postfix Assembly Calculator


The program takes postfix hexadecimal expressions and evaluates them. It is capable of doing mathematical operations such as addition, multiplication, integer division, bitwise xor, bitwise or and bitwise and. It is assumed that all input tokens are separated by a blank character, given expressions are true and all values and results are maximum 16 bit values.

## How to Use?

1. Run the program.
2. Write your postfix expression by the given rules and press enter.
3. Your result will be given in a new line.

## Implementation Details

### code segment

All register values are made 0, just in case. And then jumps to read (6).

### 1- letter_input: 

In case of letter input (A, B, C, D, E, F) this label is called. The integer value of letter input is calculated by its hex ascii value. Eventually it jumps to read_cont (7).

### 2- pushvalue

If the program takes space character as input, this label is jumped. First it checks whether the input is a operation or not. If so, it jumps back to read (6) label. If not, the value stored on bx register is pushed to the stack. Then bx is reset to 0h to make it ready for next input.

### 3- addition

If the program takes plus sign as input, this label is jumped in order to carry out addition. The first two top value on stack is popped to ax and bx registers. After addition, result is pushed to the stack again. Eventually, read (6) label is jumped.

### 4- multiplication

Just like addition, it pops the first two value on top of the stack, then multiplies them, eventually push the result to the stack again. After calculation, it jumps to read (6).

### 5- division

It pops the first two value on top of the stack, then it carries out integer division by dividing the second-popped by the first-popped. Eventually push the result to the stack again. After calculation, it jumps to read (6).

### 6- read

It carries out the reading part. the value taken is stored on al register. This value can be a decimal digit, a letter, an operation sign ( +, * , / , ^ , & , | ), space or enter. For each case, it jumps to different labels. At the end of the read label, read_cont (7) is jumped. read_cont is only used in case of a hexadecimal digit input. The reason why we have read_cont is that we have a different label for letter inputs. At the end of letter_input (1), read_cont is jumped. 

### 7- read_cont

Aim of this label is to store hexadecimal inputs on bx register. When a new digit is given, first it multiplies bx register with 10h, then it adds the new digit. Eventually, it stores the result on bx register and jumps back to read (6).

### 8- myxor

It pops the first two value on top of the stack, then it applies xor operation, eventually push the result to the stack again. After calculation, it jumps to read (6).

### 9- myand

It pops the first two value on top of the stack, then it applies and operation, eventually push the result to the stack again. After calculation, it jumps to read (6).

### 10- myor

It pops the first two value on top of the stack, then it applies or operation, eventually push the result to the stack again. After calculation, it jumps to read (6).

### 11- print

For printing, we divide the result to its digits and push them to stack one by one. In order to do that, it divides the result to 10d until the quotient is 0 and pushes the remainder -digit of the result- to the stack. If the quotient is zero, it jumps to print_finish(12).

### 12- print_finish

When print (11) pushes the all digits of the result to the stack, this label is jumped. First it pops the first digit of the result, then it does comparison. In case of a letter input, it jumps to letter_output (14). 

### 13- print_cont

This label prints a digit of the result. In this label, we decrement the cx register. When cx stores 0h on it, the program is finished by int 20h call. Otherwise, it jumps back to print_finish (12) and printing action continues.

### 14- letter_output

In case of letter input (A, B, C, D, E, F) this label is called. The integer value of letter input is calculated by its hex ascii value. Eventually it jumps to print_cont(7).
code ends

/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cmp R2,#0
    beq 0f 
1:  subs R2,#1
    ldrb R3,[R0,R2]
    strb R3,[R1,R2]
    bne 1b
0:  bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    cmp R2,#0
    beq 0f 
    movs R12,#0
1:  
    ldrb R3,[R0],#1
    strb R3,[R1],#1
    cmp  R3,#0
    beq  0f
    adds R12,#1
    cmp  R2,R12
    bne 1b
0:  movs R3,#0
    strb R3,[R1,#-1]
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun minusculaEnLugar

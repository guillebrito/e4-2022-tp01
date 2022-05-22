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
    movs R3,#0
    strb R3,[R1,#-1]
0:  bx lr
endfun copiaCadena



defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1,#0
    beq 0f 
    movs R2,#0
1:  
    ldrb R3,[R0]
    cmp  R3,0x60        // 60<minusculas<7B --> ubicacion de las min. en codigo ascii hexa
    bls  2f             // resto 0x20 y obtengo la misma letra pero en mayus
    cmp  R3,0x7B
    bcs  2f
    subs R3,0x20
2:  strb R3,[R0],#1
    cmp  R3,#0
    beq  0f
    adds R2,#1
    cmp  R1,R2
    bne 1b
0:  bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1,#0
    beq 0f 
    movs R2,#0
1:  
    ldrb R3,[R0]
    cmp  R3,0x5B                
    bcs  2f             //Si 0x40<R3<0x5B --> ubicacion de las mayus en codigo ascii hexa
    cmp  R3,0x40        //sumo 0x20 para obtener su minuscula
    bls  2f              
    adds R3,0x20
2:  strb R3,[R0],#1
    cmp  R3,#0
    beq  0f
    adds R2,#1
    cmp  R1,R2
    bne 1b
0:  bx lr
endfun minusculaEnLugar

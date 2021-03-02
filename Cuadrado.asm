; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; CUADRADO

org 100h

DATA SEGMENT
    CONTAR EQU 100
    NUM DB ?
    NUM1 DW ?
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

INICIO:
    
    MOV AX,0012H  ;MODO GRAFICO
    INT 10H

    MOV NUM,40
    MOV NUM1,42
    
    MOV CL,NUM
    
    MOV DX,NUM1
    
REG: INC CX
     CALL COLOR    
     CMP CX,CONTAR
     JE  LADO
     JMP REG

LADO: INC DX    
      MOV CL,NUM
      CALL COLOR
      CMP DX,82
      JE LADO1
      JMP LADO
      
LADO1: INC CX
       CALL COLOR
       CMP CX,CONTAR
       JE  LADO2
       JMP LADO1
       
LADO2: DEC DX      
       CALL COLOR
       CMP DL,NUM
       JE FIN
       JMP LADO2
     
COLOR: MOV AH,0CH     
       MOV AL,09
       INT 10H
       RET
     
FIN:MOV AH,07     
    INT 21H 
     
END INICIO     
     
CODE ENDS     
     
ret
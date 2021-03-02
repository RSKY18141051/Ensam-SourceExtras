; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; UMBRELA CORP. LOGO

org 100h 

H DW ?
L DW ?
C DW ? 

CODIGO: 

ASSUME CS:CODIGO,DS:DATA


PINTAR MACRO COLOR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AL,COLOR
    MOV AH,0CH
    INT 10H
    
    POP DX
    POP CX
    POP BX
    POP AX

ENDM

TRIANGULO1 MACRO LADO,X,Y,COLOR
    LOCAL S,S1,FIN,INICIO
    
    ;h^2=(3*LADO^2)/4
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV L, LADO
INICIO:    
    MOV AX,L
    MUL AX       ;L^2
    MOV BX,3
    MUL BX       ;GUARDA AX, 3*L^2
    MOV BX,4
    DIV BX       ;GUARDA AX, (3*L^2)/4
    MOV H,AX
    
    MOV AX,L
    MOV BX,2
    MOV DX,0
    DIV BX       ;GUARDA AX, L/2
    MOV BX,X
    ADD AX,BX    ;GUARDA AX, X+L/2
    
    MOV CX,AX
    MOV DX,Y
    
S1: PINTAR COLOR
    PUSH CX
    ADD CX,C
    PINTAR COLOR
    POP CX
    
    DEC DX
    
    PUSH DX
    
    MOV AX,Y
    SUB AX,DX
    MUL AX
    
    POP DX
    
    CMP AX,H
    JGE S
    JMP S1
    
S:
    MOV AX,C
    MOV BX,2
    ADD AX,BX
    MOV C,AX
    
    DEC CX
    
    MOV AX,L
    MOV BX,2
    SUB AX,BX
    MOV L,AX
    CMP L,1
    JLE FIN
    JMP INICIO
    
FIN:     
    POP DX
    POP CX
    POP BX
    POP AX
    
    
ENDM 

TRIANGULO2 MACRO LADO,X,Y,COLOR
    LOCAL S,S1,FIN,INICIO
    
    ;h^2=(3*LADO^2)/4
    MOV LADO,0
    MOV L,0
    MOV AX,0
    MOV BX,0
    MOV CX,0
    MOV DX,0
        
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV L, LADO
INICIO:    
    MOV AX,L
    MUL AX       ;L^2
    MOV BX,3
    MUL BX       ;GUARDA AX, 3*L^2
    MOV BX,4
    DIV BX       ;GUARDA AX, (3*L^2)/4
    MOV H,AX
    
    MOV AX,L
    MOV BX,2
    MOV DX,0
    DIV BX       ;GUARDA AX, L/2
    MOV BX,X
    ADD AX,BX    ;GUARDA AX, X+L/2
    
    MOV CX,AX
    MOV DX,Y
    
S1: PINTAR COLOR
    PUSH CX
    ADD CX,C
    PINTAR COLOR
    POP CX
    
    DEC DX
    
    PUSH DX
    
    MOV AX,Y
    SUB AX,DX
    MUL AX
    
    POP DX
    
    CMP AX,H
    JGE S
    JMP S1
    
S:
    MOV AX,C
    MOV BX,2
    ADD AX,BX
    MOV C,AX
    
    DEC CX
    
    MOV AX,L
    MOV BX,2
    SUB AX,BX
    MOV L,AX
    CMP L,1
    JLE FIN
    JMP INICIO
    
FIN:     
    POP DX
    POP CX
    POP BX
    POP AX
    
    
ENDM 
      
.CODE   
INI:   
   MOV AX,013H         ;13H O TBM 12H MODO GRAFICO 320x200 pixeles
   INT 10H
   
   TRIANGULO1 26,60,50,08H
   TRIANGULO2 20,120,50,08H 
   
FIN:
   MOV AX,4C00H
   INT 21H
   
END INI   

ret
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; TRIANGULO

org 100h

jmp code
               ;variables a usar
fila dw ?
columna dw ?
base dw ?
altura dw ?   

code:
    mov ax,013h
    int 10h
        
    mov fila,10     ;Coordenada en (x)
    mov columna,10  ;Coordenada en (y)
    mov base,50     ;anchura de la base = 50 pixeles
    mov altura,35   ;altura maxima = 35 pixeles
    
    mov cx,columna  ;Movemos la variable columna a el registro CX
    mov bx,base     ;Movemos la variable base a BX
    add bx,cx       ;las sumamos
    
    mov base,bx     ;Movemos el registro BX a la variable base
    mov dx,fila     ;movemos la variable fila al registro DX
    
;----ZONA DE DIBUJO-----;
ANCHURA:
    call COLOR      ;Llamamos al metodo COLOR
    inc cx          ;incrementamos CX
    cmp cx,base     ;Comparamos con la base
    je ALTO         ;Si es igual pasamos al metodo ALTO
    jmp ANCHURA

ALTO:
    inc dx          ;incrementamos DX
    cmp dx,ALTURA   ;Comparamos con la altura
    je fin          ;Si es igual pasamos al metodo FIN

    add columna,1   ;Se le suma 1 a las coordenadas en (y)
    mov cx,columna  ;Se mueve columna al registro cx
    sub base,1      ;Se le resta 1 a las coordenadas en (x)
    jmp ANCHURA

COLOR:
    mov ah,0ch  ;Escribir un punto o pixel grafico
    mov al,15   ;Color blanco
    int 10h

    ret

fin:
    mov ah,07h  ;entrada de caracteres sin eco en AL.si no hay ningún carácter en el bufer del teclado, la funcion espera hasta que se presione cualquier tecla.
    int 21h
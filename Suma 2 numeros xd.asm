
; You may customize this and other start-up templates; 
; Suma

org 100h

mov ah, 01h ;lee caracter del teclado 
int 21h

mov bl, al  ;guardo caracter

mov dl, 2bh
mov ah, 02h ;imprime signo +
int 21h

mov ah, 01h ;lee caracter del teclado
int 21h

add al, bl ;al=al+bl

mov bl, 30h ;bl=30h
sub al, bl ;al=al-30h

mov bl, al
mov al, 3dh ;imprime sigono =

mov dl, al ;salida estandar
mov ah, 02h
int 21h

mov al, bl

mov dl, al
int 21h

ret





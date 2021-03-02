; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

name "bancos"
include "macros_ex.inc"
org 100h

jmp start

rutae db "c:\empresa.txt",0   ;ruta del archivo de texto empresa
handle dw ?

auxc db 35 dup(?)             ;variable auxiliar de clientes 

cliente1 db 15 dup(?)       ;cliente1 del txt
cliente2 db 15 dup(?)       ;cliente2 del txt
cliente3 db 15 dup(?)       ;cliente3 del txt
cliente4 db 15 dup(?)       ;cliente4 del txt
cliente5 db 15 dup(?)       ;cliente5 del txt
   
start:
    mov ax, cs
    mov dx, ax
    mov es, ax
    
    ;se posiciona al inicio de cliente
    lea si,usuario
    ;pide usuario 
    imprime input1
    
lee_usuario:
    ;guarda lo ingresado por teclado en la variable usuario
    call leec
    
    cmp al,0dh
    je guarda_usuarios
    
    mov byte ptr [si],al
    inc si
    
    jmp lee_usuario
    
;-------------------------------------GUARDA USUARIOS---------------------------------    
guarda_usuarios:
    ;mueve un 24h = $ a la ultima posicion de la variable usuario
    mov byte ptr [si],24h
    
    ;abre el archivo de texto de usuarios
    lea dx,rutau            ;ruta del archivo
    mov ah,3dh              ;servicio
    mov al,00h              ;codigo de acceso
    int 21h         
    
    jc error                ;si ocurre algun error salta a la etiqueta error
    
    mov handle,ax           ;mueve ax al handle
    lea si,usuario1         ;se posiciona al inicio de usuario1
    
    ;lee desde el archivo
    mov ah,3fh              ;servicio
    mov bx,handle           ;mueve el handle a bx
    mov cx,50               ;numero de caracteres a leer
    lea dx,auxu             ;variable auxiliar donde se guardara el contenido del archivo
    int 21h
    
    ;cierra archivo
    mov ah,3eh              ;servicio
    mov bx,handle           ;mueve el handle a bx
    int 21h
    
    lea di,auxu             ;se posiciona al inicio de auxu
    
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx
    
    
;guarda el primer usuario
guarda_usuario1:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxu
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_u1          ;si es igual salta a continua_u1
     
    mov [si],bl             ;mueve a [si] (posicion de usuario1) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_usuario1     ;salta para guardar el sig caracter 
    
continua_u1:
    inc di                  ;auxu se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de usuario1
    lea si,usuario2         ;se posiciona al inicio de usuario2

;guarda el segundo usuario
guarda_usuario2:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxu
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_u2          ;si es igual salta a continua_u2
     
    mov [si],bl             ;mueve a [si] (posicion de usuario2) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_usuario2     ;salta para guardar el sig caracter 
    
continua_u2:
    inc di                  ;auxu se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de usuario2
    lea si,usuario3         ;se posiciona al inicio de usuario3 
    
;guarda el tercer usuario
guarda_usuario3:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxu
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_u3          ;si es igual salta a continua_u3
     
    mov [si],bl             ;mueve a [si] (posicion de usuario3) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_usuario3     ;salta para guardar el sig caracter 
    
continua_u3:
    inc di                  ;auxu se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de usuario3
    lea si,usuario4         ;se posiciona al inicio de usuario4

;guarda el cuarto usuario
guarda_usuario4:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxu
    cmp bl,000              ;compara si es un 0dh = carryreturn
    je continua_u4          ;si es igual salta a continua_u4
     
    mov [si],bl             ;mueve a [si] (posicion de usuario4) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_usuario4     ;salta para guardar el sig caracter 
    
continua_u4:
    inc di                  ;auxu se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de usuario4    
    
;----------------------------------GUARDA CLAVES-----------------------------------
guarda_claves:
    ;abre el archivo de texto de usuarios
    lea dx,rutac            ;ruta del archivo
    mov ah,3dh              ;servicio
    mov al,00h              ;codigo de acceso
    int 21h         
    
    jc error                ;si ocurre algun error salta a la etiqueta error
    
    mov handle,ax           ;mueve ax al handle
    lea si,clave1           ;se posiciona al inicio de clave1
    
    ;lee desde el archivo
    mov ah,3fh              ;servicio
    mov bx,handle           ;mueve el handle a bx
    mov cx,50               ;numero de caracteres a leer
    lea dx,auxc             ;variable auxiliar donde se guardara el contenido del archivo
    int 21h
    
    ;cierra archivo
    mov ah,3eh              ;servicio
    mov bx,handle           ;mueve el handle a bx
    int 21h
    
    lea di,auxc             ;se posiciona al inicio de auxc
    
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx
    
;guarda la primer clave
guarda_clave1:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxc
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_c1          ;si es igual salta a continua_c1
     
    mov [si],bl             ;mueve a [si] (posicion de clave1) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_clave1       ;salta para guardar el sig caracter 
    
continua_c1:
    inc di                  ;auxc se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de clave1
    lea si,clave2           ;se posiciona al inicio de clave2
    
;guarda la segunda clave
guarda_clave2:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxc
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_c2          ;si es igual salta a continua_c2
     
    mov [si],bl             ;mueve a [si] (posicion de clave2) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_clave2       ;salta para guardar el sig caracter 
    
continua_c2:
    inc di                  ;auxc se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de clave2
    lea si,clave3           ;se posiciona al inicio de clave3

;guarda la tercer clave
guarda_clave3:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxc
    cmp bl,0dh              ;compara si es un 0dh = carryreturn
    je continua_c3          ;si es igual salta a continua_c3
     
    mov [si],bl             ;mueve a [si] (posicion de clave3) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_clave3       ;salta para guardar el sig caracter 
    
continua_c3:
    inc di                  ;auxc se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de clave3
    lea si,clave4           ;se posiciona al inicio de clave4 

;guarda la cuarta clave
guarda_clave4:
    mov bl,[di]             ;mueve a bl lo que hay en [di], posicion de auxc
    cmp bl,000              ;compara si es un 0dh = carryreturn
    je continua_c4          ;si es igual salta a continua_c3
     
    mov [si],bl             ;mueve a [si] (posicion de clave3) lo que hay en bl
                        
    inc di                  ;incrementa a la siguiente posicio
    inc si                  ;en ambas cadenas
    
    jmp guarda_clave4       ;salta para guardar el sig caracter 
    
continua_c4:
    inc di                  ;auxc se incrementa en dos posiciones para pasar al siguiente
    inc di                  ;usuario saltandose 0dh y 0ah que es la nueva linea
    mov byte ptr [si],24h   ;mueve un 24h = $ a la ultima posicion de clave3
    
    jmp compara_usuario1
    
;------------------------------------COMPARA LOS USUARIOS-------------------------------------    
compara_usuario1:    
    lea si,usuario1         ;se posiciona al inicio de la variable usuario1
    lea di,usuario          ;se posiciona al inicio de la variable usuario (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si el usuario ingresado por teclado es igual al primer usuario     
usuario_1:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de usuario1
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de usuario
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_usuario2    ;si son distintas salta a comparar el siguiente usuario 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je pide_clave           ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je usuario_1            ;si son iguales salta a usuario_1

compara_usuario2:    
    lea si,usuario2         ;se posiciona al inicio de la variable usuario2
    lea di,usuario          ;se posiciona al inicio de la variable usuario (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si el usuario ingresado por teclado es igual al primer usuario     
usuario_2:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de usuario2
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de usuario
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_usuario3    ;si son distintas salta a comparar el siguiente usuario 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je pide_clave           ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je usuario_2            ;si son iguales salta a usuari_2

compara_usuario3:    
    lea si,usuario3         ;se posiciona al inicio de la variable usuario3
    lea di,usuario          ;se posiciona al inicio de la variable usuario (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si el usuario ingresado por teclado es igual al primer usuario     
usuario_3:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de usuario3
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de usuario
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_usuario4    ;si son distintas salta a comparar el siguiente usuario 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je pide_clave           ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je usuario_3            ;si son iguales salta a usuario_3

compara_usuario4:
    lea si,usuario4         ;se posiciona al inicio de la variable usuario4
    lea di,usuario          ;se posiciona al inicio de la variable usuario (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si el usuario ingresado por teclado es igual al primer usuario     
usuario_4:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de usuario4
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de usuario
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne inexistente         ;si son distintas salta a inexistente 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je pide_clave           ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je usuario_4            ;si son iguales salta a usuario_4
    

;------------------------------------------------------------------------------------------
pide_clave:
    ;se posiciona al inicio de clave
    lea si,clave 
    ;nueva linea
    imprimec 13
    imprimec 10
    ;pide usuario 
    imprime input2
    
lee_clave:
    ;guarda lo ingresado por teclado en la variable usuario
    call leec
    
    cmp al,0dh
    je compara_clave1
    
    mov byte ptr [si],al
    inc si
    
    jmp lee_clave            

;------------------------------------COMPARA LOS CLAVES-------------------------------------

compara_clave1:
    mov byte ptr [si],24h   
    lea si,clave1           ;se posiciona al inicio de la variable clave1
    lea di,clave            ;se posiciona al inicio de la variable clave (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si la clave ingresada por teclado es igual a la primer clave     
clave_1:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de clave1
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de clave
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_clave2      ;si son distintas salta a comparar la siguiente clave 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je ingresa              ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je clave_1              ;si son iguales salta a clave_1 

compara_clave2:
    mov byte ptr [si],24h   
    lea si,clave2           ;se posiciona al inicio de la variable clave2
    lea di,clave            ;se posiciona al inicio de la variable clave (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si la clave ingresada por teclado es igual a la segunda clave     
clave_2:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de clave2
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de clave
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_clave3      ;si son distintas salta a comparar la siguiente clave 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je ingresa              ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je clave_2              ;si son iguales salta a clave_2     

compara_clave3:
    mov byte ptr [si],24h   
    lea si,clave3           ;se posiciona al inicio de la variable clave3
    lea di,clave            ;se posiciona al inicio de la variable clave (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si la clave ingresada por teclado es igual a la segunda clave     
clave_3:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de clave3
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de clave
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne compara_clave4      ;si son distintas salta a comparar la siguiente clave 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je ingresa              ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je clave_3              ;si son iguales salta a clave_3

compara_clave4:
    mov byte ptr [si],24h   
    lea si,clave4           ;se posiciona al inicio de la variable clave4
    lea di,clave            ;se posiciona al inicio de la variable clave (ingresado por teclado)
    mov bx,0                ;mueve un cero a bx
    mov cx,0                ;mueve un cero a cx

;compara si la clave ingresada por teclado es igual a la segunda clave     
clave_4:
    mov bl,[si]             ;mueve a bl lo que hay en la primer posicion de clave4
    mov cl,[di]             ;mueve a cl lo que hay en la primer posicion de clave
    
    inc si                  ;incrementa las posiciones
    inc di                  ;en ambas cadenas
    
    cmp bl,cl               ;compara si bl y cl son iguales
    jne incorrecta          ;si son distintas salta a comparar la siguiente clave 
    
    cmp bl,24h              ;compara si bl es igual a 24h = $ (aqui se puede comparar tanto bl como cl)
    je ingresa              ;si si es igual salta a pedir la clave
    
    cmp bl,cl               ;compara nuevamente bl con cl 
    je clave_4              ;si son iguales salta a clave_4


error:
    nop
    jmp fin
            
fin:    
    mov ah,00               
    int 20h 
ret    

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; Suma de 2 nums con 3 digitos

include 'emu8086.inc'  ;Libreria para usar scan num y print num

org 100h

jmp inicio_1

    vec1 dw ?,?,?
    vec2 dw ?,?,?
    vec3 dw ?,?,?
    num  dw ?

inicio_1:

    mov cx,3    ;Tamano max del "contador"
    mov si,0
    mov num,0   ;posicion de "contador"
    
    printn "Elementos en posicion 0 --> unidades"
    printn "Elementos en posicion 1 --> decenas"
    printn "Elementos en posicion 2 --> centenas"
    
cap_vec1:       ;captura de elementos de vector 1

    printn " "
    push cx
    print  ' v1 elem ['
    mov ax,num
    call print_num      ;imprime posicion de num
    print '] --> '
    call scan_num       ;checa la posicion de "contador"
    mov vec1[si],cx
    inc num             ;incrementamos tamano
    add si,2
    pop cx              ;regresa el valor a cx despues del push
    loop cap_vec1
    

inicio_2:

    mov cx,3    ;Tamano de "contador"
    mov si,0
    mov num,0   ;posicion de "contador"
    printn " "
    
cap_vec2:       ;captura de elementos de vector 2

    printn " "
    push cx
    printn ' '
    print  ' v2 elem ['
    mov ax,num
    call print_num      ;imprime posicion de num
    print '] --> '
    call scan_num       ;checa la posicion de "contador"
    mov vec2[si],cx
    inc num             ;incrementamos tamano
    add si,2            
    pop cx              ;regresa el valor a cx despues del push
    loop cap_vec2

inicio_3:

    mov cx,3
    mov si,0
    
cap_vec3:      ;captura de la suma en vector 3

    push cx
    xor  ax,ax          ;regresa a su valor original
    xor  bx,bx          ;regresa a su valor original
    mov  ax,vec1[si]    ;asignamos el primer valor del vector1 a ax
    mov  bx,vec2[si]    ;asignamos el primer valor del vector2 a bx
    add  ax,bx          ;suma ax=ax+bx
    mov  vec3[si],ax    ;metemos ax en una posicion del vector3
    add  si,2
    pop  cx             ;regresa a su valor cx despues de push
    loop cap_vec3

inicio_4:

    printn " "
    printn ' '
    printn ' Resultado de suma'
    printn ' '
    mov cx,3
    mov si,0
    mov num,0
    
cap_vec4:
    printn " "
    push cx
    print ' resul ['
    mov ax,num         ;pasamos el "contador" a ax
    call print_num     ;imprime la posicion de "contador"
    print '] --> '
    mov  ax,vec3[si]   ;pasamos el valor de una posicion de vector3 a ax
    call print_num
    inc num            ;incrementa "contador"
    add  si,2
    pop  cx            ;regresa a su valor cx despues de push
    loop cap_vec4

final:                 ;ciclo para fin automatico
    printn " "
    printn " Terminado..."
    printn ' '
    mov cx,0feh
    salida:
        nop
    loop salida
ret
    define_scan_num      ;comandos de la libreria
    define_print_num
    define_print_num_uns
end

ret
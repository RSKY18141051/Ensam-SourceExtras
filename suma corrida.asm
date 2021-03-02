
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt 
; suma de 2 numeros enteros con 3 digitos

include "emu8086.inc"
org 100h

.data
suma db 2 dup (?)
.code
sumas proc
    print " 1er Numero: "
    call scan_num
    mov suma[0],cl 
    printn " " 
    print " 2do Numero: "
    call scan_num
    mov suma[1],cl
    xor ax,ax
    add al,suma[0]
    add al,suma[1]
    printn " "
    print " Suma: "
    call print_num
sumas endp
exit:
    print " "
    printn " "
    print "Presiona enter..."
    mov ah,0  ;servicio de pulsación de teclado
    int 16h   ;invoca a servicios de taclado
    ret
define_print_string
define_print_num
define_print_num_uns
define_scan_num
end

ret





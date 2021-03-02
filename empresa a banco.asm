; Equipo 2 Kevin Ruiz, Luis Malagon
; Empresa -----> Bancos
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

name "bancos"

org 100h

jmp start

doc1 db "c:\empresa.txt",0   ;ruta del archivo de texto empresa
doc2 db "c:\bancos.txt",0
handle dw ?
auxc db 35 dup(?)             ;variable auxiliar de clientes 

cliente1 db 48 dup(?)       ;cliente1 del txt
cliente2 db 61 dup(?)       ;cliente2 del txt
cliente3 db 61 dup(?)       ;cliente3 del txt
cliente4 db 61 dup(?)       ;cliente4 del txt
cliente5 db 61 dup(?)       ;cliente5 del txt

text1 db "CLIENTE           CUENTA         TIPO     SALDO", 0dh, 0ah
text2 db "JUAN PEREZ        000002345121   XA1      $34,502.00", 0dh, 0ah
text3 db "ANTONIO LOPEZ     000222124545   XB2      $3,453.00", 0dh, 0ah
text4 db "ALBERTO CORTEZ    01234561-323   EX3      $56,356,642.00", 0dh, 0ah
text5 db "ANA BOBANA        000002343211   XA1      $23,423,424.00", 0dh, 0ah

text1_size = $ - offset text1
text2_size = $ - offset text2
text3_size = $ - offset text3
text4_size = $ - offset text4
text5_size = $ - offset text5
   
start:
    mov ax, cs
    mov dx, ax
    mov es, ax

;abre archivo
mov ah, 3ch
mov cx, 0
mov dx, offset doc1
int 21h
jc error
mov handle, ax

;sobre esribir
mov ah, 40h
mov bx, handle
mov dx, offset text1
mov cx, text1_size
int 21h
mov ah, 40h
mov bx, handle
mov dx, offset text2
mov cx, text2_size
int 21h     

; close c:\emu8086\vdrive\C\empresa.txt
mov ah, 3eh
mov bx, handle
int 21h

; rename fileL c:\emu8086\vdrive\C\empresa.txt to c:\bancos.txt
mov ah, 56h
mov dx, offset doc1   ; existing.
mov di, offset doc2   ; new.
int 21h

error:
    nop
    jmp fin
            
fin:    
    mov ah,00               
    int 20h 
ret     
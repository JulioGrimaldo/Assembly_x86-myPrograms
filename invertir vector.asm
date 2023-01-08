.MODEL SMALL   

.STACK

.DATA   
arreglo  db 1,2,3,4,5,6,7,9,8,7,4,1,24,5
arreglo2 db 15 DUP(?)  

.CODE
inicio:
    MOV AX,@DATA
    MOV DS,AX  
    
    
    
    MOV CX, 0fh
    MOV SI, 0Dh  
    repetir:
    MOV AL, arreglo[SI]
    MOV arreglo2[DI],AL
    DEC SI
    INC DI  
    CMP cx,0
    loop repetir
      MOV AH,4Ch
    INT 21h 
END inicio
END





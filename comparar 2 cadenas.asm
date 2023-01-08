.MODEL SMALL   

.STACK

.DATA
  BUF DB 25,?,25 DUP(?)
  BUF2 DB 25,?,25 DUP(?) 
  PRIMER DB "Primer numero ",10h,13h, '$'
  SEGUNDO DB "Segundo numero",10h,13h, '$'
  MSG DB "IGUALES$" 
  MSG2 DB "NO IGUALES$"
  SALTO DB 10,13
.CODE
inicio:
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH, 09h
    MOV DX, offset PRIMER
    int 21h
    MOV AH, 0Ah
    MOV DX, Offset BUF
    INT 21h  
    
    
    MOV AH, 09h
    MOV DX, offset SEGUNDO
    int 21h  
    MOV AH, 0Ah
    MOV DX, Offset BUF2 
    INT 21h  
    
    MOV CX, 19h
    MOV SI, 02h 
    repetir: 
    MOV AL,BUF[SI]
    MOV AH,BUF2[SI] 
    INC SI  
    
    CMP AL,AH   
    JNE noesigual
     
    CMP cx,3
    JE esigual
    
    loop repetir  
    
    esigual:
    MOV AH, 09h
    MOV DX, offset MSG
    int 21h 
    JMP salir   
    
    noesigual:
    MOV AH, 09h
    MOV DX, offset MSG2
    int 21h
    JMP salir
    
    salir:
    MOV AH,4Ch
    INT 21h
END inicio
END






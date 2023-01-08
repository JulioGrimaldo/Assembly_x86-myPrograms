IMPRIMIR MACRO t
    MOV AH, 09h
    MOV DX, offset t;Imprime texto en consola  
    int 21h
    XOR AX,AX
    XOR DX,DX  
endm
.MODEL SMALL   

.STACK

.DATA
  BUFMIN DB 8,?,8 DUP(?)
  BUFMAY DB 8,?,8 DUP(?)  
  BUFPALABRA DB 50,?,50 DUP(?)
  Palabra DB "Ingrese la palabra ",10,13, '$' 
  AUX DB ?,'$'
  LA DB "A: $"
  LAM DB "a: $"
  LE DB "E: $"
  LEM DB "e: $"
  LI DB "I: $"
  LIM DB "i: $"
  LO DB "O: $"
  LOM DB "o: $"
  LU DB "U: $"
  LUM DB "u: $"  
  MAYUS DB "MAYUSCULAS",'$' 
  MINUS DB "MINUSCULAS",'$'
  SUMA DB "SUMA: $"
  RES DB ?,'$'
  
  
  SALTO DB " ",10,13, '$'
  
.CODE
inicio:
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH, 09h
    MOV DX, offset Palabra;Imprime texto en consola
    int 21h
    MOV AH, 0Ah ;Texto por teclado a buffer 
    MOV DX, Offset BUFPALABRA
    INT 21h  
    MOV SI, 01h
    
    XOR cx,cx 
    MOV CL, BUFPALABRA[SI]  ;Num Posiciones del vector
    MOV SI, 02h ;Controlara la palabra
    regresar:  
    repetir: 
    MOV AL,BUFPALABRA[SI]
    CMP AL, 'A'
    JE A
    CMP AL, 'a'
    JE amin 
    CMP AL, 'E'
    JE E
    CMP AL, 'e'
    JE emin  
    CMP AL, 'I'
    JE I
    CMP AL, 'i'
    JE imin
    CMP AL, 'O'
    JE O 
    CMP AL,'o'
    JE omin
    CMP AL,'U'
    JE U
    CMP AL, 'u'
    je umin
     
    INC SI  
    CMP cx,3
    je IMPRIMIRRES
    loop repetir  
    
    A:            
    MOV DI,02h
    MOV AH,BUFMAY[DI]
    INC AH
    MOV BUFMAY[DI],AH 
    INC SI 
    JMP regresar 
     
    amin:            
    MOV DI,02h
    MOV AH,BUFMIN[DI]
    INC AH
    MOV BUFMIN[DI],AH 
    INC SI 
    JMP regresar  
    
    E:
    MOV DI,03h
    MOV AH,BUFMAY[DI]
    INC AH
    MOV BUFMAY[DI],AH 
    INC SI 
    JMP regresar 
     
    emin:
    MOV DI,03h
    MOV AH,BUFMIN[DI]
    INC AH
    MOV BUFMIN[DI],AH 
    INC SI 
    JMP regresar 
    
    I:
    MOV DI,04h
    MOV AH,BUFMAY[DI]
    INC AH
    MOV BUFMAY[DI],AH 
    INC SI 
    JMP regresar
    
    imin:
    MOV DI,04h
    MOV AH,BUFMIN[DI]
    INC AH
    MOV BUFMIN[DI],AH 
    INC SI 
    JMP regresar 
     
    O:
    MOV DI,05h
    MOV AH,BUFMAY[DI]
    INC AH
    MOV BUFMAY[DI],AH 
    INC SI  
    JMP regresar
    
    omin:
    MOV DI,05h
    MOV AH,BUFMIN[DI]
    INC AH
    MOV BUFMIN[DI],AH 
    INC SI
    JMP regresar
      
    U:
    MOV DI,06h
    MOV AH,BUFMAY[DI]
    INC AH
    MOV BUFMAY[DI],AH 
    INC SI     
    JMP regresar
    
    umin:
    MOV DI,06h
    MOV AH,BUFMIN[DI]
    INC AH
    MOV BUFMIN[DI],AH 
    INC SI
    JMP regresar 
    
    
    IMPRIMIRRES: 
    IMPRIMIR salto 
    IMPRIMIR salto
    IMPRIMIR MAYUS
    IMPA:
    MOV SI, 02h
    XOR AX,AX
    MOV AH, BUFMAY[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LA  
    IMPRIMIR AUX  
    
    IMPE:
    MOV SI, 03h
    XOR AX,AX
    MOV AH, BUFMAY[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LE  
    IMPRIMIR AUX  
    
    IMPI:
    MOV SI, 04h
    XOR AX,AX
    MOV AH, BUFMAY[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LI  
    IMPRIMIR AUX
     
    IMPO:
    MOV SI, 05h
    XOR AX,AX
    MOV AH, BUFMAY[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LO  
    IMPRIMIR AUX 
    
    IMPU:
    MOV SI, 06h
    XOR AX,AX
    MOV AH, BUFMAY[SI] 
    ADD AH,30h
    MOV AUX,AH 
    
    
     
    IMPRIMIR salto
    IMPRIMIR LU  
    IMPRIMIR AUX  
    IMPRIMIR SALTO 
    
    XOR AX,AX
    MOV CX,06h 
    MOV SI, 06h
    SUMAMAY:    
    MOV AL,BUFMAY[SI]
    ADD AH,AL
    DEC SI
    CMP CX,3
    LOOP SUMAMAY
    add AH,30h
    MOV res,AH
    IMPRIMIR SALTO
    IMPRIMIR SUMA
    IMPRIMIR RES 
    IMPRIMIR salto 
    IMPRIMIR salto
    IMPRIMIR MINUS
    
    IMPAMIN: 
    
    MOV SI, 02h
    XOR AX,AX
    MOV AH, BUFMIN[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LAM  
    IMPRIMIR AUX
    
    IMPEMIN: 
    
    MOV SI, 03h
    XOR AX,AX
    MOV AH, BUFMIN[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LEM  
    IMPRIMIR AUX 
    
    IMPIMIN: 
    
    MOV SI, 04h
    XOR AX,AX
    MOV AH, BUFMIN[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LIM  
    IMPRIMIR AUX  
    
    IMPOMIN: 
    
    MOV SI, 05h
    XOR AX,AX
    MOV AH, BUFMIN[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LOM  
    IMPRIMIR AUX
    
    IMPUMIN: 
    
    MOV SI, 06h
    XOR AX,AX
    MOV AH, BUFMIN[SI] 
    ADD AH,30h
    MOV AUX,AH  
    IMPRIMIR salto
    IMPRIMIR LUM  
    IMPRIMIR AUX 
    IMPRIMIR SALTO
    XOR AX,AX
    MOV CX,06h 
    MOV SI, 06h
    SUMAMIN:    
    MOV AL,BUFMIN[SI]
    ADD AH,AL
    DEC SI
    CMP CX,3
    LOOP SUMAMIN
    add AH,30h
    MOV res,AH
    IMPRIMIR SALTO
    IMPRIMIR SUMA
    IMPRIMIR RES 
    
    salir:
    MOV AH,4Ch
    INT 21h
END inicio
END




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
   num db 25,?,25 DUP (?) 
   ingrese db "Ingrese el numero",10,13,'$' 
   SALTO DB " ",10,13, '$'
   pos db ?,'$'  
   entero db ?, '$'
   unoo db "1$"
   cero db "0$" 
   imppunto db ".$"
   esmayor db "Mayor al numero permitido ",10,13,'$'
   numero db 7,? 7 DUP (?) 
   auxentero dw ?, '$'  
   auxfrac dw ?, '$'
   binario db 50,?,50 DUP (?) 
   mil DW 3E8h
   cien DB 64h
   dies DB 0Ah
   doss DB 2h
   diesmil dw 2710h
   uno db 1h
   dondepu db ?, '$'
.CODE
inicio:
    MOV AX,@DATA
    MOV DS,AX
    IMPRIMIR ingrese
    MOV AH, 0Ah ;Texto por teclado a buffer 
    MOV DX, Offset num
    INT 21h  
    MOV SI, 01h
    XOR cx,cx 
    MOV CL, num[SI]  ;Num Posiciones del vector
    MOV SI, CX ;Controlara la palabra  
    INC SI 
    buscarpunto:   
    MOV AL,num[SI]
    CMP AL,'.'
    JE punto
    DEC SI  
    CMP CX,0
    JE multiplos:
    loop buscarpunto
    mayor:
    imprimir salto
    imprimir esmayor
    jmp inicio
    punto:
    MOV BX, SI
    MOV dondepu, BL 
    CMP SI, 07h
    JA mayor
    XOR AX,AX
    MOV AX, SI
    multiplos:
    MOV DI, 07h     
    unidades: ; separar el numero entero  
    DEC SI  
    
    MOV AL,num[SI] 
    SUB AL,30h 
    MOV numero[DI], AL
    cmp cx, 2h
    je anum 
    DEC DI
    loop unidades 
    anum:
    XOR AX,AX
    MOV DI,07h ;Para las unidades
    MOV AL, numero[DI]
    MUL uno 
    MOV auxentero, AX
    
    Dec DI;Para las decenas
    XOR AX,AX  
    MOV AL, numero[DI] 
    MUL dies 
    ADD auxentero, AX 
    
    Dec DI;Para las centenas
    XOR AX,AX  
    MOV AL, numero[DI] 
    MUL cien 
    ADD auxentero, AX 
    
    Dec DI;Para las unidades de millar
    XOR AX,AX  
    MOV AL, numero[DI] 
    MUL mil 
    ADD auxentero, AX
    
    Dec DI;Para las decenaas de millar
    XOR AX,AX  
    MOV AL, numero[DI] 
    MUL diesmil 
    ADD auxentero, AX  
    
    imprimir salto
    MOV AX, auxentero     
    xor DX,DX  
    MOV DI, 02h
    convertirbin:
    XOR BX, BX
    XOR DX, DX 
    mov BX, 02h  
    DIV BX    
    MOV BL, AL
    MOV BH, AH
    CMP DL, 01h
    JE escribiruno   
    CMP DL, 00h
    JE escribircero 
    loop convertirbin 
    
    escribiruno:
    MOV binario[DI], 31h
    INC DI
    XOR AX,AX
    MOV AX,BX
    CMP AX, 00h
    JE next
    JMP convertirbin 
    
    escribircero:  
    MOV binario[DI], 30h
    INC DI
    XOR AX,AX
    MOV AX,BX 
    CMP AX, 00h
    JE next
    JMP convertirbin
    
    imprimircero:
    Imprimir cero
    DEC DI
    JMP voltear
    
    imprimiruno:
    Imprimir unoo 
    DEC DI
    JMP voltear
    
    next: 
    XOR CL,CL 
    DEC DI
    MOV CX, DI
    voltear:
    CMP CX, 01h
    JE calcpunto 
    MOV AL, binario[DI]
    CMP AL,30h 
    JE imprimircero
    CMP AL, 31h
    JE imprimiruno 
    loop voltear 
    
    calcpunto:
    imprimir imppunto  
    XOR AX,AX
    MOV AL, dondepu
    MOV SI, AX
    INC SI 
    MOV AL, num[SI]
    SUB AL, 30h
    MUL cien
    MOV auxfrac, AX 
    XOR AX,AX
    INC SI 
    MOV AL, num[SI]
    SUB AL, 30h
    MUL dies
    ADD auxfrac, AX
    XOR AX,AX
    INC SI 
    MOV AL, num[SI]
    SUB AL, 30h
    MUL uno
    ADD auxfrac, AX 
    XOR AX,AX
    XOR DX,DX
    MOV AX, auxfrac 
    MOV BX, auxfrac
    MOV CX, 14h
    mulxdos:
    ADD AX,BX
    CMP CX,00h 
    JE salir 
    CMP AX,3E7h
    JA pimpuno
    JNA pimpcero
     
    loop mulxdos
    
    pimpuno:
    XOR BX,BX 
    MOV BX, AX
    imprimir unoo 
    XOR AX,AX
    MOV AX,BX
    XOR BX,BX
    SUB AX, 3E8h
    MOV BX,AX
    DEC CX
    JMP mulxdos  
    
    pimpcero:
    XOR BX,BX
    MOV BX,AX
    DEC CX
    imprimir cero
    MOV AX,BX
    JMP mulxdos
  
    salir:
    MOV AH,4Ch
    INT 21h
END inicio
END






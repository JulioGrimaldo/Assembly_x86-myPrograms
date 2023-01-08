.MODEL SMALL
.STACK 100H
.DATA
Mensaje db 'Entrada de datos: $'
Mensaje2 db 'Despues de ordenar: $'
ARR db 100 dup (0) 
.CODE
MAIN PROC 
MOV AX, @DATA 
MOV DS, AX 
MOV AH,9
LEA DX,mensaje
INT 21H 
XOR CX,CX 
MOV AH,1 
INT 21H 
XOR SI,SI   ; limpiamos cx, si 
WHILE:
    CMP AL, 0dh      ;compara con el enter 
    JE END_WHILE
    MOV ARR[SI],AL   ;mueve la entrada al arreglo 
    INC SI           
    INC CX           ;incrementa SI, CX 
    MOV AH,2         ;posiciona el cursor 
    MOV DL,' '
    INT 21h 
    MOV AH,1
    INT 21H
JMP WHILE 
END_WHILE:
    MOV AH,2
    MOV DL,0DH
    INT 21H 
    MOV DL,0AH      ;termina la linea 
    INT 21H
JCXZ EXIT 
    LEA SI,ARR
    MOV BX,CX
CALL BUBBLE_SORT    

MOV AH,9
LEA DX,mensaje2
INT 21h 
XOR SI,SI
TOP:
    MOV AH,2 
    MOV DL, ARR[SI]
    INT 21H
    MOV DL,' '
    INT 21H
    INC SI 
    LOOP TOP  
    
EXIT:
MOV AH, 4CH 
INT 21H 
MAIN ENDP

BUBBLE_SORT PROC 
    PUSH AX 
    PUSH BX 
    PUSH CX 
    PUSH DX 
    PUSH DI 
    MOV AX,SI
    MOV CX, BX 
    DEC CX 
@OUTER_LOOP:
    MOV BX, CX 
    MOV SI, AX 
    MOV DI, AX 
    INC DI 
    @INNER_LOOP:
    MOV DL, [SI]
    CMP DL, [DI]
        JNG @SKIP_EXCHANGE
        XCHG DL, [DI]
        MOV [SI], DL
        @SKIP_EXCHANGE:
        INC SI
        INC DI 
        DEC BX 
        POP DI 
        POP DX
        POP CX 
        POP BX 
        POP AX 
        RET 
BUBBLE_SORT ENDP 
END MAIN 
    
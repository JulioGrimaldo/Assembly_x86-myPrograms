.MODEL SMALL 2
.STACK 100H
.DATA
mensaje DB 'Ingrese los numeros $' 
mensaje2 DB 'Despues de ordenar $' 
ARR DB 100 dup (0)     
con db ?
.CODE
MAIN PROC 
MOV AX,@DATA 
MOV DS,AX 
MOV AH,9 
lea DX,mensaje ;muestra el mensaje 
INT 21H ;Code 
XOR CX, CX ;limpia CX 
MOV AH,1 
INT 21H ;
XOR SI,SI  ;limpia si 
WHILE_:
CMP AL, 0dH ; compara con el carro
JE END_WHILE
MOV ARR[SI],AL ;entrada al arreglo
INC SI ; 
INC CX
MOV AH,2 
MOV DL,',' ;despliega la coma
INT 21h
MOV AH,1
INT 21H
inc con ; incrementa al contador para comprobar si es 20   
cmp con, 19
je END_WHILE
JMP WHILE_
END_WHILE:
MOV AH,2
MOV DL,0DH 
INT 21H
MOV DL,0AH
INT 21H
JCXZ EXIT
LEA SI,ARR
MOV BX,CX
CALL burbuja ;llama al metodo de la burbuja
MOV AH,9
LEA DX,mensaje2
INT 21H
XOR SI,SI
TOP:
MOV AH,2
MOV DL,ARR[SI]
INT 21H
MOV DL,',' 
INT 21H
INC SI
LOOP TOP
EXIT:
MOV AH,4CH
INT 21H
MAIN ENDP
burbuja PROC 
PUSH AX 
PUSH BX 
PUSH CX 
PUSH DX 
PUSH DI 
MOV AX, SI 
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
INC SI ; 
INC DI 
DEC BX 
JNZ @INNER_LOOP 
LOOP @OUTER_LOOP 
POP DI 
POP DX 
POP CX 
POP BX 
POP AX 
RET
burbuja ENDP 
END MAIN


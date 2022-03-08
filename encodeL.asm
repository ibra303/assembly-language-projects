.MODEL LARGE
.STACK 100H
.CODE
.386
PUBLIC _encode
_encode PROC FAR
PUSH BP
MOV BP,SP
MOV AX,0
PUSH ES
PUSH FS
PUSH GS
PUSH SI
PUSH DI
MOV DI,[BP+6]   ; di= offset of code array
MOV ES,[BP+8]   ; es= segment of code array
MOV SI,[BP+10]  ; si= offset of msg array
MOV FS,[BP+12]  ; fs= segment of msg array
MOV BX,[BP+14]  ; bx= offset of encoded array
MOV GS,[BP+16]  ; gs= segment of encoded array
BODY:
MOV AL,FS:[SI] ; put the letter of msg array in al
CMP AL,0       
JNE COMPLETE
JMP FINISH
; it is not the end of string.
COMPLETE:
PUSH DI
ADD DI,AX  
MOV AL,ES:[DI]
MOV BYTE PTR GS:[BX],AL
POP DI
INC SI
INC BX
JMP BODY
FINISH:
;end of string
POP DI
POP SI
POP GS
POP FS
POP ES
POP BP
RET 
_encode ENDP
END
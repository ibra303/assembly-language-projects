.MODEL LARGE
.STACK 100H
.CODE
.386
PUBLIC _decode
_decode PROC FAR
PUSH BP
MOV BP,SP
MOV AX,0
PUSH ES
PUSH FS
PUSH GS
PUSH DI
PUSH SI
MOV DI,[BP+6] ; di= codearray offset
MOV ES,[BP+8] ; es= codearray segment
MOV SI,[BP+10]; si= encodedmsg offset
MOV FS,[BP+12]; fs= encodedmsg segment
MOV BX,[BP+14]; bx= decodedarray ofset
MOV GS,[BP+16]; gs= decodedarray segment
BODY:
MOV DI,[BP+6] 
MOV AL,FS:[SI] ; put the letter in si place of encodedmsg in al
CMP AL,0 
JNE COMPLETE1
JMP FINISH1
COMPLETE1:
; it is not the end of string
; take the index of encodedarray which encodedarray[index]= the letter and put him in decodedarray
MOV CX,256
BODY1:
MOV DL,ES:[DI] 
CMP AL,DL
JNE COMPLETE2
JMP FINISH2
COMPLETE2:
INC DI
LOOP BODY1
FINISH2:
SUB DI,[BP+6]
MOV AX,DI
MOV BYTE PTR GS:[BX],AL 
INC SI
INC BX
JMP BODY
FINISH1:
; end of string
POP SI
POP DI
POP GS
POP FS
POP ES
POP BP
RET 
_decode ENDP
END
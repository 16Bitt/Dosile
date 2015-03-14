%include "psp.h"

;DOS 1.0 exit program
DOS_INT_0:
	;Get old CS to index the PSP
	MOV AX, REGISTER_CS
	MOV ES, AX
	
	;Remap old CTRL-C handler
	MOV SI, PSP_OLDBRK
	MOV AX, [ES:SI]
	LODSW
	MOV DX, AX
	LODSW
	MOV DS, AX
	MOV AX, CTRL_BREAK
	CALL MAP_INTERRUPT
	
	;Get the address of where the last program called this one
	MOV SI, PSP_OLDKILL
	MOV AX, [ES:SI]
	MOV SI, INT_0_LOW
	MOV [CS:SI], AX		;Write low word
	MOV SI, PSP_OLDKILL + 2
	MOV AX, [ES:SI]
	MOV SI, INT_0_HIGH
	MOV [CS:SI], AX		;Write high word
	CALL GET_OLDSTACK	;Update SS:SP
	JMP [INT_0_LOW]		;Return to the parent

INT_0_LOW:	DW 0
INT_0_HIGH:	DW 0

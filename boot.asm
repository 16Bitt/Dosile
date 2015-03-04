	[BITS 16]
	[ORG 0x7C00 + 64]

	JMP 0:CORRECTION
CORRECTION:
	MOV AX, CS
	MOV ES, AX
	MOV SS, AX
	MOV DS, AX
	MOV SP, 0x7C00
	MOV SI, ENTRYSTR
	CALL PRINT
	CLI
	HLT

PRINT:
	PUSHA
	MOV AH, 0x0E
PRINTLOOP:
	LODSB
	OR AL, AL
	JZ ENDPRINT
	INT 0x10
	JMP PRINTLOOP
ENDPRINT:
	POPA
	RET

ENTRYSTR: DB "Dosile boot started.", 13, 10, 0

	TIMES 510 - 64 - ($ - $$) DB 0
	DW 0xAA55

	[BITS 16]
	[ORG 0x8800]

%include "bios.h"
%include "sys_dos.h"
%include "reg.h"

ENTRYPOINT:
	MOV AX, CS
	MOV ES, AX
	MOV DS, AX
	MOV SS, AX
	MOV GS, AX
	MOV FS, AX

	MOV SI, PAYLOAD_STRING
	CALL PRINT
	
	MOV DX, DOSILE_STUB
	MOV AX, SYS_DOS
	CALL MAP_INTERRUPT

	MOV AH, DSK_RESET
	INT SYS_DOS
	
	MOV AH, 128
	INT SYS_DOS

	CLI
	HLT

;All INT 21H calls go here
DOSILE_STUB:
	PUSHA
	PUSH SS
	PUSH DS
	PUSH ES
	PUSH BP
	MOV BP, SP
	
	SHR AX, 8
	SHL AX, 1
	ADD AX, JMP_TAB
	MOV SI, AX
	MOV AX, [CS:SI]
	JMP AX
	
END_INT:
	MOV SP, BP
	POP BP
	POP ES
	POP DS
	POP SS
	POPA
	IRET

;Assumes ES:SI=string
PRINT:
	PUSHA
	MOV AH, PUTCHAR
PRINTLOOP:
	LODSB
	OR AL, AL
	JZ DONEPRINT
	INT TEXT_SERVICE
	JMP PRINTLOOP
DONEPRINT:
	POPA
	RET

;Puts a long address into the interrupt table
MAP_INTERRUPT:
	PUSHA
	SHL AX, 2
	MOV BX, AX
	XOR AX, AX
	MOV ES, AX
	MOV [ES:BX], DX
	ADD BX, 2
	MOV [ES:BX], DS
	POPA
	RET

;Print 4 bit number
PRINT_NIBBLE:
	AND AL, 0x0F
	CMP AL, 10
	JGE IS_LETTER
	ADD AL, '0'
	JMP DONEPRINTNIBBLE
IS_LETTER:
	SUB AL, 0x0A
	ADD AL, 'A'
DONEPRINTNIBBLE:
	MOV AH, PUTCHAR
	INT TEXT_SERVICE
	RET

;Print 8 bit number
PRINT_BYTE:
	PUSHA
	MOV BX, AX
	SHR AX, 4
	CALL PRINT_NIBBLE
	MOV AX, BX
	CALL PRINT_NIBBLE
	POPA
	RET

;Print 16 bit number
PRINT_WORD:
	PUSHA
	MOV BX, AX
	MOV AL, BH
	CALL PRINT_BYTE
	MOV AL, BL
	CALL PRINT_BYTE
	POPA
	RET

;Save SS:SP
SAVE_OLDSTACK:
	MOV SI, PSTACKPTR
	MOV AX, [CS:SI]
	MOV SI, AX
	MOV AX, [CS:SI]		;Get the current stack element
	MOV SI, AX
	MOV AX, SS		
	MOV [CS:SI], AX		;Save SS
	ADD SI, 2
	MOV AX, SP
	ADD AX, 2		;Account for the return address
	MOV [CS:SI], AX		;Save SP
	MOV SI, PSTACKPTR
	ADD WORD [CS:SI], 4	;Update the pstack pointer
	RET

;Restore SS:SP
GET_OLDSTACK:
	MOV SI, PSTACKPTR
	MOV AX, [CS:SI]
	MOV SI, AX
	MOV AX, [CS:SI]		;Get the current stack element
	MOV SI, AX
	SUB SI, 2		;Point to SP
	MOV AX, [CS:SI]
	MOV SP, AX		;Get SP
	SUB SI, 2		;Point to SS
	MOV AX, [CS:SI]
	MOV SS, AX		;Get SS
	MOV SI, PSTACKPTR
	SUB WORD [CS:SI], 4	;Update pstack pointer
	RET

;Prints the register status of the running process when the interrupt fired
REGISTER_DUMP:
	MOV AX, CS
	MOV ES, AX
	MOV SI, STR_AX
	CALL PRINT
	MOV AX, REGISTER_AX
	CALL PRINT_WORD
	MOV SI, STR_BX
	CALL PRINT
	MOV AX, REGISTER_BX
	CALL PRINT_WORD
	MOV SI, STR_CX
	CALL PRINT
	MOV AX, REGISTER_CX
	CALL PRINT_WORD
	MOV SI, STR_DX
	CALL PRINT
	MOV AX, REGISTER_DX
	CALL PRINT_WORD
	MOV SI, STR_SI
	CALL PRINT
	MOV AX, REGISTER_SI
	CALL PRINT_WORD
	MOV SI, STR_DI
	CALL PRINT
	MOV AX, REGISTER_DI
	CALL PRINT_WORD
	MOV SI, STR_BP
	CALL PRINT
	MOV AX, REGISTER_BP
	CALL PRINT_WORD
	MOV SI, STR_CS
	CALL PRINT
	MOV AX, REGISTER_CS
	CALL PRINT_WORD
	MOV SI, STR_IP
	CALL PRINT
	MOV AX, REGISTER_IP
	CALL PRINT_WORD
	MOV SI, STR_CR
	CALL PRINT
	RET

;Jump table for the interrupt stub
JMP_TAB:
	DW DOS_INT_0
	DW DOS_INT_1
	DW DOS_INT_2
	DW NOT_SUPPORTED_TRAP		;Serial IO is #deprecated for Dosile
	DW NOT_SUPPORTED_TRAP
	DW NOT_SUPPORTED_TRAP		;Printers are #deprecated for Dosile
	DW DOS_INT_6
	DW DOS_INT_7
	DW DOS_INT_8
	DW DOS_INT_9
	DW DOS_INT_10
	DW DOS_INT_11
	DW NOT_SUPPORTED_TRAP		;No need to clear the keyboard buffer so far
	DW DOS_INT_13
	TIMES 247 DW BAD_INT_TRAP

;Called for interrupts that have no standard in the DOS API
BAD_INT_TRAP:
	MOV AX, CS
	MOV ES, AX
	MOV SI, TRAP_STRING
	CALL PRINT
	CALL REGISTER_DUMP
	CLI
	HLT

;Called for interrupts that have no intentions of being implemented
NOT_SUPPORTED_TRAP:
	MOV AX, CS
	MOV ES, AX
	MOV SI, NOT_SUPPORTED
	CALL PRINT
	CALL REGISTER_DUMP
	CLI
	HLT

;Area for importing outside code
%include "exec.asm"
%include "con.asm"
%include "disk.asm"

;Strings for dumping the registers
STR_AX:	DB "AX=", 0
STR_BX:	DB " BX=", 0
STR_CX:	DB " CX=", 0
STR_DX: DB " DX=", 0
STR_SI:	DB " SI=", 0
STR_DI:	DB " DI=", 0
STR_BP:	DB " BP=", 0
STR_CS: DB " EXEC=", 0
STR_IP:	DB ":", 0
STR_CR:	DB 13, 10, 0

;Stack for calling other programs
PSTACK:
	TIMES 20 DW 0
PSTACKPTR:
	DW PSTACK

;Current disk and path
DOS_DISK:	DB 0
CURRENT_PATH:	DB '\\'
		TIMES 127 DB 0

;General strings for general kernel notifications etc.
PAYLOAD_STRING: DB "Kernel successfully entered.", 13, 10, 0
INTERRUPT_TEST:	DB "Int 21h test call$", 13, 10, 0
TRAP_STRING:	DB "Fatal: unknown interrupt option caught", 13, 10, 0
STUB_STRING:	DB "Warning: stubbed function.", 13, 10, 0
NOT_SUPPORTED:	DB "Unsupported int 21h call caught", 13, 10, 0

__END:

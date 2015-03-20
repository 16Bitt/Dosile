;DOS 1.0+ reset disk
;Dosile DSK_RESET
DOS_INT_13:
	MOV AX, CS
	MOV ES, AX
	MOV SI, STUB_STRING
	CALL PRINT
	CALL REGISTER_DUMP
	JMP END_INT

;DOS 1.0+ select disk
;Dosile DSK_SETDEFAULT
DOS_INT_14:
	MOV DX, REGISTER_DX
	CALL DOSILE_GET_BPB
	CALL DOSILE_INIT_DISK
	CALL DOSILE_LOADFAT
	CALL DOSILE_LOADROOT
	JMP END_INT

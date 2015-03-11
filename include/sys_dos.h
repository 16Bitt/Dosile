%ifndef SYS_DOS_H
%define SYS_DOS_H 1

;PREFIXES: the following define the standard for interrupt targets
;CON = console IO
;PRN = printer IO
;FIL = file IO
;STD = stdio IO
;DSK = disk IO
;INT = interrupt manipulation
;TIM = time operation
;DOS = system utility
;DIR = directory operation

;SUFFIXES: the following define the standard for detailing execution
;NE = no echo
;BF = buffered
;ST = status

;This is the primary DOS interrupt handle
%define SYS_DOS		0x21

;These are the primary calls for the DOS syscall
%define STD_READ	0x01
%define STD_PRINT	0x02
%define PRN_PRINT	0x05	;NOT TO BE USED
%define CON_IO		0x06
%define CON_READ_NE	0x07
%define STD_READ_NE	0x08
%define STD_PRINTSTR	0x09
%define STD_INPUT_BF	0x0A
%define STD_INPUT_ST	0x0B
%define STD_FLUSH_BF	0x0C
%define DSK_RESET	0x0D
%define DSK_SETDEFAULT	0x0E
;...
%define DSK_GETDEFAULT	0x19
;...
%define INT_SETVEC	0x25
;...
%define TIM_GETDATE	0x2A
%define TIM_SETDATE	0x2B
%define TIM_GETTIME	0x2C
%define TIM_SETTIME	0x2D
%define DSK_SETVERIFY	0x2E
;...
%define DOS_VERSION	0x30
;...
%define INT_GETVEC	0x35
%define DSK_SPACE	0x36
;...
%define DIR_CREATE	0x39
%define DIR_DELETE	0x3A
%define DIR_SETWORKING	0x3B
%define FIL_CREATE	0x3C
%define FIL_OPEN	0x3D
%define FIL_CLOSE	0x3E
%define FIL_READ	0x3F
%define FIL_WRITE	0x40
%define FIL_DELETE	0x41
%define FIL_SEEK	0x42
%define FIL_ATTRIB	0x43
;...
%define DIR_CURRENT	0x47
;...
%define DOS_EXIT	0x4C
%define DOS_RETCODE	0x4D
;...
%define DSK_GETVERIFY	0x54
;...
%define FIL_RENAME	0x56
%define FIL_DATE	0x57
;...

%endif

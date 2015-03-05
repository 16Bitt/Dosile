%ifndef FAT_H
%define FAT_H 1

%define OO 0x7C00

;BPB attributes
%define ENTRY_JMP		(OO + 0)
%define OEM_IDENT		(OO + 3)
%define BYTES_PER_SECTOR	(OO + 11)
%define SECTORS_PER_CLUSTER	(OO + 13)
%define NUM_RESERVED		(OO + 14)
%define NUM_FATS		(OO + 16)
%define NUM_ENTRIES		(OO + 17)
%define NUM_SECTORS		(OO + 19)
%define MEDIA_DESCRIPTOR	(OO + 21)
%define SECTORS_PER_FAT		(OO + 22)
%define SECTORS_PER_TRACK	(OO + 24)
%define NUM_HEADS		(OO + 26)
%define NUM_HIDDEN		(OO + 28)
%define NUM_SECTORS_HUGE	(OO + 32)

;Extended BPB attributes
%define DRIVE_NUM		(OO + 36)
%define NT_FLAGS		(OO + 37)
%define SIGNATURE		(OO + 38)
%define SERIAL_NUM		(OO + 39)
%define VOLUME_LABEL		(OO + 43)
%define FS_IDENT		(OO + 54)

;Directory entries
%define FILENAME	0
%define ATTRIBUTES	11
%define DIR_NT_RESERVED	12
%define CR_TENTHS	13
%define CR_TIME		14
%define CR_DATE		16
%define AC_DATE		18
%define CLUSTER_HIGH	20
%define MOD_TIME	22
%define MOD_DATE	24
%define CLUSTER_LOW	26
%define BYTE_SIZE	28
%define DIR_SIZE	32

%endif

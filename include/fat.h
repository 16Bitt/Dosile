%ifndef FAT_H
%define FAT_H 1

;BPB attributes
%define ENTRY_JMP		(0x7c00 + 0)
%define OEM_IDENT		(0x7c00 + 3)
%define BYTES_PER_SECTOR	(0x7c00 + 11)
%define SECTORS_PER_CLUSTER	(0x7c00 + 13)
%define NUM_RESERVED		(0x7c00 + 14)
%define NUM_FATS		(0x7c00 + 16)
%define NUM_ENTRIES		(0x7c00 + 17)
%define NUM_SECTORS		(0x7c00 + 19)
%define MEDIA_DESCRIPTOR	(0x7c00 + 21)
%define SECTORS_PER_FAT		(0x7c00 + 22)
%define SECTORS_PER_TRACK	(0x7c00 + 24)
%define NUM_HEADS		(0x7c00 + 26)
%define NUM_HIDDEN		(0x7c00 + 28)
%define NUM_SECTORS_HUGE	(0x7c00 + 32)

%endif

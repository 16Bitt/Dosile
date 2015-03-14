%ifndef PSP_H
%define PSP_H 1

%define PSP_CPMCOMPAT	0
%define PSP_NEXTSEG	2
%define PSP_RESERVED	4
%define PSP_CPMJUMP	5
%define PSP_OLDKILL	0xA
%define PSP_OLDBRK	0xE
%define PSP_OLDERR	0x12
%define PSP_OLDSEG	0x16
%define PSP_JFT		0x18
%define PSP_ENVSEG	0x2C
%define PSP_OLDSP	0x2E
%define PSP_JFTSIZE	0x32
%define PSP_JFTADDR	0x34
%define PSP_OLDPSP	0x3C
%define PSP_RESERVED2	0x42
%define PSP_DOSRET	0x50
%define PSP_RESERVED3	0x53
%define PSP_RESERVED4	0x55
%define PSP_FCB1	0x5C
%define PSP_FCB2	0x6C
%define PSP_CMDBYTES	0x80
%define PSP_CMD		0x81

%endif

;-*- tab-width: 8 -*-
;================================
;  DOS2 to VRAM
;================================

START:	EQU	0B000H

	FNAME	"DOS2VRAM.BIN"

;--------------------------------
	DB	0FEH	;BSAVE ID
	DW	START
	DW	PROG_END - 1
	DW	START
;--------------------------------

	INCLUDE	"MSX_HEAD.ASM"

;--------------------------------
	ORG	START
;--------------------------------

; USE:	(INT)USER(BANK)
; RET:	(INT)0 = SUCCESS / 1 = ERROR
;	Z=OK/NZ=ERROR
DOS2VRAM: ;
	CP	2
	RET	NZ
;
; --> ÃÇ· ÃÞ Á®¸¾Â Ó¼ÞÚÂ ±ÄÞÚ½ ¼­Ä¸
; LD HL,(0F7F8H)
; <--
; --> Ã¸ÊÝ É ÔØ¶À : hl=(hl+2)
	PUSH	HL
	POP	IX		;(IX+2) = INT VALUE
	LD	L,(IX+2)	;get value(low)
	LD	H,(IX+3)	;get value(high)
; <--
	PUSH	HL

	DI
	LD	A,80H+3+4*1	;SLOT 3-1
	LD	HL,4000H
	CALL	ENASLT
	DI			;•ÛŒ¯

	LD	DE,0
	POP	HL
	LD	A,L
	CALL	PAGE_COPY
	CALL	PAGE_COPY
	CALL	PAGE_COPY
	CALL	PAGE_COPY

	XOR	A
	LD	(6000H),A	;BANK=0

	LD	A,(EXPTBL)
	LD	HL,4000H
	CALL	ENASLT

	EI

; --> Ã¸ÊÝ É ÔØ¶À : hl=(hl+2)
	LD	HL,0
	LD	(IX+2),L	;get value(low)
	LD	(IX+3),H	;get value(high)
; <--

	RET

;	A  ; BANK
;	DE : VRAM ADDRESS
PAGE_COPY:
	PUSH	AF
	LD	(6000H),A	;BANK
	CALL	VSETWRT
	LD	HL,4000H
	LD	B,0
	LD	A,40H
	DEC	C
PAGE_COPY_LOOP:
	OTIR
	DEC	A
	JR	NZ,PAGE_COPY_LOOP

	POP	AF
	INC	A

	LD	HL,4000H
	ADD	HL,DE
	EX	DE,HL
	RET

;--------------------------------
	INCLUDE	"VRAM.ASM"

PROG_END:


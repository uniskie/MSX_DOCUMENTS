;*TAB 4*
;================================
; INCLUDE FILE for LOADSRD
;================================
; not for USR()
;		VSETWRT	 - SET to WRITE VRAM
;		(no use)WAIT_VR	 - WAIT VSYNC
;		SETATRBAS  - CHANGE SPRITE ATTRIBUTE ADDRESS
;================================
;---- VDP Command ----

VDPIOR:	EQU		0006H	;VDP I/O port m (READ)
VDPIOW:	EQU		0007H	;VDP I/O port n (WRITE)

SCRMOD:	EQU		0FCAFH	;½¸Ø°Ý Ó°ÄÞ
ACPAGE:	EQU		0FAF6H	;±¸Ã¨ÌÞÍß°¼Þ

CGPNT:	EQU		0F91FH	;ROM Font Address(2),Slot(1)
NAMBAS:	EQU		0F922H	;ÊßÀ°ÝÈ°ÑÃ°ÌÞÙ Address(2)
CGPBAS:	EQU		0F924H	;ÊßÀ°Ý¼ÞªÈÚ°ÀÃ°ÌÞÙ Address(2)
PATBAS:	EQU		0F926H	;½Ìß×²Ä¼ÞªÈÚ°ÀÃ°ÌÞÙ Address(2)
ATRBAS:	EQU		0F928H	;½Ìß×²Ä±ÄØËÞ­°ÄÃ°ÌÞÙ Address(2)

;--- set vram address to write
; USE: A,C
; INP: DE = vram address

VSETWRT:
		LD		A,(VDPIOW)
		INC		A
		LD		C,A
		LD		A,(SCRMOD)		;screen mode
		CP		7
		JR		NC,VSETWR3		; page / 1
; SCREEN 5,6 = page : A16,15
		LD		A,D
		RLA						; c=d7
		RLA						; c=d6
		LD		A,(ACPAGE)		; Active Page
		RLA						;00000pp6
		AND		7				; xxxxxpp6 ÈÝÉÀÒ mask
		JR		VSETWR4
VSETWR3:
; SCREEN 7,8 = page : A16
		LD		A,(ACPAGE)		; Active Page
		RRA						;c=page(p)
		LD		A,D
		RLA						;6543210p/c=7
		RLA						;543210p7/c=6
		RLA						;43210p76/c=5
		AND		7				; xxxxxp76
VSETWR4:
		DI
		OUT		(C),A			;bit2-0:A16-14 / bit7-3:00000
		LD		A,8EH
		OUT		(C),A

		OUT		(C),E			;A7-0
		LD		A,D
		AND		7FH				;bit7:0
		OR		40H				;bit6:WRITE=1
		OUT		(C),A			;bit5-0:A13-8
		RET

;--- wait until v-sync cycle
; USE: AF,C
; OUT: DI
;	   C=(VDPIO_WRITE) + 1
WAIT_VR:
		LD		A,(VDPIOW)
		LD		C,A
		INC		C
		DI
; C=(VDPIO_WRITE) + 1
WAIT_VR2:
		LD		A,2
		OUT		(C),A
		LD		A,15+80H
		OUT		(C),A
WAITVR1_:
		IN		A,(C)
		AND		40H
		JP		NZ,WAITVR1_

WAITVR2_:
		IN		A,(C)
		AND		40H
		JP		Z,WAITVR2_

		XOR		A
		OUT		(C),A
		LD		A,15+80H
		OUT		(C),A
		RET

;--- SET SPRITE ATTRIBUTE TABLE
;  IN: HL=NEW ADDRESS
;  USE: AF,C,DI
SETATRBAS:
		LD		A,(VDPIOW)
		LD		C,A
		INC		C

		LD		A,(SCRMOD)		;screen mode
		CP		7
		JR		NC,SETATRBAS1	; page / 1
; SCREEN 5,6 = page : A16,15
		LD		A,H
		RLCA					;Cy=A15
		LD		A,(ACPAGE)
		ADC		A,0
		AND		3				; xxxxxxpp+A15
		JR		SETATRBAS2
SETATRBAS1:
; SCREEN 7,8 = page : A16
		LD		A,H
		RRA						; Cy=A15
		LD		A,(ACPAGE)		; Active Page
		RLA
		AND		3				; Xxxxxxp7
SETATRBAS2:
		DI
		OUT		(C),A
		LD		A,8BH			;write R#11
		OUT		(C),A
		LD		A,H
		RLCA
		AND		0FCH			;bit7-2:A14-A9(A9 is always 1)
		OR		7				;bit2:A9=1/ bit1-0:1
		OUT		(C),A
		LD		A,85H			;write R#5
		OUT		(C),A
		RET
;
;======================
;---- SET PALETTE ----
; a=usr(address)
; (address) = [palette]*16
; [parette] = 2byte (rb,0g)
SET_PLT:
		CP		2
		RET		NZ
		CALL	GETINT			;HL=USR(XXXX)

		LD		A,(VDPIOW)
		LD		C,A
		INC		C

		DI
		XOR		A
		OUT		(C),A
		LD		A,16+80H
		OUT		(C),A

		CALL	WAIT_VR2
		INC		C

		LD		B,32
		OTIR
		EI
		RET

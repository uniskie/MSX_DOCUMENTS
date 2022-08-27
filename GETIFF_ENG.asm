;================================================================
; from "Zilog Z80 FAMILY DATA BOOK JANUARY 1989" page 413
;
;	bugfix for LD A,I (or LD A,R) IFF2 flag
;
;Caution, these routines presume that the service routine 
;for any acceptable interrupt will re-enable interrupts 
;before it terminates. This is almost always the case. 
;They may not return the correct result if an interrupt 
;service routine, which does not re-enable interrupts, 
;is entered after the execution of LD A,I (or LD A,R).
;================================================================
;
;================================================================
;Listing 1: This rouline may not be loaded in page zero
;  				(not 0000h to 00FFh).
;================================================================
GETIFF:
	XOR A		;C flag, acc. := 0
	PUSH AF		;stack bottom := 00xxh
	POP AF		;Restore SP
	LD A,I		;P flag := IFF2
	RET PE		;Exit if enabled
	DEC SP		;May be disabled.
	DEC SP		;Has stack bottom been
	POP AF		;overwritten ?
	AND A		;lt not 00xxh, INTs were
	RET NZ		;actually enabled.
	SCF		;Otherwise, they really are
	RET		;disabled
	END
;
;================================================================
;Listing 2: This routine may be loaded anywhere in memory.
;================================================================
GETIFF2:
	PUSH HL		;Save HL contents
	XOR A		;C flag, acc. :=0
	LD H,A		;HL:=0000h
	LD L,A
	PUSH HL		;Stack bottom := 0000h
	POP HL		;Restore SP
	LD A,I		;P flag := IFF2
	JP PE,_POPHL	;Exit if isn't enabled
	DEC SP		;May be disabled.
	DEC SP		;Let's see if slack bottom
	POP HL		;is still 0000h.
	LD A,H		;Are any bits set in H
	OR L		;or in L ?
	POP HL		;Restore old contents.
	RET NZ		;HL <> 0: isn't enabled.
	SCF		;Otherwise, they really are
	RET		;disabled.
_POPHL:
	POP HL 		;Exit when P flag is
	RET		;set by LD A,I
	END

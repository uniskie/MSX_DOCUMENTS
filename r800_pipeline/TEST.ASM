countlow:		equ		0e6h         ; カウンタ下位8ビット
counthigh:		equ		0e7h         ; カウンタ上位8ビット

countio:	equ 	counthigh

loopcount:	equ		$4000

		fname	"test.bin"		;*binhead*
;--> bin file header -->
		db		$fe		;*binhead*
		dw		orgadr	;*binhead*
		dw		endfl-1	;*binhead*
		dw		orgadr	;*binhead*
;<-- bin file header <--

orgadr:	equ		$d000
		org		orgadr

;--- jump table for usr()
		jp		test1
		jp		test2
;---
	
;================================
;  test1
;	A=USR(0)
;	A=time
;================================
		ds		orgadr + $100 - $
test1:
		call	getint
		ret		nz
		push	ix

		di
		call	get_timer
;---------------------------
		ld		bc,loopcount
		
		;---------------
		ld		a,c
		ld		c,b
		ld		b,a
		inc		c
		;---------------

test1_l1:
						;*1
		add		a,1		;2
		inc		a		;2+1=3

						;*2
		add		a,1		;2
		inc		a		;2+1=3
		
						;*3
		add		a,1		;2
		inc		a		;2+1=3
		
						;*4
		add		a,1		;2
		inc		a		;2+1=3
		
						;*5
		add		a,1		;2
		inc		a		;2+1=3
		
						;*6
		add		a,1		;2
		inc		a		;2+1=3
		
						;*7
		add		a,1		;2
		inc		a		;2+1=3
		
						;*8
		add		a,1		;2
		inc		a		;2+1=3
		
						;*9
		add		a,1		;2
		inc		a		;2+1=3
		
						;*10
		add		a,1		;2
		inc		a		;2+1=3
		
						;*11
		add		a,1		;2
		inc		a		;2+1=3
		
						;*12
		add		a,1		;2
		inc		a		;2+1=3
		
						;*13
		add		a,1		;2
		inc		a		;2+1=3
		
						;*14
		add		a,1		;2
		inc		a		;2+1=3
		
						;*15
		add		a,1		;2
		inc		a		;2+1=3
		
						;*16
		add		a,1		;2
		inc		a		;2+1=3
		
		;djnz	test1_l1	; ページブレークの影響を受ける
		dec		b
		jp		nz,test1_l1

		dec		c
		jp		nz,test1_l1
		
;---------------------------
		call	calc_time
		pop		ix
		ld		(ix+2),a
		ld		(ix+3),0
		ei
		ret

;================================
;  test2
;	A=USR(0)
;	A=time
;================================
		ds		orgadr + $200 - $
test2:
		call	getint
		ret		nz
		push	ix

		di
		call	get_timer
;---------------------------
		ld		bc,loopcount
		
		;---------------
		ld		a,c
		ld		c,b
		ld		b,a
		inc		c
		;---------------

test2_l1:
;						;*1
;		add		a,1		;2
;		inc		a		;2+1=3

		jp		test2_n	;3
		
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop

test2_n:
						;*2
		add		a,1		;2
		inc		a		;2+1=3
		
						;*3
		add		a,1		;2
		inc		a		;2+1=3
		
						;*4
		add		a,1		;2
		inc		a		;2+1=3
		
						;*5
		add		a,1		;2
		inc		a		;2+1=3
		
						;*6
		add		a,1		;2
		inc		a		;2+1=3
		
						;*7
		add		a,1		;2
		inc		a		;2+1=3
		
						;*8
		add		a,1		;2
		inc		a		;2+1=3
		
						;*9
		add		a,1		;2
		inc		a		;2+1=3
		
						;*10
		add		a,1		;2
		inc		a		;2+1=3
		
						;*11
		add		a,1		;2
		inc		a		;2+1=3
		
						;*12
		add		a,1		;2
		inc		a		;2+1=3
		
						;*13
		add		a,1		;2
		inc		a		;2+1=3
		
						;*14
		add		a,1		;2
		inc		a		;2+1=3
		
						;*15
		add		a,1		;2
		inc		a		;2+1=3
		
						;*16
		add		a,1		;2
		inc		a		;2+1=3
		
		;djnz	test1_l1	; ページブレークの影響を受ける
		dec		b
		jp		nz,test2_l1

		dec		c
		jp		nz,test2_l1
		
;---------------------------
		call	calc_time
		pop		ix
		ld		(ix+2),a
		ld		(ix+3),0
		ei
		ret

;================================
; save current systime
; use: a
;================================
get_timer:
		in		a,(countio)
		ld		(start_time),a
		ret

;================================
; out  a = past systime
; use: a,hl
;================================
calc_time:
		in		a,(countio)
		ld		hl,(start_time)
		sub		l
		ret

start_time:
		dw		0

;================================
;  get usr(int) 
;================================
; use:	f,ix,hl
; ret:	hl=val
;		z=ok/nz=error
getint: ;
		cp		2
		ret		nz
;
; --> ﾃﾇｷ ﾃﾞ ﾁｮｸｾﾂ ﾓｼﾞﾚﾂ ｱﾄﾞﾚｽ ｼｭﾄｸ
; ld hl,(0f7f8h)
; <--
; --> ﾃｸﾊﾝ ﾉ ﾔﾘｶﾀ : hl=(hl+2)
		push	hl
		pop		ix				;(ix+2) = int value
		ld		l,(ix+2)		;get value(low)
		ld		h,(ix+3)		;get value(high)
; <--
		ret
		
;================================
endfl:

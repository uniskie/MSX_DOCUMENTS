RDSLT:	equ	000CH
WRSLT:	equ	0014H
CALSLT:	equ	001CH
ENASLT:	equ	0024H
CALLF:	equ	0030H

EXPTBL:	equ 0FCC1H	;MAIN ROM SLOT

RAMAD0:	equ	0F341H	;RAM SLOT page 0
RAMAD1:	equ	0F342H	;RAM SLOT page 1
RAMAD2:	equ	0F343H	;RAM SLOT page 2
RAMAD3:	equ	0F344H	;RAM SLOT page 3

		fname	"RDRTYPE.BIN"
;--> bin file header -->
		db		$fe		;*binhead*
		dw		orgadr	;*binhead*
		dw		endfl-1	;*binhead*
		dw		orgadr	;*binhead*
;<-- bin file header <--

orgadr:	equ		$c000
		org		orgadr

;--- jump table for usr()
		jp		rom2vram
;---
rtype_slot:		db		1
	
;# RTYPEのBGMデータ
;
;FMBIOS(OPLDRV)を使用する
;
;## BGMデータのアドレスリスト
;
;$8010 (バンクレジスタ=9) (ROMイメージ $24010)
;```
;73 90 63 98 12 9E B2 A6-93 A9 4B AC 24 B2 49 B5
;BB B5 A3 B7 C9 B7 37 B8-DB B8 21 BA 4F BC F9 BC
;```
;
;BGMデータの範囲は $9073- $BF5D  
; (ROMイメージ $25073 -$27F5D)
;
;1. $9073 (ROMイメージ $25073)
;1. $9863 (ROMイメージ $25863)
;1. $9E12 (ROMイメージ $25E12)
;1. $A6B2 (ROMイメージ $266B2)
;1. $A993 (ROMイメージ $26993)
;1. $AC4B (ROMイメージ $26C4B)
;1. $B224 (ROMイメージ $27224)
;1. $B549 (ROMイメージ $27549)
;1. $B5BB (ROMイメージ $275BB)
;1. $B7A3 (ROMイメージ $277A3)
;1. $B7C9 (ROMイメージ $277C9)
;1. $B837 (ROMイメージ $27837)
;1. $B8DB (ROMイメージ $278DB)
;1. $BA21 (ROMイメージ $27A21)
;1. $BC4F (ROMイメージ $27C4F)
;1. $BCF9 (ROMイメージ $27CF9)
;
;## ROMバンク
;
;|バンク| アドレス    | バンクレジスタ|
;|------|-------------|---------------|
;| 1    | $4000-$7FFF | $6000～$6800  |
;| 2    | $8000-$BFFF | $7000～$7FFF  |
;
;- bank 1 は $0Fまたは$17固定
;- bank 2 切り替えで 実際に使用しているのは$7000h, $7800
;- $6000, $6800へのアクセスがコードには存在するが実行されない。
;
;## その他
;
;■ R-Typeの特殊ROMバンクを変更してASCII 16KBバンクに変更するツール  
;[RType_MSXROM_To_Ascii16](https://github.com/uniskie/RType_MSXROM_To_Ascii16)

rtype_bank_reg1:	equ	6000H
rtype_bank_reg2:	equ	7000H

rtype_bgm_bank:		equ	9
;BGMデータの範囲は $9073- $BF5D
rtype_bgm_start:	equ	$9073
rtype_bgm_size:		equ	$BF5D - $9073

use_page:			equ	$8000
vram_dest:			equ	$9073 - $8000

;================================
;  rom to vram
;	A=USR(0)
;================================
		ds		orgadr + $100 - $
rom2vram:
		call	getint
		ret		nz
		push	ix
		di
; change sp
		ld		(sp_sav),sp
		ld		sp,endfl
; slot page1 = rtype
		ld		a,(rtype_slot)
		ld		hl,$4000
		call	ENASLT
; slot page2 = rtype
		ld		a,(rtype_slot)
		ld		hl,use_page
		call	ENASLT
; bank change
		ld		a,rtype_bgm_bank
		ld		(rtype_bank_reg2),a
; write to vram
		ld		de,vram_dest
		call 	VSETWRT
		dec		c

		ld		hl,rtype_bgm_start
		ld		de,rtype_bgm_size
		ld		b,e
		inc		d
wvram_l:
		outi
		jr		nz,wvram_l
		dec		d
		jr		nz,wvram_l
; slot page 1 = main rom
		ld		a,(EXPTBL)
		ld		hl,$4000
		call	ENASLT
; slot page 2 = main ram
		ld		a,(RAMAD2)
		ld		hl,use_page
		call	ENASLT
; restore sp
		ld		sp,(sp_sav)
;
		ei
		pop		ix
		ld		hl,vram_dest
		ld		(ix+2),l
		ld		(ix+3),h
		ret

;================================
		include	"USR_FUNC.ASM"
		include	"VRAM.ASM"
;================================

sp_sav:		dw		0
sp_space:	ds		$20

endfl:

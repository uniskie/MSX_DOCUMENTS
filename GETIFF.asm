;================================================================
; "Zilog Z80 FAMILY DATA BOOK JANUARY 1989" page 413 より、
;
; LD A,I (or LD A,R) IFF2 flag のバグ対策
;
;注意1:	これらのルーチンは、全ての割り込みのサービスルーチンが、
;	終了する前に割り込みを有効にすることを前提としています。
;	ほとんどの場合、これが当てはまります。
;	LD A,I(またはLD A,R)の実行後に、割り込みを有効にしない
;	割り込みサービスルーチンがあると、正しい結果が返されない
;	場合があります。
;
;注意2:	返り値は割り込み状態の取得のみが保証されます。
;	(Iレジスタの値は保証されません)
;
;注意3:	割り込み状態の判定はP/Vフラグではなく、
;	Cyフラグで返されます。
;================================================================
;
;================================================================
;リスト1:実行アドレスが00xx以外専用
;	(このルーチンは0000h〜00FFh以外に置く事)
;
;GETIFF:	割り込み状態をCyフラグで返す
;	
;入力:	なし
;返り値:Cy==0 : EI(割り込み許可)である
;	Cy==1 : DI(割り込み禁止)である
;使用:	AF
;================================================================
GETIFF:
	XOR A		;CyフラグとAレジスタを0にする
	PUSH AF		;スタックに00xxhを書き込む
	POP AF		;SPを戻す->(SP-2)が00xxh
	LD A,I		;P flag = IFF2
	RET PE		;EIなら戻る(Cyは0)
	DEC SP		;DIなら
	DEC SP		;LD A,(SP-2)
	POP AF		;が
	AND A		;0でなければ
	RET NZ		;EIである(Cyは0)
	SCF		;そうでなければDI(Cy=1)
	RET		;返す
	END
;
;================================================================
;リスト2:どこに配置してもOK
;	(ただし、リロケータブルには出来ない)
;
;GETIFF2:	割り込み状態をCyフラグで返す
;
;入力:	なし
;返り値:Cy==0 : EI(割り込み許可)である
;	Cy==1 : DI(割り込み禁止)である
;使用:	AF
;================================================================
GETIFF2:
	PUSH HL		;HLの値をスタックに退避
	XOR A		;CyフラグとAレジスタを0にする
	LD H,A		;HL=0000h
	LD L,A
	PUSH HL		;スタックに0000hを積む
	POP HL		;SPを戻す->(SP-2)が0000h
	LD A,I		;P flag = IFF2
	JP PE,_POPHL	;EIならこのまま終了処理へ飛ぶ
	DEC SP		;DIの場合
	DEC SP		;LD HL,(SP-2)
	POP HL		;が0000hか
	LD A,H		;調べる
	OR L		;
	POP HL		;スタックに退避したHLの値を復帰
	RET NZ		;LD HL,(SP-2)が0000hでなければEI(Cyは0)
	SCF		;そうでないならDI(Cy=1)
	RET		;返す
_POPHL:
	POP HL 		;退避したHLの値を復帰
	RET		;LD A,IでCyは変化しないのでCyは0
	END
;
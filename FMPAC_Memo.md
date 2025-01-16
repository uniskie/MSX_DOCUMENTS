# ■ FMPACのバンク選択

http://bifi.msxnet.org/msxnet/utils/saverom

```
レジスタ: 7FF7h
SAVEROM FMPAC.ROM⏎
Select Type: Custom
Switch Address: 7FF7
Save Address: 4000
Block Size: 4000
First Block: 0
Last Block: 3
```

# ■ FMPACの曲データ

RAM 0CBF4H(環境による)へ転送して再生される

| ROMオフセット | 内容 |
| --- | --- |
|+$8080 | 曲データアドレスリスト (2byte*5) |
|       | $408A ... 1曲目位置(※実行空間でのアドレス) |
|       | $478C ... 2曲目位置(※実行空間でのアドレス) |
|       | $590E ... 3曲目位置(※実行空間でのアドレス) |
|       | $5B90 ... 4曲目位置(※実行空間でのアドレス) |
|       | $6612 ... 5曲目位置(※実行空間でのアドレス) |
|       |   |
|+$808A | [1曲目] サイズ(2bytes):$0700, 以後データ本体...($808C-$878B) |
|+$878C | [2曲目] サイズ(2bytes):$1180, 以後データ本体...($878E-$990D) |
|+$990E | [3曲目] サイズ(2bytes):$0280, 以後データ本体...($9910-$9B8F) |
|+$9B90 | [4曲目] サイズ(2bytes):$0A80, 以後データ本体...($9B92-$A611) |
|+$A612 | [5曲目] サイズ(2bytes):$0580, 以後データ本体...($A614-$AB93) |

# ■ カートリッジからデータを取り出すプログラム  

OPLDRV_BGM_EXTRACT  
https://github.com/uniskie/MSX_MISC_TOOLS/tree/main/OPLDRV_BGM_EXTRACT

# ■ 曲再生呼び出し処理

(bank 0)
```
64e6    push    af              ;a = BGM No.
        cp      #ff
        jp      z,#654c
        ld      hl,#0100
        push    af              ;save af (a = BGM No.)
        call    #73d3
        inc     hl
        ld      a,l
        and     #fe
        ld      l,a
        ld      (#8323),hl      ;#d2f8 ?

        pop     hl              ;hl = saved af (h = BGM No.)
        ld      l,h
        ld      h,0
        add     hl,hl
        ld      bc,#4080        ; data adr. list (2*5)
        add     hl,bc           ;
        ld      e,2
        call    #402c           ;read hl,(hl) #bank e
        ld      e,2
        ld      (#832b),hl      ;src adr. #0408a
        call    #402c           ;read hl,(hl) #bank e
        ld      (#832d),hl      ;(src adr.) = size #0700
        call    #73d3
        ld      (#8325),hl      ;dest adr. #cbf4

        ld      c,2
        push    bc
        ld      hl,(#832d)      ;size #0700
        ld      c,l
        ld      b,h             ;bc = size #0700
        ld      hl,(#832b)      ;src #0408a
        inc     hl
        inc     hl
        ex      de,hl           ;hl = src + 2 #0408c
        ld      hl,(#8325)      ;dst #cbf4
652b    call    #4026
        ....

4026    jp      #4048
        ....

4048    ld      a,(#7ff7)       ;a = current bank
        ex      af,af'
        exx
        push    hl
        pop     de
        push    de
        push    hl
        exx
4053    ld      (#7ff7),a       ;(bank 1)
        ex      de,hl
4057    ldir
        ex      af,af'
        ld      (#7ff7),a       ;(bank 0)
        ret```

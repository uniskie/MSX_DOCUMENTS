# RTYPEのBGMデータ

FMBIOS(OPLDRV)を使用する

## BGMデータのアドレスリスト

$8010 (バンクレジスタ=9) (ROMイメージ $24010)
```
73 90 63 98 12 9E B2 A6-93 A9 4B AC 24 B2 49 B5
BB B5 A3 B7 C9 B7 37 B8-DB B8 21 BA 4F BC F9 BC
```

BGMデータの範囲は $9073- $BF5D  
 (ROMイメージ $25073 -$27F5D)

1. $9073 (ROMイメージ $25073)
1. $9863 (ROMイメージ $25863)
1. $9E12 (ROMイメージ $25E12)
1. $A6B2 (ROMイメージ $266B2)
1. $A993 (ROMイメージ $26993)
1. $AC4B (ROMイメージ $26C4B)
1. $B224 (ROMイメージ $27224)
1. $B549 (ROMイメージ $27549)
1. $B5BB (ROMイメージ $275BB)
1. $B7A3 (ROMイメージ $277A3)
1. $B7C9 (ROMイメージ $277C9)
1. $B837 (ROMイメージ $27837)
1. $B8DB (ROMイメージ $278DB)
1. $BA21 (ROMイメージ $27A21)
1. $BC4F (ROMイメージ $27C4F)
1. $BCF9 (ROMイメージ $27CF9)

## ROMバンク

|バンク| アドレス    | バンクレジスタ|
|------|-------------|---------------|
| 1    | $4000-$7FFF | $6000～$6800  |
| 2    | $8000-$BFFF | $7000～$7FFF  |

- bank 1 は $0Fまたは$17固定
- bank 2 切り替えで 実際に使用しているのは$7000h, $7800
- $6000, $6800へのアクセスがコードには存在するが実行されない。

## その他

■ R-Typeの特殊ROMバンクを変更してASCII 16KBバンクに変更するツール  
[RType_MSXROM_To_Ascii16](https://github.com/uniskie/RType_MSXROM_To_Ascii16)

■ カートリッジからデータを取り出すプログラム  
https://github.com/uniskie/MSX_MISC_TOOLS/tree/main/OPLDRV_BGM_EXTRACT

# RTYPEのBGMデータ

FMBIOS(OPLDRV)を使用する

## BGMデータのアドレスリスト

0x8010 (バンクレジスタ=9) (ROMイメージ 0x24010)
```
73 90 63 98 12 9E B2 A6-93 A9 4B AC 24 B2 49 B5
BB B5 A3 B7 C9 B7 37 B8-DB B8 21 BA 4F BC F9 BC
```

BGMデータの範囲は 0x9073- 0xBF5D  
 (ROMイメージ 0x25073 -0x27F5D)

```
01. 0x9073 (ROMイメージ 0x25073)
02. 0x9863 (ROMイメージ 0x25863)
03. 0x9E12 (ROMイメージ 0x25E12)
04. 0xA6B2 (ROMイメージ 0x266B2)
05. 0xA993 (ROMイメージ 0x26993)
06. 0xAC4B (ROMイメージ 0x26C4B)
07. 0xB224 (ROMイメージ 0x27224)
08. 0xB549 (ROMイメージ 0x27549)
09. 0xB5BB (ROMイメージ 0x275BB)
10. 0xB7A3 (ROMイメージ 0x277A3)
11. 0xB7C9 (ROMイメージ 0x277C9)
12. 0xB837 (ROMイメージ 0x27837)
13. 0xB8DB (ROMイメージ 0x278DB)
14. 0xBA21 (ROMイメージ 0x27A21)
15. 0xBC4F (ROMイメージ 0x27C4F)
16. 0xBCF9 (ROMイメージ 0x27CF9)
```

## ROMバンク

|バンク| アドレス    | バンクレジスタ|
|------|-------------|---------------|
| 1    | 0x4000-0x7FFF | 0x6000～0x6800  |
| 2    | 0x8000-0xBFFF | 0x7000～0x7FFF  |

- bank 1 は 0x0Fまたは0x17固定
- bank 2 切り替えで 実際に使用しているのは0x7000h, 0x7800
- 0x6000, 0x6800へのアクセスがコードには存在するが実行されない。

## その他

■ R-Typeの特殊ROMバンクを変更してASCII 16KBバンクに変更するツール  
[RType_MSXROM_To_Ascii16](https://github.com/uniskie/RType_MSXROM_To_Ascii16)

■ カートリッジからデータを取り出すプログラム  
https://github.com/uniskie/MSX_MISC_TOOLS/tree/main/OPLDRV_BGM_EXTRACT

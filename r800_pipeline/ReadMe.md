﻿# R800のパイプラインのテスト

## TEST.ASM

```
ADD A,1
INC A
```
で2ステート+1ステート=3ステート

```
JP nnnn
```
でRAM上なら3ステート+2ステートの追加ウェイト=５ステート
(JP命令への追加ウェイトは、ROMだと3、外部RAMは4～5)

参考：https://map.grauw.nl/resources/z80instr.php#r800waits


同じステート数に揃えて、
片方は分岐命令で+16の位置に飛ばすことで、
パイプラインキャッシュの破棄とリロードが入って遅くなるかどうか
を検証するプログラム。

また念のため256バイト境界に配置。

$4000回のループを、
システムタイマーで検査。

## TEST.BAS

- 1つ目が```JP```未使用
- 2つ目が```ADD A,1```+```INC A``` を１つ ```JP```に置き換えたもの


## 結果メモ

結果的に２つのパターンで変化なし。


RST/CALLは後ろに続く命令によっては変化があるとのこと。
https://map.grauw.nl/resources/z80instr.php#callwaitnote
原因は分かりませんねー。

# 1chipMSX OCM-PLD SDBIOS用ロゴ差し替えデータ：MSX++

## LOGOMAKE.BAS
![](../image/logomake_bas.png)
ファイル名には MSXPP⏎





## ASMファイルのアセンブル
  添付のASMファイルはTASM80用とのことなのですが、
TASMはMS-DOS用の16bitプログラムなので、64bit版WINDOWSでは動作しません。  
そのためDOSBox等から実行する形になります。

日本語が扱える派生版 DOSVAXJ3 がおすすめです。  
https://www.nanshiki.co.jp/software/dosvaxj3.html

mount C "Cドライブとして使いたいフォルダのパス"
などとして使用すると楽です。

> TASM -80 -b MSXPP.ASM
のように実行します。

TASMを今更使いたくなければ、.equや.dbをequやdbに置換してもらえれば他のアセンブラでもアセンブルできると思います。

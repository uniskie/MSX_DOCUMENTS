# MSX0 M5stack Core2 machine defines for openMSX

OpenMSXでMSX0 M5stack Core2から吸い出したROMで起動するための定義ファイルです。

1. Windowsは ```%USERPROFILE%\Documents\OpenMSX\share\machines```
2. Unixは ```~/.openMSX/share/machines```

に配置してください。

1. [MSX0_M5stack_Core2_MSX1.xml](MSX0_M5stack_Core2_MSX1.xml)
2. [MSX0_M5stack_Core2_MSX2.xml](MSX0_M5stack_Core2_MSX2.xml)
3. [MSX0_M5stack_Core2_MSX2+.xml](MSX0_M5stack_Core2_MSX2+.xml)

---

## MSX0のI/Oポート

https://github.com/uniskie/MSX_MISC_TOOLS/tree/main/for_MSX0#msx0-io%E3%83%9D%E3%83%BC%E3%83%88

- PORT 8 : IOT操作（入出力）
- PORT 16: ターミナルコンソールへの出力（出力）

の動作についてはOpenMSX本体側で対応が必要になります。

変則的な方法ですが、スクリプトからdebug機能を使用してI/Oポートアクセスにフックをかける方法もあります。

> ## 例）I/Oの8番を読み取った時に強制で10を返す
> 
>   **※ IN A,(?)専用**
> ```
> debug set_watchpoint read_io 8 {} {reg pc ${::wp_last_address}; skip_instruction; reg a 10}
> ```
> - 補足
>   
>   ```reg pc ${::wp_last_address}; skip_instruction;```  ... ```IN A,(?)```コマンドをスキップする
>
>   openMSXの内部処理はIN A,(?)命令の途中で停止しているため、（この状態で```reg A 10```を実行してAレジスタの値を書き換えたとしても）処理を続行するとAレジスタがI/Oから読みだした値で上書きされてしまいます。
> 
>   その対策として、一旦実行アドレスを現在の```IN A,(?)```命令の位置に再セットしたのちに、その次の命令までスキップします。
> 
>   こうすることで、AレジスタへのI/O読み出しをスキップしできるので、```reg A 10```を実行した状態（Aレジスタの値=10）で処理を続行できます。

>  ## I/Oの8番への書き込みをフックして処理```msx0::write_io_8```を呼び出す
> ```
> debug set_watchpoint write_io 8 {} {msx0::write_io_8}
> ```
> OUT (?),A専用であれば、関数```msx0::write_io_8```の中でレジスタAを読み出して処理を行うことが出来ます。
>
> 書き込みフックについては、
> ```OpenMSX\share\scripts\_scc_toys.tcl(240)``` 付近などが参考になるかもしれません。  
> PSGでの演奏をSCCで鳴らすスクリプトがあります。  
> （Menuボタン → Advanced → Toys And Utilities → psg2scc で有効化/無効化できます。）

---

## MSX0 Slot構成

|          | 0x0000    | 0x4000    | 0x8000   | 0xC000   |
|----------|-----------|-----------|----------|----------|
| Slot 0-0 | BIOS_MAIN | BIOS_MAIN | -------- | -------- |
| Slot 0-1 | --------  | IOT       | -------- | -------- |
| Slot 0-2 | --------  | XBASIC    | XBASIC   | -------- |
| Slot 0-3 | --------  | --------  | SCC      | -------- |
| Slot 1   | --------  | (GAME)    | (GAME)   | -------- |
| Slot 2   | --------  | --------  | -------- | -------- |
| Slot 3-0 | RAM       | RAM       | RAM      | RAM      |
| Slot 3-1 | --------  | DOS2      | -------- | -------- |
| Slot 3-2 | BIOS_SUB  | KANJI     | KANJI    | -------- |
| Slot 3-3 | --------  | DISK      | DISK     | -------- |

## MSX-DOS1 ROM

  DOS1はslot3-3のDISK ROMです。

  DOS2は追加で別スロットに実装されています。

## MSX-DOS2 ROM

```
  4000H - 7FFFH
  BANK SELECT: 6000H
  BANK COUNT: 4
```

  ※ 割り込み許可状態でバンク0以外にしていると暴走します

  カートリッジ版ver2.20をベースに修正を加えたもののようで、
  bank3は漢字ドライバになっています。

  （ターボRなどのDOS2内蔵機種ではbank3がDOS1になっています）

  MSX0からはbank3の漢字BASICドライバは使用しておらず、
  slot3-2にある漢字BASICを使用していると思われます。

## IOT ROM

```
  4000H-5FFFh : CALL文拡張（DEVICE拡張もあるが動作しない）  
  6000H-7FFFH : おそらくメモリマップドI/O
```


- 実装上の問題 （ver 0.05.04）

  CALL IOTFINDでは、受け取り用変数として配列変数（配列先頭要素）を渡す形になっています。

  実は、この命令では**暴走**や**メモリ破壊**を起こす場合があるので注意が必要です。

  - 渡された変数が配列かどうかのチェックが入っていない  
    → 配列ではない変数を渡す  
    → **エラーで停止せずにメモリを破壊する**

  - 要素数のチェックがされていない  
    → 用意した配列要素数を超えるデータを取得する  
    → **エラーで停止せずにメモリを破壊する**
  
  **場合によっては暴走します。**

## DISK ROM

  こちらでは一致するFDCタイプを特定できませんでした。

  他の機種のDISK.ROMを使用することもできますが

  1. 実機がない場合は難しい
  2. MSX1ではFDD内蔵MSX2/2+/turboRのDISK ROMが動作しない
  3. MSX2/2+ではturboRのDISK ROMが動作しない

  という問題があります。

  **外付けドライブのDISK ROMであれば機種を問わないと思います。**

  ExtentionsからNextor搭載カートリッジを使用するのが確実だと思います。

  - おすすめ

    個人的に簡単でお勧めなのは```Carnivore2```Extentionです。  
    設定はダウンロードしたファイルを所定の位置に配置するだけで準備完了。  
    あとは、CatapultからHard Disk Driveへイメージファイルを指定して起動すればOKです。

    ただし、MSX-MUSICや大容量マッパRAMなど追加機能がついているので、
    それを使ってしまうとMSX0で動かないと思います。

 
### Extension: 外付けFDD 

**要吸出し**

  - Mitsubishi ML-30DC/ML-30FD
  - Panasonic FS-FD1A
  - Sony HBD-20W
  - Sony HBD-50
  - Sony HBD-F1
  - Sony HBK-30
  - Talent DPF-550
  - Talent TDC-600 ... **Nextor** (互換カートリッジはちょくちょく販売されている)
  - Toshiba HX-F101PE
  - Yamaha FD-05/FD-051

### Extension: SD/HDD系

  - CatapultからHDDイメージでHDDイメージファイル指定可能

    - 「Carnivore2」  
      ... SDカード ... [セットアップ方法](https://sysadminmosaic.ru/en/msx/carnivore2/carnivore2#carnivore2_support_in_openmsx) / [ファイル](https://github.com/RBSC/Carnivore2/tree/master/OpenMSX)

  - イメージ操作が大変

    - 「MegaFlashROM SCC+ SD」  
      ... SDカード ... [セットアップ方法](https://www.msx.org/wiki/Emulating_MegaFlashROM_SCC%2B_SD_with_openMSX) ... 設定方法をみるとうんざりするかも…

  - 使い方が分からない
     ... HDDファイルを指定するだけでは駄目な様子

    - 「IDE」
    - 「ESE MEGA-SCSI」

### SDカード(HDD)イメージの編集

  SDイメージのdskファイルはFAT12やFAT16なのでDiskExplorerで操作可能です。

  https://hp.vector.co.jp/authors/VA013937/editdisk/index.html

  フォーマットの自動認識はしないので、
  - プロファイル：[Manual HD]（plain imageの一つ上）
  - フォーマット：[AT形式]（98形式の下）

  を選択すると  「基本領域(FAT)」 がリストに出てくるので、  
  それを選択してOKでイメージ編集ができます。


### 他のFDD ROMを内蔵させる場合

  自分の場合はFractalFDDの物を使用していますが、  
  サンプルのmachine定義ファイルでは分かり易くA1WSXの物を使用しています。

```
	  <!-- DISK ROM に MSX0の物を使用する -->
	  <!-- Not working
      <secondary slot="3">
        <TC8566AF id="Memory Mapped FDC">
          <io_regs>7FF8</io_regs>
          <mem base="0x4000" size="0x8000"/>
          <rom>
            <filename>MSX0_DISK.ROM</filename>
            <sha1>82B374E37D47781AF4B46DFA456CAA2885C501EB</sha1>
          </rom>
          <drives>1</drives>
        </TC8566AF>
      </secondary>
	  -->
	  <!-- DISK ROM に A1WSXの物を使用する -->
      <secondary slot="3">
        <TC8566AF id="Memory Mapped FDC">
          <io_regs>7FF8</io_regs>
          <drives>1</drives>
          <rom>
            <filename>fs-a1wsx_disk.rom</filename>
            <sha1>7ed7c55e0359737ac5e68d38cb6903f9e5d7c2b6</sha1>
          </rom>
          <mem base="0x4000" size="0x8000"/>
        </TC8566AF>
      </secondary>
	  <!-- DISK ROM に Fractal FDDを使用する -->
	  <!--
      <secondary slot="3">
        <TDC600 id="TDC600">
          <drives>1</drives>
          <mem base="0x0000" size="0xC000"/>
          <rom>
            <filename>TDC600.rom</filename>
            <sha1>29cacf13e45447a9e6d336483935ccb44b3b2d5d</sha1>
          </rom>
        </TDC600>
      </secondary>
      -->
```

---

## File list

|Name               |SHA1                                    |Bytes   |
|-------------------|----------------------------------------|------- |
|MSX0_MSX1_MAIN.ROM |64BFD8D76E7C9578D7A4CBE95AEB30E7F3482366| 32,768 |
|MSX0_MSX1_SUB.ROM  |488B66ED303EF8645414F3681361427C2FB5B09A| 16,384 |
|MSX0_MSX2_MAIN.ROM |80772A4BE733EB59ED8CE4E79C44EB03F4C3C5D6| 32,768 |
|MSX0_MSX2_SUB.ROM  |488B66ED303EF8645414F3681361427C2FB5B09A| 16,384 |
|MSX0_MSX2P_MAIN.ROM|5F8CF3B01C5C8A91503949482024B94585BFD26D| 32,768 |
|MSX0_MSX2P_SUB.ROM |17D5112666450FAAEBA85E1055A6504D4804EA01| 16,384 |
|MSX0_XBASIC.ROM    |AF0319E594E170B791703F0ECE184C0805F15E2C| 32,768 |
|MSX0_DISK.ROM      |82B374E37D47781AF4B46DFA456CAA2885C501EB| 32,768 |
|MSX0_DOS2.ROM      |BCC68F70DC430B0D47749D48C13522D29E36285B| 65,536 |
|MSX0_IOT.ROM       |ACC8E4EADAA733C2D91B035935D17A93B7125E9E| 16,384 |
|MSX0_KANJI.ROM     |DCC3A67732AA01C4F2EE8D1AD886444A4DBAFE06| 32,768 |
|MSX0_KANJI_FONT.ROM|5AFF2D9B6EFC723BC395B0F96F0ADFA83CC54A49|262,144 |

Total  12 Files  589,824 Bytes

---

## ROMイメージの取得 (自動)

hra!さんのdump toolが手軽で良いかと思います。

https://github.com/hra1129/for_MSX0/tree/main/dump_tool/for_msx0_bios

**取得したROMファイルは、MSX0所有者のみが使用できます。**

- ダンプされるファイル名との対応

  |dump name   |Name               |SHA1                                    |Bytes   |
  |------------|-------------------|----------------------------------------|------- |
  |msx0bios.rom|MSX0_MSX1_MAIN.ROM |64BFD8D76E7C9578D7A4CBE95AEB30E7F3482366| 32,768 |
  |msx0ext.rom |MSX0_MSX1_SUB.ROM  |488B66ED303EF8645414F3681361427C2FB5B09A| 16,384 |
  |msx0bios.rom|MSX0_MSX2_MAIN.ROM |80772A4BE733EB59ED8CE4E79C44EB03F4C3C5D6| 32,768 |
  |msx0ext.rom |MSX0_MSX2_SUB.ROM  |488B66ED303EF8645414F3681361427C2FB5B09A| 16,384 |
  |msx0bios.rom|MSX0_MSX2P_MAIN.ROM|5F8CF3B01C5C8A91503949482024B94585BFD26D| 32,768 |
  |msx0ext.rom |MSX0_MSX2P_SUB.ROM |17D5112666450FAAEBA85E1055A6504D4804EA01| 16,384 |
  |msx0xbas.rom|MSX0_XBASIC.ROM    |AF0319E594E170B791703F0ECE184C0805F15E2C| 32,768 |
  |msx0dos.rom |MSX0_DISK.ROM      |82B374E37D47781AF4B46DFA456CAA2885C501EB| 32,768 |
  |msx0dos2.rom|MSX0_DOS2.ROM      |BCC68F70DC430B0D47749D48C13522D29E36285B| 65,536 |
  |msx0iot.rom |MSX0_IOT.ROM       |ACC8E4EADAA733C2D91B035935D17A93B7125E9E| 16,384 |
  |msx0kdr.rom |MSX0_KANJI.ROM     |DCC3A67732AA01C4F2EE8D1AD886444A4DBAFE06| 32,768 |
  |msx0kfn.rom |MSX0_KANJI_FONT.ROM|5AFF2D9B6EFC723BC395B0F96F0ADFA83CC54A49|262,144 |


---

## ROMイメージの取得 (手作業)

ROMファイルは自分の所有するMSX0から取得してください。

**取得したROMファイルは、MSX0所有者のみが使用できます。**

漢字フォントROM以外は基本的に```saverom.com```で保存可能です。

http://bifi.msxnet.org/msxnet/utils/saverom

### DOS2ROMの吸出し

saverom.comが吸出し後にbank0に戻さないため、暴走して保存に失敗します。

その場合、[tool/DOS2VRAM.BAS](tool/DOS2VRAM.BAS) を使用してみてください。

128KBのファイルが2つ出来ます。

1. DOS2-0.BIN
2. DOS2-1.BIN

Windowsなどのバイナリエディタで、  
それぞれ先頭の7バイトを削除したものを  
1つに合体させてください。

### 漢字フォントROMの吸出し

BlueMSXのResource Pageにある、KANJIROM.BASで吸出し出来ます。

http://bluemsx.msxblue.com/resource.html

> Kanjirom dump tool	[KANJIROM](http://bluemsx.msxblue.com/rel_download/dump/KANJIROM.zip) (JIS 1st Class/Hangul or JIS 1st and 2nd Class - on MSXturboR, press on "1" key when booting)

と書いてあるリンクからKANJIROM.ZIPをダウンロードして使用してください。

#### 吸出しに失敗する場合

1. 1を押しながら起動してDOS1モードにする。
2. あらかじめダミーでKANJI.ROMを作成しておく。

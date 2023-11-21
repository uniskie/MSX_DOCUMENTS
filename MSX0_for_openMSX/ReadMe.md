# MSX0 M5stack Core2 machine defines for openMSX

OpenMSXでMSX0 M5stack Core2から吸い出したROMで起動するための定義ファイルです。

1. Windowsは ```%USERPROFILE%\Documents\OpenMSX\share\machines```
2. Unixは ```~/.openMSX/share/machines```

に配置してください。

1. [MSX0_M5stack_Core2_MSX1.xml](MSX0_M5stack_Core2_MSX1.xml)
2. [MSX0_M5stack_Core2_MSX2.xml](MSX0_M5stack_Core2_MSX2.xml)
3. [MSX0_M5stack_Core2_MSX2+.xml](MSX0_M5stack_Core2_MSX2+.xml)


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

## DOS2 : 

  4000H - 7FFFH
  BANK SELECT: 6000H
  BANK COUNT: 4

  ※ 割り込み許可状態でバンク0以外にしていると暴走します

## IOT:

  4000H-5FFFh : CALL文拡張（DEVICE拡張もあるが動作しない）
  6000H-7FFFH : おそらくメモリマップドI/O

## DISK ROM

  こちらでは一致するFDCタイプを特定できませんでした。

  他の機種のDISK.ROMを使用することもできますが

  1. 実機がない場合は難しい
  2. MSX1ではFDD内蔵MSX2/2+/turboRのDISK ROMが動作しない
  3. MSX2/2+ではturboRのDISK ROMが動作しない

  という問題があります。

  **外付けドライブのDISK ROMであれば機種を問わないと思います。**

  ExtentionsからNextor搭載カートリッジを使用するのが確実だと思います。

  個人的に簡単でお勧めなのは```Carnivore2```Extentionです。  
  ただし、MSX-MUSICやSCCマッパーRAMなど追加機能がついているので、
  それを使ってしまうとMSX0で動かないと思います。

  （CatapultのHard Disk Driveにイメージファイルを指定して使用します）
 
### 外付けFDD 

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

###  SD/HDD系

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

## ROMの吸出し

　ROMを自分で吸い出してください。  
吸い出したROMは、MSX0を所有している所有者のみが使用できます。

漢字フォントROM以外は基本的に```saverom.com```で可能です。

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

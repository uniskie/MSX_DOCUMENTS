# テクハンWiki & Data-Pack wiki ローカル保存スクリプト

PowerShell 5.1（Windows10）での動作を確認しています。

[MSX2-Technical-HandBook/`make_offline.ps1`](MSX2-Technical-HandBook/`make_offline.ps1`)
... [MSX書籍打ち込み計画①](https://gigamix.hatenablog.com/entry/text2web/)から発展した「MSX2テクニカルハンドブックWiki（MSX Datapack wiki）」をローカル保存して使用できるようにダウンロード&変換するスクリプトです

[MSX-Datapack/`make_offline.ps1`](MSX-Datapack/`make_offline.ps1`)
... テクハンwiki化計画に続いて、MSX Datapack wiki化計画で作成された「MSX-Datapack Wki」をローカル保存して使用できるようにダウンロード&変換するスクリプトです

## 実行方法

「`make_offline.ps1`」を右クリックして 「PowerShellで実行」

PowerShell-SEをインストールしている場合は、ダブルクリックしてPowerShell-SEから実行も可能です

自動で各ファイルのダウンロードからローカル変換まで実行します

## 生成される物

- 無加工のhtml → org フォルダ
- 変換後のhtml → カレント フォルダ (`make_offline.ps1`と同じフォルダ）
- スタイルシートや共通画像ファイル → ../theme フォルダ

各サブフォルダは自動で生成されます。

## Poewrshell スクリプト解説

- `make_offline.ps1`  
  → メイン処理。これを実行する。  
     (テクハンwikiとDatapack wikiで共通)

- `unique_data.ps1`  
  → リネームリストなどテクハンwikiとDatapack wikiで異なる部分の定義

### 処理内容

1. トップページをダウンロード

2. オリジナルページのダウンロード

   1. 各ページのURL抽出
   2. ついでにページダウンロード用スクリプト（org/download_html.ps1）も生成  
   3. 各ページの内容をorgフォルダにダウンロード

3. 画像URLの抽出

   1. 共通パーツ画像やスタイルシートはスクリプトコードにurlリストを埋め込み
   2. 各ページの画像(PNG,SVG、JPG)のURLを抽出

   （最後にまとめてimgフォルダやthemeフォルダにダウンロード）

4. 相対指定URLへの変換

	1. imgフォルダに置いた画像へのリンクに書き換え
	2. リネームしたファイルへリンクを書き換え  
	   このあと、カレントフォルダへの保存する際にファイル名を変更して保存するので、
	   それに合わせてリンクも書き換え

5. 書き換えた各ページファイルをカレントフォルダ（`make_offline.ps1`を実行したフォルダ）に保存
   その際、部や章の順番になるようにファイル名に変更して保存

6. 抽出した画像URLをダウンロード

	1. themeフォルダの共通パーツをダウンロード
	2. imgフォルダにページ毎の画像をダウンロード
    3. ついでに画像ダウンロード用スクリプト（download_image.ps1）も生成

以上で、オフラインで閲覧できるファイルセットが出来ます


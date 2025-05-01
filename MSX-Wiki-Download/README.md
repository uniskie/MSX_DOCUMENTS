# テクハンWiki & MSX-Datapack wiki ローカル保存スクリプト

PowerShell 5.1（Windows10）での動作を確認しています。

[MSX2-Technical-HandBook/`make_offline.ps1`](MSX2-Technical-HandBook/`make_offline.ps1`)
... [MSX書籍打ち込み計画①](https://gigamix.hatenablog.com/entry/text2web/)から発展した「MSX2テクニカルハンドブックWiki（MSX Datapack wiki）」をローカル保存して使用できるようにダウンロード&変換するスクリプトです

[MSX-Datapack/`make_offline.ps1`](MSX-Datapack/`make_offline.ps1`)
... テクハンwiki化計画に続いて、MSX Datapack wiki化計画で作成された「MSX-Datapack Wki」をローカル保存して使用できるようにダウンロード&変換するスクリプトです

## 数式について

MSX-Datapack WikiはTeX数式の表示にGoogle Charts APIを使用していますが、サービスが終了しているので表示されません。

本スプリプトでオフライン化する際に
[KATEX](https://github.com/KaTeX/KaTeX)
または
[MathJax](https://www.mathjax.org/)
を使用するように変更します。  

ただし、表示にはオンライン接続が必要です。

レンダリング自体はオフラインですが、
スクリプトやフォントの読み込みがサーバ経由になるためです。

> これはブラウザセキュリティポリシーの都合で、
> jsファイル以外の、css、fontなどをURLアクセス使用して読み込むのですが、
> ここで対象がローカルファイルの場合はセキュリティエラーが出てしまいます。
>
> このエラーを強制的に解除するモードでブラウザを起動すれば動きますが、危険だし面倒ですね。
>
> 自分でローカルwebサーバを立てる方法もありますが、これも面倒です。

他に完全オフラインで使用できる方法があればそちらに切り替えたい所です。


### 書式の互換性

  Google Charts APIはLaTeX系（MathJax・KATEX）よりも文法が緩いため、
  そのままではエラーの出る箇所が多々ありました。
  
  おそらく、作業中のまま放置されていたのか、
  記述された式そのものが間違っている箇所などもあります。
  
  こちらで把握できるものは、オフライン変換時に修正を施していますが、
  気づいていない間違いなどが残っている可能性があります。


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
  メイン処理。  
  これを実行する。  
  - (テクハンwikiとDatapack wikiで共通)

- `_unique_data.ps1`  
  リネームリストなどテクハンwikiとDatapack wikiで異なる部分の定義

- `_hook.ps1`  
  追加置換処理  
  - obsidianにコピペしてmd化するための準備  
    （githubに上げている物は何もせずに戻ります）

- `_TeX.ps1`  
  TeX記述部 置換処理  
  MSX-Datapack Wikiで数式がSVG化されていない箇所の対策
  - Google Charts API廃止で表示されなくなっていたので、LATEX式に置換
  - 置換したLATEX式の箇所はデフォルトでKATEXのスクリプトをオンライン参照して
    数式をレンダリングするようにしています。
    そのため完全オフラインだと数式が表示されない箇所があります。
    （SVGにするなど何とかしたい所）

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

（※ 一部の数式表示にはオンライン接続が必要です）

## TEX（数式）

_TeX.ps1 ファイルを弄ると、TEX変換方法を変更できます
githubに置いてあるものは$use_KATEXが有効です。

### KATEXを使用する場合:
```
#$use_MathJax            = $True     ;# MathJaxを使用する (機能豊富・古い)
$use_KATEX              = $True     ;# KATEXを使用する (軽量・新しい)
```

### MathJaxを使用する場合:
```
$use_MathJax            = $True     ;# MathJaxを使用する (機能豊富・古い)
#$use_KATEX              = $True     ;# KATEXを使用する (軽量・新しい)
```

### その他出力

オフライン変換時はTeXのチェック用にいくつかのログファイルも吐き出します。

- tex_cmd_list.txt
  ... 使用されている\付きコマンドの一覧

- tex_list.txt
  ... htmlに出力されているTeX文字列の一覧

- tex_log.txt
  ... 作業ログ

  1. 変換後のTeX文字列
  2. org:元HTMLの該当個所
  3. dec:元HTMLの該当個所のTeX文字列をURIデコードしたもの
  4. new:変換後HTMLの該当個所

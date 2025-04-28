# ユニークデータ include
.'./unique_data.ps1'

##############################################################################
# 共有データ
##############################################################################
$common_dl = @(
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/kugi01.css.js'
		'..\theme\kugi01\kugi01.css.js'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/kugi01.css'
		'..\theme\kugi01\kugi01.css'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/jquery-1.12.4.min.js'
		'..\theme\kugi01\jquery-1.12.4.min.js'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_menu_white_36dp.png'
		'..\theme\kugi01\ic_menu_white_36dp.png'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_more_vert_white_36dp.png'
		'..\theme\kugi01\ic_more_vert_white_36dp.png'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_search_white_36dp.png'
		'..\theme\kugi01\ic_search_white_36dp.png'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_fontsize_white_36dp.png'
		'..\theme\kugi01\ic_fontsize_white_36dp.png'
	),
	@(	'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_toc_white_36dp.png'
		'..\theme\kugi01\ic_toc_white_36dp.png'
	)
)

##############################################################################
# ファイルスコープ オブジェクト
##############################################################################
$cd = (Convert-Path .)
$cgi_url = 'http://ngs.no.coocan.jp/doc/wiki.cgi/'
$org_dir = 'org'
$img_dir = 'img'
$theme_dir = '..\theme\kugi01'

#Add-Type -AssemblyName System;
#Add-Type -AssemblyName System.IO;
Add-Type -AssemblyName System.Web
$sjis = [System.Text.Encoding]::GetEncoding("Shift_JIS")
$enc  = [System.Text.Encoding]::GetEncoding("EUC-JP")

$g_hash = @{}
$g_img_hash = @{}

##############################################################################
# サブルーチン
##############################################################################

#-----------------------------------------------------------------------------
# 左詰め
#-----------------------------------------------------------------------------
function leftAlignStr ($str, $len) {
	$l = $sjis.GetByteCount($str)
	$pad = $len - $l
	if ($pad -lt 1) {
		return $str
	}
	return ($str + (" " * $pad))
}

#-----------------------------------------------------------------------------
# URLデコード
#-----------------------------------------------------------------------------
function decodeURI( $url ) {
	$unicode = [Text.Encoding]::Unicode
	$r = [System.Web.HttpUtility]::UrlDecode($url, $enc)

	#2段デコードが必要なケースがある
	while (($r.IndexOf('%') -ge 0 ) -or ($r.IndexOf('+') -ge 0)) {
		$r = [System.Web.HttpUtility]::UrlDecode($r, $enc)
	}
	return $r
}

#-----------------------------------------------------------------------------
# ダウンロードメッセージの表示
#-----------------------------------------------------------------------------
function ShowDlMessage( $mes, $filepath, $url) {
	if ($url.Length) {
		Write-Host "${mes}: ${filepath} ... url:${url}"
	} else {
		Write-Host "${mes}: ${filepath}"
	}
}

#-----------------------------------------------------------------------------
# サブフォルダを作成する
#-----------------------------------------------------------------------------
function MakeSubDir($name) {
	$d = (Join-Path $cd $name)
	if (Test-Path $d) { return }
	$r = New-Item -Path $cd -Name $name -ItemType "Directory"
	return
}

##############################################################################
# オリジナルのダウンロード
##############################################################################
function downloadOriginal ($cgi_url, $type, $root_dir, $sub_dir, $log) {
	#-----------------------------------------------------------------------------
	# index.htmlのダウンロード
	#-----------------------------------------------------------------------------
	$req = $type + '\?page='
	$index_url = $cgi_url + $type

	$dir = (Join-Path $root_dir $sub_dir)
	$name = 'index.html'
	$index_file = (Join-Path $dir $name)

	if (Test-Path $index_file) {
			ShowDlMessage ("Already Downloaded") (Join-Path $sub_dir $name) ($index_url)
	} else {
		try {
			ShowDlMessage ("Download") (Join-Path $sub_dir $name) ($index_url)
			Invoke-WebRequest $index_url -OutFile $index_file
		} catch {
			Write-Host "Download Error"
		}
	}

	#-----------------------------------------------------------------------------
	# 解析&出力開始
	#-----------------------------------------------------------------------------
	# EUCとしてテキストファイルを読み込む
	try {
		Write-Host "Read :${index_file}"
		$content = [IO.File]::ReadAllLines( $index_file, $enc )
		$text = $content -join '`n'
	} catch {
		Write-Host "Read error"
		return
	}
	#$text

	#url抽出 & ダウンロード
	$urls = [regex]::Matches( $text, $req + '(?<name>[^"]+)')
	if ($urls.Success) {

		'# PowerShell で実行してください。'  > $log
		'Add-Type -AssemblyName System.Web' >> $log
		''                                  >> $log
		'$list = @('                        >> $log

		foreach ($i in $urls) {
			$url = $cgi_url + $i.Groups[0].value
			$name = $i.Groups["name"].value + ".html"

			#URIデコード
			$name = decodeURI $name
			$name = $name -replace '[\?\:\/\\]',''	;# ファイル名に使えない文字を処理

			if ($g_hash[$name]) {continue} ;# 重複を飛ばす
			$g_hash[$name] = $true

			if ($name.IndexOf('&amp;action=') -ge 0) {continue} ;#特殊urlは飛ばす

			#ダウンロード
			$out = (Join-Path $dir $name)
			if (Test-Path $out) {
				ShowDlMessage ("Already Downloaded") (Join-Path $sub_dir $name) ($url)
				#ダウンロード済
			} else {
				ShowDlMessage ("Download") (Join-Path $sub_dir $name) ($url)
				Invoke-WebRequest $url -OutFile $out
			}

			#リストに追加
			$n = (leftAlignStr ("'"+$name+"'") 52)
			$u = "'"+$url+"'"
			"    @(${n}, ${u}),"                     >> $log
		}
		'    @("","")'                               >> $log
		')'                                          >> $log
		''                                           >> $log
		'foreach ($i in $list) {'                    >> $log
		'    if ($i[0] -eq "") {continue}'           >> $log
		'    "Download: {0}" -f $i[1]'               >> $log
		'    Invoke-WebRequest $i[0] -OutFile $i[1]' >> $log
		'}'                                          >> $log


		return
	}
}

##############################################################################
# ファイルの加工
##############################################################################

#-----------------------------------------------------------------------------
# URLデコードが必要なURLのリストを作成
# @(元のURL、拡張子補正+デコードしたURL) 
# の配列
#-----------------------------------------------------------------------------
function get_encoded_urls( $text ) {
	$r = @()
	$hash = @{}

	$urls = [regex]::Matches( $text, '(src|href|name)="(?<url>[^"]+)')
	if (-not $urls.Success) {
		return ,$r
	}

	foreach ($i in $urls) {
		$s = $i.Groups["url"].value

		# URLエンコードされていなければ無視
		if (($s.IndexOf('%') -lt 0) -and ($s.IndexOf('+') -lt 0)) {
			continue;
		}

		#重複を無視
		if ($hash[$s]) {continue}
		$hash[$s] = $true

		# 拡張子検査：なければhtmlファイルと見なす
		$m = [regex]::Matches( $s, '[^/]+$')
		if ($m.Success) {
			$name = $m.value
			$dir = $s.subString(0, $s.length - $name.length)
		} else {
			$name = "index.html"
			$dir = $s
		}

		if (($name.IndexOf('.') -lt  0) -or ($name.IndexOf('?') -gt -1)) {
			if ($name.IndexOf('.html') -lt 0) {
				$name = $name + '.html';
			}
		}
		$f = $dir + $name

		#URIデコード
		$dname = decodeURI $name
		$dname = $dname -replace '[\?\:\/\\]',''	;# ファイル名に使えない文字を処理
		$d = (decodeURI $dir)+$dname

		# @(元のURL、拡張子補正+デコードしたURL) のセット配列
		$r += ,@($s, $d)
	}
	return ,$r
}

#-----------------------------------------------------------------------------
# リスト出力
#-----------------------------------------------------------------------------
function writeDownloadList( $list, $dstfile ) {
	$ls = @()
	if ($list.Count) {
		foreach ($i in $list) {
			$url = $i[0]
			$dst = $i[1]
			$l = "    @{dst='${dst}'; url='${url}'},"
			$ls += ,$l
		}
		$ls  >> $dstfile
		"" >> $dstfile
	}
}

#-----------------------------------------------------------------------------
# 画像URL抽出
#-----------------------------------------------------------------------------
function get_img_utl( $text ) {
	$r = @()

	$urls = [regex]::Matches( $text, 'https?://[^"\n\)]+\.(png|jpeg|jpg|gif|svg)')
	if (-not $urls.Success) {
		return ,$r
	}

	foreach ($i in $urls) {
		$url = $i.value

		$path = $url -replace '"',''
		$name = [regex]::Match($path,'/[^/]+$').value
		if ($name -eq '') {
			$name = $path
		}
		$name = decodeURI $name
		$name = $name -replace '[\?:/\\]',''	;# ファイル名に使えない文字を処理
		
		$url = $path;
		$m = [regex]::Match($url,'^https?://')
		if (-not $m.Success) {
			$url = $base_url + $url;
		}
		$dst = (Join-Path $img_dir $name)

		# 重複を無視
		if ($g_img_hash[$dst] -eq $url) {continue}
		if ($g_img_hash[$dst].Length) {
			# 違う値で既に存在
			ShowDlMessage ("[CAUTION] Different value") ($g_img_hash[$dst]) ($url)
		}
		$g_img_hash[$dst] = $url

		$r += ,@($url, $dst)
	}

	return ,$r
}

#-----------------------------------------------------------------------------
# htmlファイルを処理する
#-----------------------------------------------------------------------------
function porc_html( $fname ) {
	$text = ""
	$eurl = @()
	$img_list = @()

	## テキスト読み込み
	$fpath = (Join-Path $cd $fname)
	try {
		# EUCとしてテキストファイルを読み込む
		#$content = [IO.File]::ReadAllLines( $fpath, $enc ) ;# 行ごとに読み込み
		#$text = $content -join "`n"                        ;# 改行文字で繋げる
		$text = [IO.File]::ReadAllText( $fpath, $enc )
    } catch {
	    return @{
		    text = $text
		    eurl = $eurl
		    img_list = $img_list
	    }
    }

	## 事前加工
	#  svgファイル表示タグをembedからimgに変更
	$text = $text -replace 'embed class="wikiimage" type="image/svg\+xml"','img class="wikiimage"'
	#  cgi pageコマンド削除
	$text = $text -replace "${type}\?page=",''
	#  cgi action SEARCH リンク削除
	$text = $text -replace ('<a href="' + $type + '\?action=SEARCH[^>]+>([^<]+)</a>'), '$1'
	$text = $text -replace ('# \[([^\]]+)\]\(' + $type + '\?action=SEARCH[^\)]+\)'), '# $1'
	#  ソースコード対策（Markdownへのコピペ向け）
	$text = $text -replace '<pre>', '<pre><code>'
	$text = $text -replace '</pre>', '</code></pre>'


	## 画像ダウンロードリストを取得
	$img_list = get_img_utl $text

	## 画像URLをimgフォルダへの相対パスへ変更
	$text = $text -replace 'https?://[^"\)]*/([^"/>\)]+\.)(png|jpg|gif|jpeg|svg)', ($img_dir + '/$1$2')

	## URL変換 (""で囲んでいる物のみ)
	$eurl = get_encoded_urls $text
	foreach ($i in $eurl) {
		$s = '"' + ($i[0].replace(' ', '%20')) + '"'
		$d = '"' + ($i[1].replace(' ', '%20')) + '"'
		$text = $text.Replace( $s, $d )
	}

	## ファイル名変換 (""で囲んでいる物のみ)
	foreach ($i in $list) {
		$s = '"'+$i[0].replace(' ', '%20')+'.html"'
		$d = '"'+$i[1].replace(' ', '%20')+'.html"'
		$text = $text.Replace( $s, $d )
	}

	return @{
		text = $text
		eurl = $eurl
		img_list = $img_list
	}
}

##############################################################################
# メイン処理
##############################################################################

#-----------------------------------------------------------------------------
# ファイル名を修正する
#-----------------------------------------------------------------------------
foreach ($i in $list)
{
	$src = $i[0]
	$dst = $i[1]

	$s = $src + ".html"
	$d = $dst + ".html"
	if (Test-Path $s) {
		Rename-Item -Path $s -NewName $d
	}

	$s = $src + ".md"
	$d = $dst + ".md"
	if (Test-Path $s) {
		Rename-Item -Path $s -NewName $d
	}
}

#-----------------------------------------------------------------------------
# フォルダ検査
#-----------------------------------------------------------------------------
MakeSubDir $org_dir
MakeSubDir $img_dir
MakeSubDir $theme_dir

#-----------------------------------------------------------------------------
# オリジナルダウンロード実行
#-----------------------------------------------------------------------------
$log = Join-Path $org_dir 'download_html.ps1'
downloadOriginal ($cgi_url) ($type) ($cd) ($org_dir) (Join-Path $cd $log)

#return

#-----------------------------------------------------------------------------
# html 解析＆変換＆抽出
#-----------------------------------------------------------------------------
#if (Test-Path log.txt) { Remove-Item -Path log.txt }

$img_list_file = 'download_image.ps1'

'# PowerShell で実行してください。'  > $img_list_file
'Add-Type -AssemblyName System.Web' >> $img_list_file
""                                  >> $img_list_file
'$list = @('                        >> $img_list_file

$img_list = @()

#-----------------------------------------------------------------------------
# 共通画像
#-----------------------------------------------------------------------------
if ($common_dl.Length) {
	$img_list += ,@{
		target = "common"
		list   = $common_dl
	}
	foreach($i in $common_dl) {
		$img_list += ,$i
		$g_img_hash[$dst] = $i[0] ;# URLをハッシュに追加
	}
	"# common"                       >> $img_list_file
	writeDownloadList $common_dl $img_list_file
}

#-----------------------------------------------------------------------------
# ファイル毎に処理
#-----------------------------------------------------------------------------
foreach ($target in $list) {

	$src_file = 'org\' + $target[0] + '.html'
	$out_file = $target[1] + '.html'

	#if ($target[0] -ne $list[7][0]) { continue }

	if (-not (Test-Path $src_file)) { continue }

	Write-Host ("Convert: " + $target[1])

	#("#"+$target[1])                                >> log.txt

	$r = porc_html $src_file

	if ($r["text"].Length) {
		
		$img_list += ,@{
			target = $target[1]
			list   = $r["img_list"]
		}

		##変換後のhtmlを書き出し
		#                                   > $out_file
		# EUCとしてテキストファイルを読み込む
		$wr = [IO.File]::WriteAllText( $out_file, $r["text"], $enc )

		#$r["text"]                                  > conv.html
		#$r["eurl"]                                  > eurl.txt
		#$r["img_list"]                              > img_list.txt
		if ($r["img_list"].Length) {
			("#"+$target[1])                         >> $img_list_file
			writeDownloadList $r["img_list"] $img_list_file
		}
	}
}
'    @{dst=""; url=""}'                                  >> $img_list_file
')'                                                      >> $img_list_file
''                                                       >> $img_list_file
'foreach ($i in $list) {'                                >> $img_list_file
'    if ($i["dst"] -eq "") {continue}'                   >> $img_list_file
'    if (Test-Path $i["dst"]) {'                         >> $img_list_file
'        "Already Downloaded: {0}" -f $i["dst"]'         >> $img_list_file
'    } else {'                                           >> $img_list_file
'        "Download: {0}" -f $i["dst"]'                   >> $img_list_file
'        Invoke-WebRequest $i["url"] -OutFile $i["dst"]' >> $img_list_file
'    }'                                                  >> $img_list_file
'}'                                                      >> $img_list_file

#-----------------------------------------------------------------------------
# イメージファイルのダウンロード実行
#-----------------------------------------------------------------------------
foreach ($t in $img_list) {
	$target = $t["target"]
	if ($t["list"].Count -eq 0) {continue}
	Write-Host "# ${target}"
	foreach ($i in $t["list"]) {
		$url = $i[0]
		$dst = $i[1]
		if ($dst -eq "") {continue}
		if (Test-Path ($dst)) {
			ShowDlMessage ("Already Downloaded") ($dst) ""
		} else {
			ShowDlMessage ("Download") ($dst) ""
			Invoke-WebRequest $url -OutFile $dst
		}
	}
}

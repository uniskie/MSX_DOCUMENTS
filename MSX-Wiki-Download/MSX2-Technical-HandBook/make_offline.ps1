##############################################################################
$type = 'TechHan'
$list = @(
	@('BugTrack-techhan11',                         'BugTrack-techhan11'                         ),
	@('BugTrack-techhan12',                         'BugTrack-techhan12'                         ),
	@('BugTrack-techhan13',                         'BugTrack-techhan13'                         ),
	@('BugTrack-techhan14',                         'BugTrack-techhan14'                         ),
	@('FrontPage',                                  'FrontPage'                                  ),
	@('Help',                                       'Help'                                       ),
	@('修正履歴',                                   '修正履歴'                                   ),
	@("まえがき",                                   "0-0 まえがき"                               ),
	@("はじめに",                                   "0-1 はじめに"                               ),
	@("本書を読む前に",                             "0-2 本書を読む前に"                         ),
	@("1部 ｼｽﾃﾑ概要",                               "1部 システム概要"                           ),
	@("1章 MSX1からMSX2へ",                         "1部-1章 MSX1からMSX2へ"                     ),
	@("2章 MSX2システム概要",                       "1部-2章 MSX2システム概要"                   ),
	@("2部 BASIC",                                  "2部 BASIC"                                  ),
	@("1章 命令一覧",                               "2部-1章 命令一覧"                           ),
	@("1.1 MSX BASIC ver2.0の命令",                 "2部-1章-1.1 MSX BASIC ver2.0の命令"         ),
	@("1.2 MSX DISK-BASICの命令",                   "2部-1章-1.2 MSX DISK-BASICの命令"           ),
	@("2章 MSX BASIC ver2.0 の変更点",              "2部-2章 MSX BASIC ver2.0 の変更点"          ),
	@("3章 BASICの内部構造",                        "2部-3章 BASICの内部構造"                    ),
	@("4章 マシン語とのリンク",                     "2部-4章 マシン語とのリンク"                 ),
	@("5章 ソフトウェア開発上の諸注意",             "2部-5章 ソフトウェア開発上の諸注意"         ),
	@("エラーコード一覧表",                         "2部-付録 エラーコード一覧表"                ),
	@("3部 MSX-DOS",                                "3部 MSX-DOS"                                ),
	@("1章 概要",                                   "3部-1章 概要"                               ),
	@("2章 操作",                                   "3部-2章 操作"                               ),
	@("3章 ディスクファイルの構造",                 "3部-3章 ディスクファイルの構造"             ),
	@("4章 システムコールの使用法",                 "3部-4章 システムコールの使用法"             ),
	@("第4部 VDPと画面表示",                        "4部 VDPと画面表示"                          ),
	@("1章 MSX-VIDEOの構成",                        "4部-1章 MSX-VIDEOの構成"                    ),
	@("2章 MSX-VIDEOのアクセス",                    "4部-2章 MSX-VIDEOのアクセス"                ),
	@("3章 MSX2の画面モード",                       "4部-3章 MSX2の画面モード"                   ),
	@("4章 画面表示に関する諸機能",                 "4部-4章 画面表示に関する諸機能"             ),
	@("5章 スプライト",                             "4部-5章 スプライト"                         ),
	@("6章 VDPコマンドの使用法",                    "4部-6章 VDPコマンドの使用法"                ),
	@("第5部 BIOSによる周辺装置のアクセス",         "5部 BIOSによる周辺装置のアクセス"           ),
	@("1章 PSGと音声出力",                          "5部-1章 PSGと音声出力"                      ),
	@("2章 カセット･インターフェイス",              "5部-2章 カセット･インターフェイス"          ),
	@("3章 キーボード・インターフェイス",           "5部-3章 キーボード・インターフェイス"       ),
	@("4章 プリンタ・インターフェイス",             "5部-4章 プリンタ・インターフェイス"         ),
	@("5章 汎用入出力インターフェイス",             "5部-5章 汎用入出力インターフェイス"         ),
	@("6章 CLOCKとバッテリバックアップ・メモリ",    "5部-6章 CLOCKとバッテリバックアップ・メモリ"),
	@("7章 スロットとカートリッジ",                 "5部-7章 スロットとカートリッジ"             ),
	@("Appendix A.1 BIOS 一覧",                     "Appendix A.1 BIOS 一覧"                     ),
	@("Appendix A.2 Math-Pack",                     "Appendix A.2 Math-Pack"                     ),
	@("Appendix A.3 ビットマップトランスファ",      "Appendix A.3 ビットマップトランスファ"      ),
	@("Appendix A.4 ワークエリア一覧",              "Appendix A.4 ワークエリア一覧"              ),
	@("Appendix A.5 VRAM マップ",                   "Appendix A.5 VRAM マップ"                   ),
	@("Appendix A.6 IO マップ",                     "Appendix A.6 IO マップ"                     ),
	@("Appendix A.7 カートリッジ ハードウェア仕様", "Appendix A.7 カートリッジ ハードウェア仕様" ),
	@("Appendix A.8 コントロールコード表",          "Appendix A.8 コントロールコード表"          ),
	@("Appendix A.9 キャラクタコード表",            "Appendix A.9 キャラクタコード表"            ),
	@("Appendix A.10 エスケープシーケンス表",       "Appendix A.10 エスケープシーケンス表"       )
)

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
# ダウンロードメッセージ
#-----------------------------------------------------------------------------
function ShowDlMessage( $mes, $dst, $url) {
	if ($url.Length) {
		Write-Host "${mes}: ${dst} ... url:${url}"
	} else {
		Write-Host "${mes}: ${dst}"
	}
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

		#重複を無視
		if ($g_img_hash[$dst] -eq $url) {continue}
		if ($g_img_hash[$dst].Length) {
			#違う値で既に存在
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

	# 事前加工
	#  svgファイル表示タグをembedからimgに変更
	$text = $text -replace 'embed class="wikiimage" type="image/svg\+xml"','img class="wikiimage"'
	#  cgi pageコマンド削除
	$text = $text -replace "${type}\?page=",''
	#  cgi action SEARCH リンク削除
	$text = $text -replace ('<a href="' + $type + '\?action=SEARCH[^>]+>([^<]+)</a>'), '$1'
	$text = $text -replace ('# \[([^\]]+)\]\(' + $type + '\?action=SEARCH[^\)]+\)'), '# $1'

	# 画像ダウンロードリストを取得
	$img_list = get_img_utl $text

	# 画像URLをimgフォルダへの相対パスへ変更
	$text = $text -replace 'https?://[^"\)]*/([^"/>\)]+\.)(png|jpg|gif|jpeg|svg)', ($img_dir + '/$1$2')

	# URL変換 ""で囲んでいる物のみ
	$eurl = get_encoded_urls $text
	foreach ($i in $eurl) {
		$s = '"' + ($i[0].replace(' ', '%20')) + '"'
		$d = '"' + ($i[1].replace(' ', '%20')) + '"'
		$text = $text.Replace( $s, $d )
	}

	# ファイル名変換 ""で囲んでいる物のみ
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
function MakeSubDir($name) {
	$d = (Join-Path $cd $name)
	if (Test-Path $d) { return }
	$r = New-Item -Path $cd -Name $name -ItemType "Directory"
	return
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

# 共通画像
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

# ファイル毎に処理
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

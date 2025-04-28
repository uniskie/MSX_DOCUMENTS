# ユニークデータ include
.'./_unique_data.ps1'

# 追加処理 include
# function hook_modify_html( $text )
.'./_hook.ps1'

#Add-Type -AssemblyName System;
#Add-Type -AssemblyName System.IO;
Add-Type -AssemblyName System.Web
$sjis = [System.Text.Encoding]::GetEncoding("Shift_JIS")
$enc  = [System.Text.Encoding]::GetEncoding("EUC-JP")

##############################################################################
# グローバル定数
##############################################################################
$cd = (Convert-Path .)
$cgi_url = 'http://ngs.no.coocan.jp/doc/wiki.cgi/'
$org_dir = 'org'
$img_dir = 'img'
$theme_dir = '..\theme\kugi01'

$dir_list = @(
    $org_dir
    $img_dir
    $theme_dir
)

$log = (Join-Path $org_dir 'download_html.ps1')
$img_list_file = 'download_image.ps1'

##############################################################################
# 共有データ
##############################################################################
$common_dl = @(
    ## katex
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.css'
		'..\theme\katex\katex.css'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.js'
		'..\theme\katex\katex.js'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css'
		'..\theme\katex\katex.min.css'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.js'
		'..\theme\katex\katex.min.js'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.mjs'
		'..\theme\katex\katex.mjs'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.min.js'
		'..\theme\katex\auto-render.min.js'
	),
    @(  'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.mjs'
		'..\theme\katex\auto-render.mjs'
	),

    ## common for MSX-Datapack Wiki / MSX Tecnical Hand Book Wiki
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/kugi01.css.js'
		'..\theme\kugi01\kugi01.css.js'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/kugi01.css'
		'..\theme\kugi01\kugi01.css'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/jquery-1.12.4.min.js'
		'..\theme\kugi01\jquery-1.12.4.min.js'
	),

	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_menu_white_36dp.png'
		'..\theme\kugi01\ic_menu_white_36dp.png'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_more_vert_white_36dp.png'
		'..\theme\kugi01\ic_more_vert_white_36dp.png'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_search_white_36dp.png'
		'..\theme\kugi01\ic_search_white_36dp.png'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_fontsize_white_36dp.png'
		'..\theme\kugi01\ic_fontsize_white_36dp.png'
	),
	@(  'http://ngs.no.coocan.jp/doc/theme/kugi01/ic_toc_white_36dp.png'
		'..\theme\kugi01\ic_toc_white_36dp.png'
	)
)

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
	$ret = [System.Web.HttpUtility]::UrlDecode($url, $enc)

	#2段デコードが必要なケースがある
	while (($ret.IndexOf('%') -ge 0 ) -or ($ret.IndexOf('+') -ge 0)) {
		$ret = [System.Web.HttpUtility]::UrlDecode($ret, $enc)
	}
	return $ret
}

#-----------------------------------------------------------------------------
# ダウンロードメッセージの表示
#-----------------------------------------------------------------------------
function ShowDlMessage( $mes, $filepath, $url) {
	if ($url.Length) {
		Write-Host "${mes}: ${filepath} ... url:${url}"
	}
	else {
		Write-Host "${mes}: ${filepath}"
	}
}

#-----------------------------------------------------------------------------
# サブフォルダを作成する
#-----------------------------------------------------------------------------
function MakeSubDir($name) {
	$d = (Join-Path $cd $name)
	if (Test-Path $d) { return }
	$ret = (New-Item -Path $cd -Name $name -ItemType "Directory")
	return
}

#-----------------------------------------------------------------------------
# 通常文字列を正規表現エスケープする
#-----------------------------------------------------------------------------
function regexEscape( $s ) {
	# [().\^$|?*+{
	return ($s -replace '([\[\(\)\.\\\^\$\|\?\*\+\{])', '\$1')
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
		#ShowDlMessage ("Already Downloaded") (Join-Path $sub_dir $name) ($index_url)
	}
	else {
		try {
			ShowDlMessage ("Download") (Join-Path $sub_dir $name) ($index_url)
			Invoke-WebRequest $index_url -OutFile $index_file
		}
		catch {
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
	}
	catch {
		Write-Host "Read error"
		return
	}
	#$text

	#url抽出 & ダウンロード
	$url_hash = @{}
	$urls = [regex]::Matches( $text, $req + '(?<name>[^"]+)')
	if ($urls.Success) {

		# リストファイル作成
		'# PowerShell で実行してください。'  > $log
		'Add-Type -AssemblyName System.Web' >> $log
		''                                  >> $log
		'$list = @('                        >> $log

		# URL毎の処理
		foreach ($i in $urls) {
			$url = $cgi_url + $i.Groups[0].value
			$name = $i.Groups["name"].value + ".html"

			#URIデコード
			$name = (decodeURI $name)
			$name = $name -replace '[\?\:\/\\]',''  ;# ファイル名に使えない文字を処理

			if ($url_hash[$name]) {continue} ;# 重複を飛ばす
			$url_hash[$name] = $true

			if ($name.IndexOf('&amp;action=') -ge 0) {continue} ;#特殊urlは飛ばす

			#ダウンロード
			$out = (Join-Path $dir $name)
			if (Test-Path $out) {
				#ShowDlMessage ("Already Downloaded") (Join-Path $sub_dir $name) ($url)
				#ダウンロード済
			}
			else {
				ShowDlMessage ("Download") (Join-Path $sub_dir $name) ($url)
				Invoke-WebRequest $url -OutFile $out
			}

			#リストファイルに追加
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
	$ret = @()
	$hash = @{}

	$urls = [regex]::Matches( $text, '(src|href|name)="(?<url>[^"]+)')
	if (-not $urls.Success) {
		return ,$ret
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
		}
		else {
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
		$dname = (decodeURI $name)
		$dname = $dname -replace '[\?\:\/\\]',''    ;# ファイル名に使えない文字を処理
		$d = ((decodeURI $dir) + $dname)

		# @(元のURL、拡張子補正+デコードしたURL) のセット配列
		$ret += ,@($s, $d)
	}
	return ,$ret
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
function get_img_utl( $text, [ref]$img_hash ) {
	$ret = @()

	$urls = [regex]::Matches( $text, 'https?://[^"\n\)]+\.(png|jpeg|jpg|gif|svg)')
	if (-not $urls.Success) {
		return ,$ret
	}

	foreach ($i in $urls) {
		$url = $i.value

		$path = $url -replace '"',''
		$name = [regex]::Match($path,'/[^/]+$').value
		if ($name -eq '') {
			$name = $path
		}
		$name = decodeURI $name
		$name = $name -replace '[\?:/\\]',''    ;# ファイル名に使えない文字を処理
		
		$url = $path;
		$m = [regex]::Match($url,'^https?://')
		if (-not $m.Success) {
			$url = $base_url + $url;
		}
		$dst = (Join-Path $img_dir $name)

		# 重複を無視
		if ($img_hash.Value[$dst] -eq $url) {continue}

		if ($img_hash.Value[$dst].Length) {
			# 違う値で既に存在
			Write-Host ("[CAUTION] Different value: key = " + $dst)
			Write-Host ("prev: " + $img_hash.Value[$dst])
			Write-Host ("new : " + $url)
		}

		$img_hash.Value[$dst] = $url

		$ret += ,@($url, $dst)
	}

	return ,$ret
}

#-----------------------------------------------------------------------------
## テキスト読み込み
#-----------------------------------------------------------------------------
function readFile( $fname ) {
	$fpath = (Join-Path $cd $fname)
	try {
		# EUCとしてテキストファイルを読み込む
		$content = [IO.File]::ReadAllLines( $fpath, $enc ) ;# 行ごとに読み込み
		$text = $content -join "`n"                        ;# 改行文字で繋げる
		#$text = [IO.File]::ReadAllText( $fpath, $enc )
	}
	catch {
        return $Null
	}
    return $text
}

#-----------------------------------------------------------------------------
# latex
#-----------------------------------------------------------------------------
function convert_latex( $text, [ref]$tex_list ) {
	#Write-Host "convert_latex"

	$base = (regexEscape '<img src="http://chart.apis.google.com/chart?cht=tx&chl=')
    $m = [regex]::Matches($text, ($base+"(?<latex>[^`"]+)`"[^>]*>(<br>)?"))
    foreach ($i in $m) {
        $l = $i.Groups["latex"]
        $d = (decodeURI $l)
        #Write-Host $i;###DEBUG###
        #Write-Host $d;###DEBUG###
        $text = $text.Replace($i, ('$$'+$d+'$$'))
        $tex_list.Value += ,@{
            org=$i
            dec=$d
        }
    }
    return $text
}

#-----------------------------------------------------------------------------
# htmlファイルを処理する
#-----------------------------------------------------------------------------
function porc_html( $src_file, [ref]$img_hash, [ref]$tex_list ) {
	$text = ""
	$eurl = @()
	$img_list = @()
    $tex_list = @()

	## テキスト読み込み
    $text = (readFile $src_file)


	if ($text -eq $Null) {
		return @{
			text = $text
			eurl = $eurl
			img_list = $img_list
		}
	}

    ## latex変換
    $text = (convert_latex $text $tex_list);# $tex_listはすでにref

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
    #  wikiの自動リンク削除
    #<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../OFF" target="_blank">数値</a>
    $temp = (regexEscape "<a href=`"${cgi_url}${type}/../")
    $text = $text -replace ($temp + '[^>]+>([^<]+)</a>'), '$1'


    #追加加工処理
    $text = (hook_modify_html $text)

	## 画像ダウンロードリストを取得
	$img_list = (get_img_utl $text $img_hash) ;#$img_hashはすでに参照なのでそのまま渡す

	## 画像URLをimgフォルダへの相対パスへ変更
	$text = $text -replace 'https?://[^"\)]*/([^"/>\)]+\.)(png|jpg|gif|jpeg|svg)', ($img_dir + '/$1$2')

	## URL変換 (""で囲んでいる物のみ)
	$eurl = (get_encoded_urls $text)
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
        tex_list = $tex_list
	}
}

#-----------------------------------------------------------------------------
# ファイル名を修正する
#-----------------------------------------------------------------------------
function rename_all() {
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
}

#-----------------------------------------------------------------------------
# 全てダウンロード
#-----------------------------------------------------------------------------
function download_all() {
    downloadOriginal ($cgi_url) ($type) ($cd) ($org_dir) (Join-Path $cd $log)
}

#-----------------------------------------------------------------------------
# 全てのhtmlファイルを処理
#-----------------------------------------------------------------------------
function proc_all( $common_dl ) {
    #-----------------------------------------------------------------------------
    # html 解析＆変換＆抽出
    #-----------------------------------------------------------------------------
    #if (Test-Path log.txt) { Remove-Item -Path log.txt }

    '# PowerShell で実行してください。'  > $img_list_file
    'Add-Type -AssemblyName System.Web' >> $img_list_file
    ""                                  >> $img_list_file
    '$list = @('                        >> $img_list_file

	$img_list = @()
    $img_hash = @{}
	$tex_list = @()

    #-----------------------------------------------------------------------------
    # 共通画像
    #-----------------------------------------------------------------------------
    if ($common_dl.Length) {
	    $img_list += ,@{
		    target = "common"
		    list   = $common_dl
	    }
	    foreach($i in $common_dl) {
            $key = $i[0]
            $val = $i[1]
		    $img_hash[$key] = $val ;# URLをハッシュに追加
	    }
	    "# common"                       >> $img_list_file
	    writeDownloadList $common_dl $img_list_file
    }

    #-----------------------------------------------------------------------------
    # ファイル毎に処理
    #-----------------------------------------------------------------------------
    foreach ($target in $list) {
		$src = $target[0]
		$dst = $target[1]

	    #if ($dst -ne '4部-9章 YJK方式') { continue }

	    $src_file = (Join-Path $org_dir ($src + '.html'))
	    $out_file = $dst + '.html'

	    if (-not (Test-Path $src_file)) { continue }

    	Write-Host ("Convert: " + $dst)
    	#("#"+$dst)                                          >> log.txt

	    $rp = (porc_html $src_file ([ref]$img_hash) ([ref]$tex_list))
		$text = $rp["text"]
		$eurl = $rp["eurl"]
		$imgl = $rp["img_list"]

	    if ($text.Length) {
		
		    $img_list += ,@{
			    target = $target[1]
			    list   = $imgl
		    }

		    ##変換後のhtmlを書き出し
		    #                                   > $out_file
		    # EUCとしてテキストファイルを保存
            $lines = $text -split "`n"
		    $wr = [IO.File]::WriteAllLines( $out_file, $lines, $enc )
		    #$wr = [IO.File]::WriteAllText( $out_file, $text, $enc )

		    #$text                                           > conv.html
		    #$eurl                                           > eurl.txt
		    #$imgl                                           > img_list.txt
		    if ($imgl.Length) {
			    ("#"+$target[1])                             >> $img_list_file
			    writeDownloadList $img_list $img_list_file
		    }
	    }
    }
    '    @{dst=""; url=""}'                                  >> $img_list_file
    ')'                                                      >> $img_list_file
    ''                                                       >> $img_list_file
    'foreach ($i in $imgl) {'                                >> $img_list_file
    '    if ($i["dst"] -eq "") {continue}'                   >> $img_list_file
    '    if (Test-Path $i["dst"]) {'                         >> $img_list_file
    '        "Already Downloaded: {0}" -f $i["dst"]'         >> $img_list_file
    '    }'                                                  >> $img_list_file
    '    else {'                                             >> $img_list_file
    '        "Download: {0}" -f $i["dst"]'                   >> $img_list_file
    '        Invoke-WebRequest $i["url"] -OutFile $i["dst"]' >> $img_list_file
    '    }'                                                  >> $img_list_file
    '}'                                                      >> $img_list_file
    
    return @{
        img_list = $img_list
        tex_list = $tex_list
    }
}

#-----------------------------------------------------------------------------
# イメージファイルのダウンロード実行
#-----------------------------------------------------------------------------
function download_images( $img_list ) {
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
		    }
		    else {
			    ShowDlMessage ("Download") ($dst) ""
			    Invoke-WebRequest $url -OutFile $dst
		    }
	    }
    }
}


##############################################################################
# メイン処理
##############################################################################

$img_list = @()
$tex_list = @()

#### TEST ####
#$testfile = "4部-9章 YJK方式.html"
#$text = (readFile $testfile)
#$ret = (convert_latex $text ([ref]$tex_list))
#$text = $ret["text"]
#$tex_list
#return

#-----------------------------------------------------------------------------
# 初期化の追加処理
#-----------------------------------------------------------------------------
hook_initialize

#-----------------------------------------------------------------------------
# すべてリネーム
#-----------------------------------------------------------------------------
rename_all

#-----------------------------------------------------------------------------
# フォルダ検査
#-----------------------------------------------------------------------------
foreach ($i in $dir_list) {
	MakeSubDir $i
}

#-----------------------------------------------------------------------------
# 全てダウンロード
#-----------------------------------------------------------------------------
download_all

#-----------------------------------------------------------------------------
# 全てのhtmlファイルを処理
#-----------------------------------------------------------------------------
$ret = (proc_all $common_dl)
$img_list = $ret["img_list"]
$tex_list = $ret["tex_list"]

#-----------------------------------------------------------------------------
# イメージファイルのダウンロード実行
#-----------------------------------------------------------------------------
download_images $img_list

Write-Host "# latex"
Write-Host $tex_list

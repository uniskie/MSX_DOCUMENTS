# ユニークデータ include
.'./_unique_data.ps1'

# 追加処理 include
# function hook_initialize()
# function hook_modify_html( $text )
.'./_hook.ps1'

# TeX 追加処理 include
# function get_TeXlib_name()
# function decode_TeX( $text )
# function add_TeX_lib_header( $text )
# function download_katex_modules()
# function TeX_initialize()
# function TeX_modify_html( $text )
# function log_TeX( $tex_list )
.'./_TeX.ps1'

#Add-Type -AssemblyName System;
#Add-Type -AssemblyName System.IO;
Add-Type -AssemblyName System.Web
$sjis = [System.Text.Encoding]::GetEncoding("Shift_JIS")
$euc  = [System.Text.Encoding]::GetEncoding("EUC-JP")
$utf8_bom = New-Object System.Text.UTF8Encoding $True
$utf8 = New-Object System.Text.UTF8Encoding $False
#-----------------------------------------------------------------------------
# 文字エンコードを設定する
#-----------------------------------------------------------------------------
function set_encode( $encname, $enc ) {
    chcp $enc.CodePage
    $PSDefaultParameterValues['*:Encoding'] = $encname
    $global:OutputEncoding = $enc
    try{ [console]::OutputEncoding = $enc } catch {}
    $Host.UI.RawUI.WindowTitle = "Windows PowerShell (" +  $OutputEncoding.WebName + ")"
}
set_encode 'utf8' $utf8

##############################################################################
# グローバル定数
##############################################################################
$cd = (Convert-Path .)
$cgi_url = 'http://ngs.no.coocan.jp/doc/wiki.cgi/'

#-----------------------------------------------------------------------------
$type_datapack  = 'datapack'
$type_techhan   = 'TechHan'
$url_datapack   = $cgi_url + $type_datapack
$url_techhan    = $cgi_url + $type_techhan

#-----------------------------------------------------------------------------
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
function getOppositeUrl($url)
{
    if ($url -eq $url_datapack) { return $url_techhan  }
    if ($url -eq $url_techhan)  { return $url_datapack }
    return ''
}

function convert2Dir($url)
{
    if ($url -eq $url_datapack) {
        $dir = '..\MSX-Datapack'
        if (Test-Path $dir) {return $dir}
        $dir = '..\..\MSX-Datapack\html'
        if (Test-Path $dir) {return $dir}
    }
    if ($url -eq $url_techhan) {
        $dir = '..\MSX2-Technical-HandBook'
        if (Test-Path $dir) {return $dir}
        $dir = '..\..\MSXテクニカルハンドブック\html'
        if (Test-Path $dir) {return $dir}
    }
    return ''
}

function getOppositeLocal($url)
{
    $url = (convert2Dir(getOppositeUrl($url))).Replace('\','/')
    $url= $url + '/FrontPage.html'
    return $url
}

#-----------------------------------------------------------------------------
# 左詰め
#-----------------------------------------------------------------------------
function leftAlignStr ($str, $len) 
{
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
function decodeURI( $url ) 
{
    $ret = [System.Web.HttpUtility]::UrlDecode($url, $euc)

    #2段デコードが必要なケースがある
    while (($ret.IndexOf('%') -ge 0 ) -or ($ret.IndexOf('+') -ge 0)) {
        $ret = [System.Web.HttpUtility]::UrlDecode($ret, $euc)
    }
    return $ret
}

#-----------------------------------------------------------------------------
# ダウンロードメッセージの表示
#-----------------------------------------------------------------------------
function ShowDlMessage( $mes, $filepath, $url) 
{
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
function MakeSubDir($name) 
{
    $d = (Join-Path $cd $name)
    if (Test-Path $d) { return }
    $ret = (New-Item -Path $cd -Name $name -ItemType "Directory")
    return
}

#-----------------------------------------------------------------------------
# 通常文字列を正規表現エスケープする
#-----------------------------------------------------------------------------
function regexEscape( $s ) 
{
    # []().\^$|?*+{}
    return ($s -replace '([\[\]\(\)\.\\\^\$\|\?\*\+\{\}])', '\$1')
}


##############################################################################
# オリジナルのダウンロード
##############################################################################
function downloadOriginal ($index_url, $type, $root_dir, $sub_dir, $log) 
{
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
        $content = [IO.File]::ReadAllLines( $index_file, $euc )
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
        '# PowerShell で実行してください。'      > $log
        'Add-Type -AssemblyName System.Web'     >> $log
        ''                                      >> $log
        '$dl_list = @('                         >> $log

        # URL毎の処理
        foreach ($i in $urls) {
            $url = $cgi_url + $i.Groups[0].Value
            $name = $i.Groups["name"].Value + ".html"

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
            "    ,@{dst=${n}; url=${u}}"                        >> $log
        }
        ')'                                                     >> $log
        ''                                                      >> $log
        'foreach ($i in $dl_list) {'                            >> $log
        '    if ($i["url"] -eq "") {continue}'                  >> $log
        '    "Download: {0}" -f $i["dst"]'                      >> $log
        '    Invoke-WebRequest $i["url"] -OutFile $i["dst"]'    >> $log
        '}'                                                     >> $log


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
function get_encoded_urls( $text ) 
{
    $ret = @()
    $hash = @{}

    $urls = [regex]::Matches( $text, '(src|href|name)="(?<url>[^"]+)')
    if (-not $urls.Success) {
        return ,$ret
    }

    foreach ($i in $urls) {
        $s = $i.Groups["url"].Value

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
            $name = $m.Value
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
function writeDownloadList( $list, $dstfile ) 
{
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
function get_img_utl( $text, [ref]$img_hash_ref ) 
{
    $ret = @()

    $urls = [regex]::Matches( $text, 'https?://[^"\n\)]+\.(png|jpeg|jpg|gif|svg)')
    if (-not $urls.Success) {
        return ,$ret
    }

    foreach ($i in $urls) {
        $url = $i.Value

        $path = $url -replace '"',''
        $name = [regex]::Match($path,'/[^/]+$').Value
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
        if ($img_hash_ref.Value[$dst] -eq $url) {continue}

        if ($img_hash_ref.Value[$dst].Length) {
            # 違う値で既に存在
            Write-Host ("[CAUTION] Different value: key = " + $dst)
            Write-Host ("prev: " + $img_hash_ref.Value[$dst])
            Write-Host ("new : " + $url)
        }

        $img_hash_ref.Value[$dst] = $url

        $ret += ,@($url, $dst)
    }

    return ,$ret
}

#-----------------------------------------------------------------------------
## テキスト読み込み
#-----------------------------------------------------------------------------
function readFile( $fname ) 
{
    $fpath = (Join-Path $cd $fname)
    try {
        # EUCとしてテキストファイルを読み込む
        $content = [IO.File]::ReadAllLines( $fpath, $euc ) ;# 行ごとに読み込み
        $text = $content -join "`n"                        ;# 改行文字で繋げる
        #$text = [IO.File]::ReadAllText( $fpath, $euc )
    }
    catch {
        return $Null
    }
    return $text
}

#-----------------------------------------------------------------------------
# htmlファイルを処理する
#-----------------------------------------------------------------------------
function porc_html( $src_file, [ref]$img_hash_ref ) 
{
    $text = ""
    $eurl = @()
    $img_list = @()
    $tex_list = @()

    #------ テキスト読み込み ------
    $text = (readFile $src_file)

    if ($text -eq $Null) {
        return @{
            text = $text
            eurl = $eurl
            img_list = $img_list
        }
    }

    #------ TeX変換 -------------
    $rp = (TeX_modify_html $text)
    $text = $rp["text"]
    $tex_list = $rp["tex_list"]

    #------ 前加工 ----------------

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
    # 2部 3.13 ステートメント.html(365):
    # BLOAD&lt;ファイルスペック&gt;[<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../[,S" target="_blank">,R]</a>[,&lt;オフセット&gt;]<br>
    $old = '[<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../[,S" target="_blank">,R]</a>'
    $new = '[[,R]｜[,S]]'
    $text = $text.Replace( $old, $new );#脱字も修正するので特化置換

    # 5章 コマンド.html(927):
    # <h4><a name="p27"> KMODE <a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../OFF" target="_blank">数値</a> [/S]</a></h4>
    # 5章 コマンド.html(936):
    # KMODE <a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../OFF" target="_blank">数値</a> [/S]<br>
    # 5章 コマンド.html(1029):
    # <h4><a name="p33"> PATH [<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../ -" target="_blank">+ </a>[d:] パス <span class="nopage">d:] パス [[d:] パス...</span><a href="datapack?page=d%3A%5D+%A5%D1%A5%B9+%5B%5Bd%3A%5D+%A5%D1%A5%B9%2E%2E%2E">?</a>]</a></h4>
    # 5章 コマンド.html(1038):
    # PATH [<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../ -" target="_blank">+ </a>[d:] パス <span class="nopage">d:] パス [[d:] パス...</span><a href="datapack?page=d%3A%5D+%A5%D1%A5%B9+%5B%5Bd%3A%5D+%A5%D1%A5%B9%2E%2E%2E">?</a>]<br>
    # 5章 コマンド.html(1319):
    # VERIFY <a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../OFF" target="_blank">ON</a><br>
    #$bs = (regexEscape '<a href="http://ngs.no.coocan.jp/doc/wiki.cgi/datapack/../')
    $bs = (regexEscape "<a href=`"${cgi_url}${type}/../")
    $text = $text -replace ($bs + '([^"]+)"[^>]*>([^<]+)</a>'), '[$2|$1]'

    #------ 追加加工 --------------
    $text = (hook_modify_html $text)

    #------ URL抽出 ---------------

    # 画像ダウンロードリストを取得
    $img_list = (get_img_utl $text $img_hash_ref)

    # 画像URLをimgフォルダへの相対パスへ変更
    $text = $text -replace 'https?://[^"\)]*/([^"/>\)]+\.)(png|jpg|gif|jpeg|svg)', ($img_dir + '/$1$2')

    # URL変換 (""で囲んでいる物のみ)
    $eurl = (get_encoded_urls $text)
    foreach ($i in $eurl) {
        $s = '"' + ($i[0].replace(' ', '%20')) + '"'
        $d = '"' + ($i[1].replace(' ', '%20')) + '"'
        $text = $text.Replace( $s, $d )
    }

    #------ 後加工 ----------------

    #------ ページリンク変換 (""で囲んでいる物のみ)
    foreach ($i in $page_list) {
        $s = '"'+$i[0].replace(' ', '%20')+'.html"'
        $d = '"'+$i[1].replace(' ', '%20')+'.html"'
        $text = $text.Replace( $s, $d )
        $s = '"'+$i[0].replace(' ', '%20')+'"'
        $text = $text.Replace( $s, $d )
    }
    #------ 別wikiへのリンク加工 --
    $text= $text.Replace($opp_url, $opp_top)


    #綴り修正
    $text = ($text -replace "APPENEX","AAPPENDIX")
    $text = ($text -replace "APPENDEX","AAPPENDIX")


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
function rename_all() 
{
    foreach ($i in $page_list)
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
# 全てのhtmlファイルを処理
#-----------------------------------------------------------------------------
function proc_all( $common_dl ) 
{
    #-----------------------------------------------------------------------------
    # html 解析＆変換＆抽出
    #-----------------------------------------------------------------------------
    #if (Test-Path log.txt) { Remove-Item -Path log.txt }

    '# PowerShell で実行してください。'  > $img_list_file
    'Add-Type -AssemblyName System.Web' >> $img_list_file
    ""                                  >> $img_list_file
    '$dl_list = @('                     >> $img_list_file

    $img_hash = @{}
    $img_list = @()
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
    foreach ($target in $page_list) {
        $src = $target[0]
        $dst = $target[1]

        #if ($dst -ne '4部-9章 YJK方式') { continue }

        $src_file = (Join-Path $org_dir ($src + '.html'))
        $out_file = $dst + '.html'

        if (-not (Test-Path $src_file)) { continue }

        Write-Host ("Convert: " + $dst)
        #("#"+$dst)                                          >> log.txt

        $rp = (porc_html $src_file ([ref]$img_hash))
        $text = $rp["text"]
        $eurl = $rp["eurl"]
        $imgl = $rp["img_list"]
        $texl = $rp["tex_list"]

        if ($text.Length) {
        
            $img_list += ,@{
                target = $target[1]
                list   = $imgl
            }
            $tex_list += ,@{
                target = $target[1]
                list   = $texl
            }

            ##変換後のhtmlを書き出し
            #                                   > $out_file
            # EUCとしてテキストファイルを保存
            $lines = $text -split "`n"
            #$wr = [IO.File]::WriteAllLines( $out_file, $lines, $euc )
            $wr = [IO.File]::WriteAllLines( $out_file, $lines, $utf8_bom )
            #$wr = [IO.File]::WriteAllText( $out_file, $text, $euc )

            #$text                                           > conv.html
            #$eurl                                           > eurl.txt
            #$imgl                                           > img_list.txt
            if ($imgl.Length) {
                ("#"+$target[1])                             >> $img_list_file
                writeDownloadList $imgl $img_list_file
            }
        }
    }
    '    @{dst=""; url=""}'                                  >> $img_list_file
    ')'                                                      >> $img_list_file
    ''                                                       >> $img_list_file
    'foreach ($i in $dl_list) {'                             >> $img_list_file
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
function download_images( $img_list ) 
{
    foreach ($t in $img_list) {
        $target = $t["target"]
        if ($t["list"].Count -eq 0) {continue}
        Write-Host "# ${target}"
        foreach ($i in $t["list"]) {
            $url = $i[0]
            $dst = $i[1]
            if ($dst -eq "") {continue}
            if (Test-Path ($dst)) {
                #ShowDlMessage ("Already Downloaded") ($dst) ""
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

$index_url      = $cgi_url + $type
$opp_url        = getOppositeUrl( $index_url )
$opp_top        = getOppositeLocal( $index_url )

$img_list = @()
$tex_list = @()

#### TEST ####
#$testfile = "4部-9章 YJK方式.html"
#$text = (readFile $testfile)
#$ret = (convert_TeX $text ([ref]$tex_list))
#$text = $ret["text"]
#$tex_list
#return

#-----------------------------------------------------------------------------
# 初期化の追加処理
#-----------------------------------------------------------------------------
hook_initialize
TeX_initialize

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
downloadOriginal ($cgi_url) ($type) ($cd) ($org_dir) (Join-Path $cd $log)

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

#-----------------------------------------------------------------------------
# TEX式 ログ出力
#-----------------------------------------------------------------------------
log_TeX $tex_list

#Write-Host "終了しました。ENTERキーを押してください。";Read-Host

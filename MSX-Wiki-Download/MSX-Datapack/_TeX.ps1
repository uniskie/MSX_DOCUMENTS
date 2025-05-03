##############################################################################
# TEX表示周りの処理
# (Google Chart API廃止に伴う置き換え)
#
# function get_TeXlib_name()
# function decode_TeX( $text )
# function add_TeX_lib_header( $text )
# function download_KATEX_modules()
# function download_MathJax_modules()
# function TeX_initialize()
# function TeX_modify_html( $text )
# function log_TeX( $tex_list )
##############################################################################

# 初期化：
$use_MathJax=0;$use_KATEX=0;$use_KATEX_ECMAScript=0;$use_offline_TeXLib=0

#-----------------------------------------------------------------------------
# お好みでどちらか
#$use_MathJax            = $True     ;# MathJaxを使用する (機能豊富・古い)
$use_KATEX              = $True     ;# KATEXを使用する (軽量・新しい)
#-----------------------------------------------------------------------------

$use_offline_TeXLib     = $True     ;# KATEX/MathJaxをオフラインで使用する(推奨)

$replace_svg_to_TeX    = $True      ;# 7部-4章-5 Y8950(MSX-AUDIO) の式svgをTeXに置き換える

#-----------------------------------------------------------------------------
#$use_KATEX_ECMAScript   = $True     ;# ECMAScriptモジュール版を使用する（古いブラウザ向け）(オフラインだとエラー)
$KATEX_ver = '0.16.22'              ;# KATEX version
$MathJax_ver = '4.0.0-beta.7'       ;# MathJax version
#-----------------------------------------------------------------------------

##############################################################################
if ($use_KATEX) {
    $KATEX_dist_url     = 'https://cdn.jsdelivr.net/npm/KATEX@' + $KATEX_ver + '/dist/'
    $KATEX_zip_url      = 'https://github.com/KATEX/KATEX/releases/download/v' + $KATEX_ver + '/katex.zip'
    $KATEX_root         = '.'
    #$KATEX_root         = '.\theme'
    $KATEX_dir          = (Join-Path $KATEX_root 'KATEX')
}

if ($use_MathJax) {
    $MathJax_dist_url   = 'https://cdn.jsdelivr.net/npm/MathJax@3/es5/'
    $MathJax_arc_name   = 'MathJax-' + $MathJax_ver
    $MathJax_zip_url    = 'https://github.com/MathJax/MathJax/archive/refs/tags/' + $MathJax_ver + '.zip'
    $MathJax_root       = '.'
    #$MathJax_root       = '.\theme'
    $MathJax_parent     = 'MathJax@3'
    $MathJax_parent_dir = (Join-Path $MathJax_root $MathJax_parent)
    $MathJax_sub        = 'es5'
    $MathJax_dir        = (Join-Path $MathJax_parent $MathJax_sub)
}
$delim_s = '$'
$delim_e = '$'
$delim_ls = '$$'
$delim_le = '$$'
if ($use_KATEX) {
    $delim_s = '\('
    $delim_e = '\)'
    $delim_ls = '\['
    $delim_le = '\]'
}
elseif ($use_MathJax) {
    $delim_s = '\('
    $delim_e = '\)'
    $delim_ls = '\['
    $delim_le = '\]'
}

$charts_api_url = 'http://chart.apis.google.com/chart?cht=tx&chl='

#-----------------------------------------------------------------------------
function get_TeXlib_name() 
{
    if ($use_KATEX) { return "KATEX" }
    if ($use_MathJax) { return "MathJax" }
    return "(No renderer)"
}

###############################################################################
#-----------------------------------------------------------------------------
# HTMLヘッダにTeX表示ライブラリの読み込み処理を追加する
#-----------------------------------------------------------------------------
function add_TeX_lib_header( $text ) 
{
    $newline = "`n"
    if ($type -eq 'datapack') {
        if ($use_KATEX) {
            # $...$がインライン $$...$$が改行
            # \(...\)がインライン \[...\]が改行
            $config = @(
                '      // customised options'
                '      // • auto-render specific keys, e.g.:'
                '      delimiters: ['
                # $は16進数表現とぶつかるので使わない
                #'          {left: ''$$'' , right: ''$$'' , display: true},'
                #'          {left: ''$''  , right: ''$''  , display: false},'
                '          {left: ''\\('', right: ''\\)'', display: false},'
                '          {left: ''\\['', right: ''\\]'', display: true}'
                '      ],'
                '      // • rendering keys, e.g.:'
                '      throwOnError : false'
            ) -join $newline

            if ($use_offline_TeXLib) {
                $b = $KATEX_dir.Replace('\', '/') + '/'
            } else {
                $b = $KATEX_dist_url
            }

            $s = "<title>"
            $d = '<link rel="stylesheet" href="' + $b + 'KATEX.min.css"'
            if (-not $use_offline_TeXLib) {
                $d += ' integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP"'
                $d += ' crossorigin="anonymous"'
            }
            $d += '>' + $newline
            if ($use_KATEX_ECMAScript) {
                if ($use_offline_TeXLib) {
                    Write-Host '[警告]'
                    Write-Host '（TeXライブラリのオフライン使用）'
                    Write-Host '$use_offline_TeXLib = $true の時は'
                    Write-Host '$use_KATEX_ECMAScript = $true ではセキュリティエラーが出ます。'
                    Write-Host '#$use_KATEX_ECMAScript = $true に（コメントアウト）してください。'
                    Write-Host 'ENTERキーを押してください。';Read-Host
                }
                $d += @(
                    '<script type="module">'
                    '    import renderMathInElement from "' + $b + 'contrib/auto-render.mjs";'
                    '    renderMathInElement(document.body);'
                    '    renderMathInElement(document.body, {'
                    "${config}"
                    '    });'
                    '</script>'
                    '') -join $newline
            }
            else {
                $d += '<script defer src="' + $b + 'KATEX.min.js"'
                if (-not $use_offline_TeXLib) {
                    $d += ' integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6"'
                    $d += ' crossorigin="anonymous"'
                }
                $d += '></script>' + $newline
                $d += '<script defer src="' + $b + 'contrib/auto-render.min.js"'
                if (-not $use_offline_TeXLib) {
                    $d += ' integrity="sha384-hCXGrW6PitJEwbkoStFjeJxv+fSOOQKOPbJxSfM6G5sWZjAyWhXiTIIAmQqnlLlh"'
                    $d += ' crossorigin="anonymous"'
                }
                $d += '></script>' + $newline
                $d += @(
                    '<script>'
                    '    document.addEventListener("DOMContentLoaded", function() {'
                    '        renderMathInElement(document.body, {'
                    "${config}"
                    '        });'
                    '    });'
                    '</script>'
                    ''
                    '<title>') -join $newline
            }
            $text = $text.Replace($s, $d)
        }
        elseif ($use_MathJax) {
            if ($use_offline_TeXLib) {
                $b = $MathJax_dir.Replace('\', '/') + '/'
            } else {
                $b = $MathJax_dist_url
            }
            $s = "<title>"
            $d = @(
            '<script type="text/javascript" id="MathJax-script" async'
            '  src="' + $b + 'tex-mml-chtml.js">'
            'MathJax.Hub.Config({'
            '  tex2jax: {'
            '    inlineMath:['
            '      ['
            '        ''$'', //開始記号'
            '        ''$'' //終了記号'
            '      ],'
            '      ['
            '        ''\\('', //開始記号'
            '        ''\\)'' //終了記号'
            '      ]'
            '    ]'
            '  }'
            '});'
            '</script>'
            ''
            '<title>'
            ) -join "`n"
            $text = $text.Replace($s, $d)
        }
    }
    
    return $text
}

###############################################################################
# KATEX モジュール＆リソースのダウンロード
function download_KATEX_modules() 
{
    if ($KATEX_root -ne '.') {
        MakeSubDir $KATEX_root
    }

    $zip_path = Join-Path $KATEX_root ("KATEX_v${KATEX_ver}.zip")

    if (Test-Path $zip_path) {
        Write-Host "${zip_path} is already downloaded."
    }
    else {
        Write-Host "Download: ${KATEX_zip_url}"
        Write-Host "      to: ${zip_path}"

        Invoke-WebRequest $KATEX_zip_url -OutFile $zip_path

        if (Test-Path $zip_path) {
            try {
                Expand-Archive -Path $zip_path -DestinationPath $KATEX_root -Force
                Write-Host "Expanded zip to: ${KATEX_dir}"
                #Write-Host (Get-ChildItem -Path $KATEX_dir -Recurse -File -Name)
            } catch {
                Write-Host "Expand error occurred:"
                Write-Host $_
            }
        }
        else {
            Write-Host "[ERROR] failure download ${KATEX_zip_url}"
        }
    }
}

###############################################################################
# MathJax モジュール＆リソースのダウンロード
function download_MathJax_modules() 
{
    if ($MathJax_dir -ne '.') {
        MakeSubDir $MathJax_dir
    }

    $dirs = [regex]::Match($MathJax_dir, '^(.+)/([^/]+)$')
    $parent = $dirs.Groups[0].Value
    $sub    = $dirs.Groups[1].Value

    $zip_path = Join-Path $MathJax_root ($MathJax_arc_name + '.zip')

    Write-Host "Download: ${MathJax_zip_url}"
    Write-Host "      to: ${zip_path}"

    if (Test-Path $zip_path) {
        Write-Host "${zip_path} is alreadt downloaded"
    }
    else {
        Invoke-WebRequest $MathJax_zip_url -OutFile $zip_path

        if (Test-Path $zip_path) {
            try {
                Expand-Archive -Path $zip_path -DestinationPath $MathJax_parent_dir -Force
                Write-Host "Expanded zip to: ${MathJax_parent_dir}"
                
                #フォルダ名変更 MathJax@3\MathJax-v??.??\ -> MathJax@3\es5\
                if (Test-Path $MathJax_dir) { Remove-Item $MathJax_dir }
                $expanded_path = Join-Path $MathJax_parent_dir $MathJax_arc_name
                Rename-Item -Path $expanded_path -NewName $MathJax_sub
            } catch {
                Write-Host "Expand error occurred:"
                Write-Host $_
            }
        }
        else {
            Write-Host "[ERROR] failure download ${MathJax_zip_url}"
        }
    }
}

#-----------------------------------------------------------------------------
# 追加の初期化
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function TeX_initialize() 
{
    if ($type -eq 'datapack') {
        #if (False)
        if ($use_KATEX -and $use_offline_TeXLib) {
            download_KATEX_modules
        }
        if ($use_MathJax -and $use_offline_TeXLib) {
            download_MathJax_modules
        }
    }
}

###############################################################################
#-----------------------------------------------------------------------------
# MSX-Datapack Wikiで出現するTEX命令
#-----------------------------------------------------------------------------
# \frac      
# \leq       
# \omega     
# \times     
# \overl     \overline の短縮（MathJax/KATEX非対応）
# \Delta     
# \geq       
# \mathrm    
# \sin       
# \De        \Delta の短縮（MathJax/KATEX非対応）
# \rm        
# \hspace    
# \tim       \times の短縮（MathJax/KATEX非対応）
# \left      
# \E         
# \om        \omega の短縮（MathJax/KATEX非対応）
# \beta      
# \hat       源本に近いのは\hat。 \widehatだと派手過ぎる
#-----------------------------------------------------------------------------
function modfy_TeX( $text )
{
    # TEXサンプルコードらしき不要な式を削除
    if ($text.IndexOf('hoge') -gt 0) {
        return ''
    }

    # 頭に\mathrmは無い方が表示が安定するので除去
    # 大文字小文字の区別の為に -creplace
    $text = $text -creplace '^\s*\\mathrm', ''

    ## F =( fmus \times 218 / fsam) /2b-1 を修正
    #$old = 'F =( fmus \times 218 / fsam) /2b-1'
    #$new = 'F =( fmus \times 2^{18} / fsam) /2^{b-1}'
    #$text = $text.Replace( $old, $new )
    #
    ### 記述ミスらしき \hat を除去
    ## 例）
    ## \Delta \hat_{n+1} 
    ##   ↓
    ## \Delta_{n+1} 
    #$text = [regex]::Replace( $text, '\\hat\s*(?![A-Za-z\\])', '')
    
    # Google chart 省略記法っぽいものを補正
    # 大文字小文字の区別の為に -creplace
    $text = $text -creplace '\\De(?![A-Za-z])',    '\Delta'
    $text = $text -creplace '\\tim(?![A-Za-z])',   '\times'
    $text = $text -creplace '\\om(?![A-Za-z])',    '\omega'
    $text = $text -creplace '\\overl(?![A-Za-z])', '\overline'
   #$text = $text -creplace '\\hat(?![A-Za-z])',   '\widehat'

    ## \hspaceの修正 (全体に問題多めなのでそれぞれ個別ケースに対処)
    $old = '\\ \hspace{141em}';# +J2(I) \{ \sin(\om c+ 2\om m)t+\sin (\om c-2\om m)t+ ...... ]'
    $new = '\\ \hspace{1em}';# +J2(I) \{ \sin(\om c+ 2\om m)t+\sin (\om c-2\om m)t+ ...... ]'
    $text = $text.Replace( $old, $new )
    $text = $text.Replace( '\hspace{150}', '\hspace{26em}' )
    $text = $text.Replace( '\hspace{141em}', '\hspace{4em}' )
    $text = $text.Replace( '\hspace{10}', '\hspace{4em}' ) ;#TeX_modify_htmlで対処済みだけど念のため

    ## 連立方程式の括弧
    $alt         = 'array'
    $pos         = '{l}'
    $begin_check = '\\begin\{(?<alt>[^\}]+)\}(?<pos>\{[lcr]\})?'
    $begin       = '\begin{'+$alt+'}'+$pos
    $ldelim      = '\\'
    $end         = '\end{'+$alt+'}'

    $left_check  = '\left. \{'
    $left        = '\left \{'
    $righ_check  = '\right'
    $right       = '\right.'

    # 改行（\\ `n）がある場合はマルチライン処理
    if ($text -match (regexEscape($ldelim))) {

        # \leftがあるか検査
        $use_left = ($text -match (regexEscape($left_check)))

        # マルチラインの始まりを処理
        $bm = [regex]::Match($text, $begin_check)
        $alt_b = $bm.Groups['alt']
        if ($alt_b.Success) {
            # \begin に対応する \end
            $end = '\end{' + $alt_b.Value + '}'
        }
        if ($bm.Success) {
            if ($use_left) {
                # \left. \{ → \left \{
                $text = $text.Replace($left_check, ($left + ' ' + $begin))
            }
        } else {
            # 改行があるのに\beginが無ければ追加
            if ($use_left) {
                # left \{ を始まりとして置換
                $text = $text.Replace($left_check, ($left + ' ' + $begin))
            } else {
                # 無いので先頭に追加
                $text = $begin + $text
            }
        }

        # マルチラインの行区切りに位置合わせを追加
        $text = $text.Replace($ldelim, $ldelim)

        ## マルチラインの途中にhspaceがあったら削除
        #$text = [regex]::Replace( $text, '\\hspace\{(\d+(em|px|pc|pt|mm|cm)?)\}', '')

        # マルチライン終端の処理
        if ($text.IndexOf($end) -lt 0) {
            # 終端がないので追加
            $text = $text + ' ' + $end
        }

        # left に対応する rightの処理
        if ($use_left -and ($text.IndexOf($right_check) -lt 0)) {
            # \rightが無ければ追加
            $text = $text + $right
        }
    }
    
    ## 分数の大括弧
    $text = $text.Replace('\(','\left(')
    $text = $text.Replace('\)','\right)')

    ## 括弧の閉じ忘れを修正
    # {\rm f_{clock}
    @( 
        ,@('(?<!\\)\{','(?<!\\)\}' ,'}')
        ,@('(?<!\\)\(','(?<!\\)\)' ,')')
    ) | foreach {
        $ks      = $_[0]
        $ke      = $_[1]
        $ke_r    = $_[2]
        $kakko_s = [regex]::Matches($text, $ks).Count
        $kakko_e = [regex]::Matches($text, $ke).Count
        if ($kakko_e -lt $kakko_s) 
        {
            #Write-Host "${text}`n ${ks} = ${kakko_s}, ${ke} = ${kakko_e}"
            for(($i = $kakko_e); ($i -lt $kakko_s); $i++)
            {
                $text = $text + $ke_r
            }
        }
    }

    # Obsidian向けに前後の余白削除
    $text = $text.Trim()

    #管理しやすいように余白削除
    $text = $text -replace '\s+' ,' '
    $text = $text -replace '\{\s' ,'{'
    $text = $text -replace '\s\}' ,'}'
    $text = $text -replace '\(\s' ,'('
    $text = $text -replace '\s\)' ,')'
    $text = $text -replace '\{\s' ,'{'
    $text = $text -replace '\s\}' ,'}'
    $text = $text -replace '\[\s' ,'['
    $text = $text -replace '\s\]' ,']'

    return $text
}

#-----------------------------------------------------------------------------
# TeX式を囲む (インライン、マルチライン自動判定)
#-----------------------------------------------------------------------------
function enclose_TeX( $tex )
{
    if ($tex.Length -le 0) {
        # 長さ less than 0 (0以下)なら削除
        $new = ''
    }
    elseif ($tex -match '(\n|\\\\)') {
        # 途中改行あり
        $new = $tag_p.Value + $delim_ls + $tex + $delim_le
    }
    elseif ($tag_p.Success -and $tag_br.Success) {
        # 独立行
        $new = $tag_p.Value + $delim_ls + $tex + $delim_le
    }
    else {
        # インライン
        $new = $tag_p.Value + $delim_s + $tex + $delim_e + $tag_br
    }
    return $new
}

#-----------------------------------------------------------------------------
# 式svgをTeX式に置き換える
# 7部-4章-5 Y8950(MSX-AUDIO) の式svgをTeXに置き換える （力業）
#-----------------------------------------------------------------------------
function svg_to_TeX( $text ) 
{
    #$text >> log.txt

    # Google Charts APIへのリクエストへ置換
    # Tex変換リストに入れたいのでこちら
    function _to_( $text, $url, $tex )
    {
        $src = (regexEscape '<embed class="wikiimage" type="image/svg+xml" src="')
        $src += (regexEscape ('http://ngs.no.coocan.jp/doc/img/datapack/' + $url))
        $src += '" alt="(?<alt>[^"]+)"[^>]+>'
        $tex = [System.Web.HttpUtility]::UrlEncode($tex, $euc)
        $dst = '<img src="' + $charts_api_url + $tex + '" alt="${alt}">'
        $text = $text -replace $src, $dst
        #Write-Host $src
        #Write-Host $dst
        return $text
    }

    ## Tex変換リストに入れずに直接置換
    #function _to_Tex( $text, $url, $tex )
    #{
    #    $src = '<p><img[^>]+src="[^"]+/' + (regexEscape $url) + '"[^>]+><br>' + $newline + '</p>'
    #    $dst = (enclose_TeX $tex)
    #    $text = $text -replace $src, $dst
    #    return $text
    #}

    # <p><img class="wikiimage" src="img/4.5%20Y8950(MSX-AUDIO).式7.8.svg" alt="式7.8.svg" width="340" height="23"><br> 
    # </p>
    #
    # F=Asin(ωct+Isin ωmt)
    #
    # \noindent
    # \begin{math}
    # F =  A\sin(\omega ct + I\sin \omega mt )
    # \end{math}
    $url = '4%252E5%2BY8950%2528MSX%252DAUDIO%2529.%25BC%25B07.8.svg'
    #$url = '4.5%20Y8950(MSX-AUDIO).式7.8.svg'
    $tex = 'F = A\sin(\omega ct + I\sin \omega mt )'
    $text = (_to_ $text $url $tex)

    # <p><img class="wikiimage" src="img/4.5%20Y8950(MSX-AUDIO).式7.9.svg" alt="式7.9.svg" width="680" height="50"><br> 
    # </p>
    #
    # F=A[J0(I)sinωct + J1(I) {sin(ωc+ωm)t-sin(ωc-ωm)t} 
    #                  + J2(I) {sin(ωc+2ωm)t+sin(ωc-2ωm)t+......]
    #
    # \noindent
    # \begin{math}
    # F =  A\sin(\omega ct + 
    #                   J_1(I) \{ \sin(\omega c+\omega m  )t-\sin(\omega c-\omega m)t \} + \\
    #                   J_2(I) \{ \sin(\omega c+ 2\omega m)t+\sin(\omega c-2\omega m)t + .... ]
    # \end{math}
    $url = '4%252E5%2BY8950%2528MSX%252DAUDIO%2529.%25BC%25B07.9.svg'
    #$url = '4.5%20Y8950(MSX-AUDIO).式7.9.svg'
    $tex =  '\begin{aligned}'
    $tex += 'F = A\sin\omega ct'
    $tex += '     & + J_1(I) \{ \sin(\omega c+\omega m )t-\sin(\omega c-\omega m)t \} \\'
    $tex += '     & + J_2(I) \{ \sin(\omega c+ 2\omega m)t+\sin(\omega c-2\omega m)t + .... ]'
    $tex += '\end{aligned}'
    $text = (_to_ $text $url $tex)

    # <p><img class="wikiimage" src="img/4.5%20Y8950(MSX-AUDIO).式7.10.svg" alt="式7.10.svg" width="280" height="23"><br> 
    # </p>
    #
    # F=Asin(ωct+βF)
    #
    # \noindent
    # \begin{math}
    # F =  A\sin(\omega ct + \beta F )
    # \end{math}
    $url = '4%252E5%2BY8950%2528MSX%252DAUDIO%2529.%25BC%25B07.10.svg'
    #$url = '4.5%20Y8950(MSX-AUDIO).式7.10.svg'
    $tex = 'F = A\sin(\omega ct + \beta F )'
    $text = (_to_ $text $url $tex)

    return $text
}

#-----------------------------------------------------------------------------
# Google Chart APIへのリクエストをデコードして TeX式を得る
#-----------------------------------------------------------------------------
function decode_TeX( $text ) 
{
    #Write-Host "decode_TeX"

    $text = (svg_to_TeX $text) ;# SVG化された数式を逆変換

    $tex_list = @()

    $base = (regexEscape $charts_api_url)

    $m = [regex]::Matches($text, ('(?<p><p>)?<img[^>]+src="' + $base + '(?<TeX>[^"]+)"[^>]*>(?<br><br>)?'))
    #$m = [regex]::Matches($text, ($base+"(?<TeX>[^`"]+)`"[^>]*>"))

    foreach ($i in $m) {

        $tex = $i.Groups['TeX']
        $tag_p  = $i.Groups['p']
        $tag_br = $i.Groups['br']
            
        $d = [System.Web.HttpUtility]::UrlDecode($tex, $euc)
        $tex = (modfy_TeX $d)

        #Write-Host $i;###DEBUG###
        #Write-Host $d;###DEBUG###
        #Write-Host $tex;###DEBUG###

        $new = (enclose_TeX $tex)
        $text = $text.Replace($i,$new)
        $tex_list += ,@{
            org=$i
            dec=$d
            tex=$tex
            new = $new
        }
    }
    return @{
        text = $text
        tex_list = $tex_list
    }
}

#-----------------------------------------------------------------------------
# HTMLのTeX加工処理
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function TeX_modify_html( $text ) 
{
    ## 事前処理
    # 分割されたTeXをまとめる
    $old = '%5Cmathrm+%5Cleft%2E+%5C%7BV%5F%7BOUT%7D%3D%5Cfrac%7BVcc%7D%7B2%7D%2B%5Cfrac%7BVcc%7D%7B4%7D%5Ctim%28%2D1%2BF%5F9%2BF%5F8%5Ctim+2%5E%7B%2D1%7D%2B%2E%2E%2E%2E%2E%2E%2BF%5F1+%5Ctim+2%5E%7B%2D8%7D%2BF%5F0+%5Ctim+2%5E%7B%2D9%7D%2B2%5E%7B%2D10%7D%29%5Ctim+2%5E%7B%2DE%7D%5C%5CE%3D%5Coverl%7BS%7D%5F2+%5Ctim+2%5E2%2B%5Coverl%7BS%7D%5F1%5Ctim+2%5E1%2B%5Coverl+S%5F0%5Ctim+2%5E0++" alt="" > <img src="' + $charts_api_url + '%5Cmathrm+%40+%5Chspace%7B10%7DS%5F0%2BS%5F1%2BS%5F2%5Cgeq+1+';#" alt="" ><br>
    $new = [System.Web.HttpUtility]::UrlEncode((@(
        '\mathrm \left. \{V_{OUT}=\frac{Vcc}{2}+\frac{Vcc}{4}\tim(-1+F_9+F_8\tim 2^{-1}+......+F_1 \tim 2^{-8}+F_0 \tim 2^{-9}+2^{-10})\tim 2^{-E}'
        '\\E=\overl{S}_2 \tim 2^2+\overl{S}_1\tim 2^1+\overl S_0\tim 2^0'
        '\hspace{4em} @ S_0+S_1+S_2\geq 1 '
        ) -join ''), $euc)
    $text = $text.Replace( $old, $new )

    # F =( fmus \times 218 / fsam) /2b-1 を修正
    $old = 'F+%3D%28+fmus+%5Ctimes+218+%2F+fsam%29+%2F2b%2D1'
    $new = [System.Web.HttpUtility]::UrlEncode('F =( fmus \times 2^{18} / fsam) /2^{b-1}', $euc)
    $text = $text.Replace( $old, $new )

    ## 記述ミスらしき \hat を除去
    # 例）
    # \Delta \hat_{n+1} 
    #   ↓
    # \Delta_{n+1} 
    $text = $text.Replace( '%5Chat%5F', '%5F')

    ## 抽出＆加工
    $rp = (decode_TeX ($text))
    $text = $rp["text"]
    $tex_list = $rp["tex_list"]
    
    ## 反映する
    if ($tex_list.Count) {
        $text = (add_TeX_lib_header ($text))
    }
    return @{
        text = $text
        tex_list = $tex_list
    }
}

#-----------------------------------------------------------------------------
# TEX式 ログ出力
#-----------------------------------------------------------------------------
function log_TeX( $tex_list )
{
    # TEX抽出作業ログ
    $tex_log_file = "tex_log.txt"

    # TEX書式で書かれた式の抽出リスト
    $tex_list_file = "tex_list.txt"

    # 使用されているコマンド(\ではじまるもの)の一覧
    $cmd_list_file = "tex_cmd_list.txt"


    $liner = "------------------------------------------------"
    $tex_list_count = 0


    #-----------------------------------------------------------------------------
    $cmd = @{}
    function checkCmd( $text, [ref]$dic_ref )
    {
        $list = [regex]::Matches($text, '\\[A-Za-z]+')
        if ($list.Count)
        {
            foreach ($i in $list)
            {
                $c = $i.Value
                $dic_ref.Value[$c] = $c
            }
        }
    }
    #-----------------------------------------------------------------------------
    
    if (Test-Path $tex_list_file) {Remove-Item $tex_list_file}
    foreach ($t in $tex_list) {
        $list = $t["list"]
        $tex_list_count += $list.Count
    }
    if ($tex_list_count) {

        Write-Host ""
        Write-Host "# ${liner}"
        Write-Host("# TEX renderer: " + (get_TeXlib_name))
        Write-Host "# ${liner}"

        @( $tex_log_file, $tex_list_file ) | foreach {
            "# lTEX LIST ${liner}"          > $_
        }

        foreach ($t in $tex_list) {
            $list = $t["list"]
            $target = $t["target"]
            if ($list.Count) {
                Write-Host ("## ${target} : count = " + $list.Count)
                @( $tex_log_file, $tex_list_file ) | foreach {
                    ""                      >> $_
                    "# ${liner}"            >> $_
                    "## ${target}"          >> $_
                    "# ${liner}"            >> $_
                }
                foreach ($i in $list)
                {
                    $org = $i["org"]
                    $dec = $i["dec"]
                    $tex = $i["tex"]
                    $new = $i["new"]
                        
                    if ($tex.Length -le 0) {
                        $tex = '** deleted **'
                    }
                    if ($new.Length -le 0) {
                        $new = '** deleted **'
                    }

                    checkCmd $tex ([ref]$cmd)

                    #Write-Host "  (src: ${org})"
                    #Write-Host "${dec}"

                    ""                      >> $tex_log_file
                    "${tex}"                >> $tex_log_file
                    "    uri: ${org}"       >> $tex_log_file
                    "    dec: ${dec}"       >> $tex_log_file
                    "    new: ${new}"       >> $tex_log_file

                    "${tex}"                >> $tex_list_file
                }
            }
        }
        Write-Host "TeX logged in ${tex_log_file}"
        
        $keys = @()
        foreach ($i in $cmd.Keys) {$keys +=,$i}
        Sort-Object $keys
        $keys                               > $cmd_list_file
    }
}


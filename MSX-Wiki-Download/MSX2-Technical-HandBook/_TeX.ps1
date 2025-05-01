##############################################################################
# TEX表示周りの処理
# (Google Chart API廃止に伴う置き換え)
#
# function get_TeXlib_name()
# function decode_TeX( $text )
# function add_TeX_lib_header( $text )
# function download_katex_modules()
# function TeX_initialize()
# function TeX_modify_html( $text )
# function log_TeX( $tex_list )
##############################################################################

# 初期化：
$use_MathJax=0;$use_KATEX=0;$use_KATEX_ECMAScript=0;$use_KATEX_offline=0

#$use_MathJax            = $True     ;# MathJaxを使用する (機能豊富・古い)
$use_KATEX              = $True     ;# KATEXを使用する (軽量・新しい)

#$use_KATEX_ECMAScrip    = $True     ;# ECMAScriptモジュール版を使用する（古いブラウザ向け）
#$use_KATEX_offline      = $True     ;# KATEXをオフラインで使用する (動作しない)

##############################################################################
if ($use_KATEX) {
$katex_dist_url    = 'https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/'
$katex_dir         = '..\theme\katex'
$katex_contrib_dir = $katex_dir + '\contrib'
$katex_fonts_dir   = $katex_dir + '\fonts'
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
    if ($type -eq 'datapack') {
        if ($use_KATEX) {
            $s = "<title>"
            if ($use_KATEX_offline) {
                $b = "../theme/katex/"
            } else {
                $b = $katex_dist_url
            }

            # $...$がインライン $$...$$が改行
            # \(...\)がインライン \[...\]が改行
            $config = @(
                '      // customised options'
                '      // • auto-render specific keys, e.g.:'
                '      delimiters: ['
                '          {left: ''$$'' , right: ''$$'' , display: true},'
                '          {left: ''$''  , right: ''$''  , display: false},'
                '          {left: ''\\('', right: ''\\)'', display: false},'
                '          {left: ''\\['', right: ''\\]'', display: true}'
                '      ],'
                '      // • rendering keys, e.g.:'
                '      throwOnError : false'
            ) -join "`n"

            if ($use_KATEX_ECMAScript) {
                $d = @(
                '<link rel="stylesheet" href="' + $b + 'katex.min.css"'
                '    integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP"'
                '    crossorigin="anonymous">'
                '<script type="module">'
                '    import renderMathInElement from "' + $b + 'contrib/auto-render.mjs";'
                '    renderMathInElement(document.body);'
                '    renderMathInElement(document.body, {'
                "${config}"
                '    });'
                '</script>'
                ''
                ) -join "`n"
            }
            else {
                $d = @(
                '<link rel="stylesheet" href="' + $b + 'katex.min.css"'
                '    integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP"'
                '    crossorigin="anonymous">'
                '<script defer src="' + $b + 'katex.min.js"'
                '    integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6"'
                '    crossorigin="anonymous"></script>'
                '<script defer src="' + $b + 'contrib/auto-render.min.js"'
                '    integrity="sha384-hCXGrW6PitJEwbkoStFjeJxv+fSOOQKOPbJxSfM6G5sWZjAyWhXiTIIAmQqnlLlh"'
                '    crossorigin="anonymous"></script>'
                '<script>'
                '    document.addEventListener("DOMContentLoaded", function() {'
                '        renderMathInElement(document.body, {'
                "${config}"
                '        });'
                '    });'
                '</script>'
                ''
                '<title>'
                ) -join "`n"
            }
            $text = $text.Replace($s, $d)
        }
        elseif ($use_MathJax) {
            $s = "<title>"
            $d = @(
            '<script type="text/javascript" id="MathJax-script" async'
            '  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">'
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
# オフラインではCROSエラーで使えないので現象意味はない
function download_katex_modules() 
{
    # KATEX フォルダの作成
    $dir_list = @(
        $katex_dir
        $katex_contrib_dir
        $katex_fonts_dir
    )
    foreach ($i in $dir_list) {
        MakeSubDir $i
    }

    # KATEX フォントのダウンロード
    $font_list = @(
        'KaTeX_AMS-Regular'
        'KaTeX_Caligraphic-Bold'
        'KaTeX_Caligraphic-Regular'
        'KaTeX_Fraktur-Bold'
        'KaTeX_Fraktur-Regular'
        'KaTeX_Main-Bold'
        'KaTeX_Main-BoldItalic'
        'KaTeX_Main-Italic'
        'KaTeX_Main-Regular'
        'KaTeX_Math-BoldItalic'
        'KaTeX_Math-Italic'
        'KaTeX_SansSerif-Bold'
        'KaTeX_SansSerif-Italic'
        'KaTeX_SansSerif-Regular'
        'KaTeX_Script-Regular'
        'KaTeX_Size1-Regular'
        'KaTeX_Size2-Regular'
        'KaTeX_Size3-Regular'
        'KaTeX_Size4-Regular'
        'KaTeX_Typewriter-Regular'
    )
    foreach ($i in $font_list) {
        $urlb = $katex_dist_url + 'fonts/' + $i
        $path = (Join-Path $katex_fonts_dir $i)
        $ext_list = @('.ttf', '.woff', '.woff2')
        foreach ($ext in $ext_list) {
            $url = $urlb + $ext
            $dst = $path + $ext
            if (Test-Path ($dst)) {
                #ShowDlMessage ("Already Downloaded") ($dst) ""
            }
            else {
                ShowDlMessage ("Download") ($dst) ""
                Invoke-WebRequest $url -OutFile $dst
            }
        }
    }

    # KATEX モジュールのダウンロード
    $module_list = @(
        'katex.css'
        'katex.js'
        'katex.min.css'
        'katex.min.js'
        'katex.mjs'
        'contrib/auto-render.js'
        'contrib/auto-render.min.js'
        'contrib/auto-render.mjs'
        'contrib/copy-tex.js'
        'contrib/copy-tex.min.js'
        'contrib/copy-tex.mjs'
        'contrib/mathtex-script-type.js'
        'contrib/mathtex-script-type.min.js'
        'contrib/mathtex-script-type.mjs'
        'contrib/mhchem.js'
        'contrib/mhchem.min.js'
        'contrib/mhchem.mjs'
        'contrib/render-a11y-string.js'
        'contrib/render-a11y-string.min.js'
        'contrib/render-a11y-string.mjs'
    )
    foreach ($i in $module_list) {
        $url = $katex_dist_url + $i
        $dst = (Join-Path $katex_dir $i)
        $dst = $dst.Replace('/', '\')
        if (Test-Path ($dst)) {
            #ShowDlMessage ("Already Downloaded") ($dst) ""
        }
        else {
            ShowDlMessage ("Download") ($dst) ""
            Invoke-WebRequest $url -OutFile $dst
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
        if ($use_KATEX -and $use_KATEX_offline) {
            download_katex_modules
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
# \hat       \widehat のほうが安全？
#-----------------------------------------------------------------------------
function modfy_TeX( $text )
{
    # TEXサンプルコードらしき不要な式を削除
    if ($text.IndexOf('hoge') -gt 0) {
        return ''
    }

    # 頭に\mathrmは無い方が表示が安定するので除去
    $text = [regex]::Replace( $text, '^\s*\\mathrm', '')

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
    $text = [regex]::Replace( $text, '\\De(?![A-Za-z])',    '\Delta')
    $text = [regex]::Replace( $text, '\\tim(?![A-Za-z])',   '\times')
    $text = [regex]::Replace( $text, '\\om(?![A-Za-z])',    '\omega')
    $text = [regex]::Replace( $text, '\\overl(?![A-Za-z])', '\overline')

    ## \hspaceの修正 (全体に問題多めなのでそれぞれ個別ケースに対処)
    $old = '\\ \hspace{141em}';# +J2(I) \{ \sin(\om c+ 2\om m)t+\sin (\om c-2\om m)t+ ...... ]'
    if ($use_KATEX) {
        $new = '\\';# +J2(I) \{ \sin(\om c+ 2\om m)t+\sin (\om c-2\om m)t+ ...... ]'
    }else{
        $new = '\\ \hspace{2em}';# +J2(I) \{ \sin(\om c+ 2\om m)t+\sin (\om c-2\om m)t+ ...... ]'
    }
    $text = $text.Replace( $old, $new )
    $text = $text.Replace( '\hspace{150}', '\hspace{26em}' )
    $text = $text.Replace( '\hspace{141em}', '\hspace{4em}' )
    $text = $text.Replace( '\hspace{10}', '\hspace{4em}' ) ;#TeX_modify_htmlで対処済みだけど念のため

    ## 連立方程式の括弧
    $alt    = 'array'
    $pos    = '{l}'
    $begin_check = '\\begin\{(?<alt>[^\}]+)\}(?<pos>\{[lcr]\})?'
    $begin      = '\begin{'+$alt+'}'+$pos
    $ldelim     = '\\'
    $end        = '\end{'+$alt+'}'

    $left_check = '\left. \{'
    $left       = '\left \{'
    $righ_check = '\right'
    $right      = '\right.'

    # 改行（\\ `n）がある場合はマルチライン処理
    if ($text -match (regexEscape($ldelim))) {

        # \leftがあるか検査
        $use_left = ($text -match (regexEscape($left_check)))

        # マルチラインの始まりを処理
        $bm = [regex]::Match($text, $begin_check)
        $alt_b = $bm.Groups['alt']
        if ($alt_b.Success) {
            # \begin に対応する \end
            $end = '\end[' + $alt_b.Value + ']'
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
        $ks = $_[0]
        $ke = $_[1]
        $ke_r = $_[2]
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
    return $text.Trim()
}

#-----------------------------------------------------------------------------
# Google Chart APIへのリクエストをデコードして TeX式を得る
#-----------------------------------------------------------------------------
function decode_TeX( $text ) 
{
    #Write-Host "convert_TeX"

    $tex_list = @()

    $base = (regexEscape '<img src="http://chart.apis.google.com/chart?cht=tx&chl=')

    $m = [regex]::Matches($text, ('(?<p><p>)?' + $base + '(?<TeX>[^"]+)"[^>]*>(?<br><br>)?'))
    #$m = [regex]::Matches($text, ($base+"(?<TeX>[^`"]+)`"[^>]*>"))

    foreach ($i in $m) {

        $t = $i.Groups['TeX']
        $tag_p  = $i.Groups['p']
        $tag_br = $i.Groups['br']
            
        $d = [System.Web.HttpUtility]::UrlDecode($t, $euc)
        #$d = $d.Trim();# 前後の余白削除
        $t = (modfy_TeX $d)
        $t = $t.Trim();# 前後の余白削除

        #Write-Host $i;###DEBUG###
        #Write-Host $d;###DEBUG###
        #Write-Host $t;###DEBUG###

        if ($t.Length -le 0) {
            # 長さ less than 0 (0以下)なら削除
            $new = ''
        }
        elseif ($t -match '(\n|\\\\)') {
            # 途中改行あり
            $new = $tag_p.Value + $delim_ls + $t + $delim_le
        }
        elseif ($tag_p.Success -and $tag_br.Success) {
            # 独立行
            $new = $tag_p.Value + $delim_ls + $t + $delim_le
        }
        else {
            # インライン
            $new = $tag_p.Value + $delim_s + $t + $delim_e + $tag_br
        }
        $text = $text.Replace($i,$new)
        $tex_list += ,@{
            org=$i
            dec=$d
            tex=$t
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
    $old = '%5Cmathrm+%5Cleft%2E+%5C%7BV%5F%7BOUT%7D%3D%5Cfrac%7BVcc%7D%7B2%7D%2B%5Cfrac%7BVcc%7D%7B4%7D%5Ctim%28%2D1%2BF%5F9%2BF%5F8%5Ctim+2%5E%7B%2D1%7D%2B%2E%2E%2E%2E%2E%2E%2BF%5F1+%5Ctim+2%5E%7B%2D8%7D%2BF%5F0+%5Ctim+2%5E%7B%2D9%7D%2B2%5E%7B%2D10%7D%29%5Ctim+2%5E%7B%2DE%7D%5C%5CE%3D%5Coverl%7BS%7D%5F2+%5Ctim+2%5E2%2B%5Coverl%7BS%7D%5F1%5Ctim+2%5E1%2B%5Coverl+S%5F0%5Ctim+2%5E0++" alt="" > <img src="http://chart.apis.google.com/chart?cht=tx&chl=%5Cmathrm+%40+%5Chspace%7B10%7DS%5F0%2BS%5F1%2BS%5F2%5Cgeq+1+';#" alt="" ><br>
    $new = [System.Web.HttpUtility]::UrlEncode(@(
        '\mathrm \left. \{V_{OUT}=\frac{Vcc}{2}+\frac{Vcc}{4}\tim(-1+F_9+F_8\tim 2^{-1}+......+F_1 \tim 2^{-8}+F_0 \tim 2^{-9}+2^{-10})\tim 2^{-E}'
        '\\E=\overl{S}_2 \tim 2^2+\overl{S}_1\tim 2^1+\overl S_0\tim 2^0'
        '\hspace{4em} @ S_0+S_1+S_2\geq 1 '
        ) -join '')
    $text = $text.Replace( $old, $new )

    # F =( fmus \times 218 / fsam) /2b-1 を修正
    $old = 'F+%3D%28+fmus+%5Ctimes+218+%2F+fsam%29+%2F2b%2D1'
    $new = [System.Web.HttpUtility]::UrlEncode('F =( fmus \times 2^{18} / fsam) /2^{b-1}')
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


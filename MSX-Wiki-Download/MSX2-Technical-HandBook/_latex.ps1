##############################################################################
# TEX表示周りの処理
# (Google Chart API廃止に伴う置き換え)
##############################################################################
#初期化：LATEXレンダリング機能を使用しない
$use_MathJax = $False
$use_KATEX = $False

##############################################################################
### KATEX --------------------------------------------------------------------
# オンライン経由でのモジュールダウンロードのみ？
# 新しめ 小さめ 対応していない機能もある？
# レンダリング自体はオフライン
# （設定によってはサーバサイドレンダリングもサポートしている）
#-----------------------------------------------------------------------------
# KATEXを使用するなら $True
$use_KATEX = $True;
#-----------------------------------------------------------------------------

##############################################################################
### MathJax ------------------------------------------------------------------
# オンライン経由でのモジュールダウンロードのみ
# 古め 大き目
# 数式以外も全域サポート
#-----------------------------------------------------------------------------
# MathJaxを使用するなら $True
#$use_MathJax = $True
#-----------------------------------------------------------------------------


##############################################################################
function get_latexlib_name() {
    if ($use_KATEX) { return "KATEX" }
    if ($use_MathJax) { return "MathJax" }
    return "(No renderer)"
}

#-----------------------------------------------------------------------------
# Google Chart APIへのリクエストをデコードして LATEX式を得る
#-----------------------------------------------------------------------------
function decode_latex( $text ) {
    #Write-Host "convert_latex"

    $tex_list = @()

    $base = (regexEscape '<img src="http://chart.apis.google.com/chart?cht=tx&chl=')
    #$m = [regex]::Matches($text, ($base+"(?<latex>[^`"]+)`"[^>]*>(<br>)?"))
    $m = [regex]::Matches($text, ($base+"(?<latex>[^`"]+)`"[^>]*>"))
    foreach ($i in $m) {
        $l = $i.Groups["latex"]
        $d = (decodeURI $l)
        $d = $d.Trim()
        #Write-Host $i;###DEBUG###
        #Write-Host $d;###DEBUG###
        if ($use_KATEX) {
            $text = $text.Replace($i, ('\('+$d+'\)'))
            #$text = $text.Replace($i, ('$('+$d+'$'))
        }
        elseif ($use_MathJax) {
            $text = $text.Replace($i, ('\('+$d+'\)'))
            #$text = $text.Replace($i, ('$'+$d+'$'))
        }
        else {
            $text = $text.Replace($i, ('$'+$d+'$'))
        }
        $tex_list += ,@{
            org=$i
            dec=$d
        }
    }
    return @{
        text = $text
        tex_list = $tex_list
    }
}

#-----------------------------------------------------------------------------
# HTMLヘッダにLATEX表示ライブラリの読み込み処理を追加する
#-----------------------------------------------------------------------------
function add_latex_lib_header( $text ) {
    
    if ($type -eq 'datapack') {

        if ($use_KATEX) {
            $s = @("<title>")
            $d = @(
            '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
            '<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.js" integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6" crossorigin="anonymous"></script>'
            '<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.min.js" integrity="sha384-hCXGrW6PitJEwbkoStFjeJxv+fSOOQKOPbJxSfM6G5sWZjAyWhXiTIIAmQqnlLlh" crossorigin="anonymous"></script>'
            #'<link rel="stylesheet" href="../theme/katex/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
            #'<script defer src="../theme/katex/katex.min.js" integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6" crossorigin="anonymous"></script>'
            #'<script defer src="../theme/katex/contrib/auto-render.min.js" integrity="sha384-hCXGrW6PitJEwbkoStFjeJxv+fSOOQKOPbJxSfM6G5sWZjAyWhXiTIIAmQqnlLlh" crossorigin="anonymous"></script>'
            '<script>'
            '    document.addEventListener("DOMContentLoaded", function() {'
            '        renderMathInElement(document.body, {'
            '          // customised options'
            '          // • auto-render specific keys, e.g.:'
            '          delimiters: ['
            '              {left: ''$$'', right: ''$$'', display: true},'
            '              {left: ''$'', right: ''$'', display: false},'
            '              {left: ''\\('', right: ''\\)'', display: false},'
            '              {left: ''\\['', right: ''\\]'', display: true}'
            '          ],'
            '          // • rendering keys, e.g.:'
            '          throwOnError : false'
            '        });'
            '    });'
            '</script>'
            ''
            '<title>')
            #$d = @(
            #'  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
            ##' <link rel="stylesheet" href="../theme/katex/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
            #'<script type="module">'
            #'    import renderMathInElement from "https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.mjs";'
            ##'    import renderMathInElement from "../theme/katex/contrib/auto-render.mjs";'
            #'    renderMathInElement(document.body);'
            #'</script>')
            $text = $text.Replace(($s -join "`n"), ($d -join "`n"))
        }
        elseif ($use_MathJax) {
            $s = @("<title>")
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
            )
            $text = $text.Replace(($s -join "`n"), ($d -join "`n"))
        }
    }
    
    return $text
}

#-----------------------------------------------------------------------------
# 追加の初期化
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function latex_initialize() {
    if ($type -eq 'datapack') {
    #if ($use_KATEX) {
    #   $dir_list = @(
    #       '..\theme\katex'
    #       '..\theme\katex\contrib'
    #       '..\theme\katex\fonts'
    #   )
    #   foreach ($i in $dir_list) {
    #       MakeSubDir $i
    #   }
    #}
    }
}

#-----------------------------------------------------------------------------
# HTMLの追加加工処理
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function latex_modify_html( $text ) {
    $rp = (decode_latex ($text))
    $text = $rp["text"]
    $tex_list = $rp["tex_list"]
    
    if ($tex_list.Count) {
        $text = (add_latex_lib_header ($text))
    }
    return @{
        text = $text
        tex_list = $tex_list
    }
}
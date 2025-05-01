##############################################################################
# 追加処理HOOK
##############################################################################

#-----------------------------------------------------------------------------
# 追加の初期化
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function hook_initialize() 
{
}

#-----------------------------------------------------------------------------
# HTMLの追加加工処理
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function hook_modify_html( $text ) 
{
    
    ## Obsidianへのコピペ対策
    # htmlをそのまま使うなら不要
    
    #return $text ;# 要らないならここでreturn
    
    if ($type -eq 'TechHan') {
        ## 2部-1章-1.1 MSX BASIC ver2.0の命令
        # tableの使い方が独特なので表現を置き換える
        $text = ($text -replace "<dt>","<tr><th align=`"left`">")
        $text = ($text -replace "</dt>","</th></tr>")
        $text = ($text -replace "<dd>","<tr><td>")
        $text = ($text -replace "</dd>","</td></tr>")
        $text = ($text -replace "<dl>","<table>")
        $text = ($text -replace "</dl>","</table>")
    }
    elseif ($type -eq 'datapack') {
        ## BIOSエントリ名だけに変則的にdlを使用してる
        #<dl>
        #<dt>CHKRAM (0000H/MAIN)</dt>
        #<dd></dd>
        #</dl>

        #$text = ($text -replace "<dt>","<h4>")
        #$text = ($text -replace "</dt>","</h4>")
        #$text = ($text -replace "<dd></dd>`n","")
        #$text = ($text -replace "<dl>`n","")
        #$text = ($text -replace "</dl>`n","")

        $text = ($text -replace "<dl>`n<dt>([^<]+)</dt>`n<dd></dd>`n</dl>","<h4>`$1</h4>")
            
        $s = @(
        "<p>　C000H番地が実行アドレスであるマシン語プログラムを呼び出す。<br>"
        "</p>"
        "<p>　　　　DEF USR=&amp;HC000<br>"
        "　　　　A=USR(0)<br>"
        "</p>"
        )
        $d = @(
        "<p>　C000H番地が実行アドレスであるマシン語プログラムを呼び出す。<br>"
        "</p>"
        "<pre><code>        DEF USR=&amp;HC000"
        "        A=USR(0)"
        "</code></pre>"
        )
        $text = $text.Replace(($s -join "`n"), ($d -join "`n"))
    }
    return $text
}

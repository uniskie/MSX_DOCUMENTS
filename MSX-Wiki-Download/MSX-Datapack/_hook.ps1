##############################################################################
# 追加処理HOOK
##############################################################################
$use_katex = $True;# KATEXを使用して数式を表示するなら$Trueにする

#-----------------------------------------------------------------------------
# 追加の初期化
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function hook_initialize() {
	if ($type -eq 'datapack') {
	### KATEX (Google Chart API廃止に伴う置き換え)
	## localの物はセキュリティ制限で使えない模様？
	#if ($use_katex) {
	#	$dir_list = @(
	#		'..\theme\katex'
	#		'..\theme\katex\contrib'
	#		'..\theme\katex\fonts'
	#	)
	#	foreach ($i in $dir_list) {
	#		MakeSubDir $i
	#	}
	#}
	}
}

#-----------------------------------------------------------------------------
# HTMLの追加加工処理
# (porc_html から呼び出される)
#-----------------------------------------------------------------------------
function hook_modify_html( $text ) {
	
	if ($type -eq 'datapack') {
	if ($use_katex) {
		## KATEX (Google Chart API廃止に伴う置き換え)
		# localの物はセキュリティ制限で使えない模様？
		$s = "<title>"
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
		'<title>') -join "`n"
		#$d = @(
		#'	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
		##'	<link rel="stylesheet" href="../theme/katex/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">'
		#'<script type="module">'
		#'    import renderMathInElement from "https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.mjs";'
		##'    import renderMathInElement from "../theme/katex/contrib/auto-render.mjs";'
		#'    renderMathInElement(document.body);'
		#'</script>') -join "`n"
		$text = $text.Replace($s, $d)
	}
	}
	
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
		) -join "`n"
		$d = @(
		"<p>　C000H番地が実行アドレスであるマシン語プログラムを呼び出す。<br>"
		"</p>"
		"<pre><code>        DEF USR=&amp;HC000"
		"        A=USR(0)"
		"</code></pre>"
		) -join "`n"
		$text = $text.Replace($s, $d)
	}
	return $text
}

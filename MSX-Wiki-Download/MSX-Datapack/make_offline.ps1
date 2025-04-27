##############################################################################
$type = 'datapack'
$list = @(
	@('FrontPage'                                   , 'FrontPage'                                   ),
	@('Help'                                        , 'Help'                                             ),
	@('修正履歴'                                    , '修正履歴'                                         ),
	@("はじめに"                                    , "0-0 はじめに"                                     ),
	@("ご注意"                                      , "0-1 ご注意"                                       ),
	@("このマニュアルの読み方"                      , "0-2 このマニュアルの読み方"                       ),
	@("1部 ハードウェア"                            , "1部 ハードウェア"                                 ),
	@("1章 概略仕様"                                , "1部-1章 概略仕様"                                 ),
	@("2章 主要ユニット"                            , "1部-2章 主要ユニット"                             ),
	@("3章 インターフェイス"                        , "1部-3章 インターフェイス"                         ),
	@("4章 カートリッジ"                            , "1部-4章 カートリッジ"                             ),
	@("5章 システムを拡張する際の注意"              , "1部-5章 システムを拡張する際の注意"               ),
	@("6章 アドレスマップ"                          , "1部-6章 アドレスマップ"                           ),
	@("7章 MSX2 回路例"                             , "1部-7章 MSX2 回路例"                              ),
	@("2部 システムソフトウェア"                    , "2部 システムソフトウェア"                         ),
	@("1章 ブートシーケンス"                        , "2部-1章 ブートシーケンス"                         ),
	@("2章 割り込み"                                , "2部-2章 割り込み"                                 ),
	@("3章 BASIC"                                   , "2部-3章 BASIC"                                    ),
	@("2部 3.3 BASICの文法"                         , "2部-3章-3 BASICの文法"                            ),
	@("2部 3.13 ステートメント"                     , "2部-3章-13 ステートメント"                        ),
	@("4章 BASICの内部構造"                         , "2部-4章 BASICの内部構造"                          ),
	@("5章 マシン語とのリンク"                      , "2部-5章 マシン語とのリンク"                       ),
	@("6章 内部ルーチン"                            , "2部-6章 内部ルーチン"                             ),
	@("7章 プログラム開発の諸注意"                  , "2部-7章 プログラム開発の諸注意"                   ),
	@("3部 MSX-DOS"                                 , "3部 MSX-DOS"                                      ),
	@("1章 MSX-DOSの概要"                           , "3部-1章 MSX-DOSの概要"                            ),
	@("2章 MSX-DOSの操作"                           , "3部-2章 MSX-DOSの操作"                            ),
	@("2.1 MSX-DOSの起動と終了"                     , "3部-2章-1 MSX-DOSの起動と終了"                    ),
	@("2.2 ファイル"                                , "3部-2章-2 ファイル"                               ),
	@("2.3 コマンドの概要"                          , "3部-2章-3 コマンドの概要"                         ),
	@("2.4 コマンド一覧"                            , "3部-2章-4 コマンド一覧"                           ),
	@("2.5 特殊キーの機能"                          , "3部-2章-5 特殊キーの機能"                         ),
	@("2.6 バッチ処理"                              , "3部-2章-6 バッチ処理"                             ),
	@("2.7 MSX-DOSメッセージ一覧"                   , "3部-2章-7 MSX-DOSメッセージ一覧"                  ),
	@("3章 MSX-DOSの構造"                           , "3部-3章 MSX-DOSの構造"                            ),
	@("4章 ファンクションコール"                    , "3部-4章 ファンクションコール"                     ),
	@("4部 VDP"                                     , "4部 VDP"                                          ),
	@("1章 V9938の構成"                             , "4部-1章 V9938の構成"                              ),
	@("2章 基本入出力"                              , "4部-2章 基本入出力"                               ),
	@("3章 レジスタの機能"                          , "4部-3章 レジスタの機能"                           ),
	@("4章 V9938の画面モード"                       , "4部-4章 V9938の画面モード"                        ),
	@("5章 V9938のコマンド"                         , "4部-5章 V9938のコマンド"                          ),
	@("6章 スプライト"                              , "4部-6章 スプライト"                               ),
	@("7章 その他の機能"                            , "4部-7章 その他の機能"                             ),
	@("8章 V9958の構成"                             , "4部-8章 V9958の構成"                              ),
	@("9章 YJK方式"                                 , "4部-9章 YJK方式"                                  ),
	@("10章 V9958の画面モード"                      , "4部-10章 V9958の画面モード"                       ),
	@("5部 スロットとカートリッジ"                  , "5部 スロットとカートリッジ"                       ),
	@("1章 スロット"                                , "5部-1章 スロット"                                 ),
	@("2章 インタースロットコール"                  , "5部-2章 インタースロットコール"                   ),
	@("3章 カートリッジソフトの作成法"              , "5部-3章 カートリッジソフトの作成法"               ),
	@("6部 標準的な周辺機器のアクセス"              , "6部 標準的な周辺機器のアクセス"                   ),
	@("1章 PSGと音声出力"                           , "6部-1章 PSGと音声出力"                            ),
	@("2章 カセット･インターフェイス"               , "6部-2章 カセット･インターフェイス"                ),
	@("3章 キーボード・インターフェイス"            , "6部-3章 キーボード・インターフェイス"             ),
	@("4章 プリンタ・インターフェイス"              , "6部-4章 プリンタ・インターフェイス"               ),
	@("5章 汎用入出力インターフェイス"              , "6部-5章 汎用入出力インターフェイス"               ),
	@("6章 CLOCKとバッテリバックアップ・メモリ"     , "6部-6章 CLOCKとバッテリバックアップ・メモリ"      ),
	@("7部 オプションの周辺機器"                    , "7部 オプションの周辺機器"                         ),
	@("1章 MSX RS-232C"                             , "7部-1章 MSX RS-232C"                              ),
	@("2章 MSX MODEM"                               , "7部-2章 MSX MODEM"                                ),
	@("3章 MSX-MUSIC"                               , "7部-3章 MSX-MUSIC"                                ),
	@("3.1 MSX-MUSIC ハードウェア"                  , "7部-3章-1 MSX-MUSIC ハードウェア"                 ),
	@("3.2 MSX-MUSIC 拡張BASIC"                     , "7部-3章-2 MSX-MUSIC 拡張BASIC"                    ),
	@("3.3 FM BIOS"                                 , "7部-3章-3 FM BIOS"                                ),
	@("3.4 YM2413(OPLL)"                            , "7部-3章-4 YM2413(OPLL)"                           ),
	@("4章 MSX-AUDIO"                               , "7部-4章 MSX-AUDIO"                                ),
	@("4.1 MSX-AUDIO ハードウェア"                  , "7部-4章-1 MSX-AUDIO ハードウェア"                 ),
	@("4.2 MSX-AUDIO 拡張BASIC"                     , "7部-4章-2 MSX-AUDIO 拡張BASIC"                    ),
	@("4.3 MSX-AUDIO 拡張BIOS"                      , "7部-4章-3 MSX-AUDIO 拡張BIOS"                     ),
	@("4.4 MSX-AUDIO MBIOS"                         , "7部-4章-4 MSX-AUDIO MBIOS"                        ),
	@("4.5 Y8950(MSX-AUDIO)"                        , "7部-4章-5 Y8950(MSX-AUDIO)"                       ),
	@("5章 MSX-JE"                                  , "7部-5章 MSX-JE"                                   ),
	@("6章 24ドット漢字プリンタ"                    , "7部-6章 24ドット漢字プリンタ"                     ),
	@("7章 MSX拡張BIOS仕様"                         , "7部-7章 MSX拡張BIOS仕様"                          ),
	@("APPENDEX"                                    , "Appendix"                                         ),
	@("Appendix A.1 BIOS 一覧"                      , "Appendix A.1 BIOS 一覧"                           ),
	@("Appendix A.2 ワークエリア"                   , "Appendix A.2 ワークエリア"                        ),
	@("Appendix A.3 VRAM マップ"                    , "Appendix A.3 VRAM マップ"                         ),
	@("Appendix A.4 IO マップ"                      , "Appendix A.4 IO マップ"                           ),
	@("Appendix A.5 拡張IOポート"                   , "Appendix A.5 拡張IOポート"                        ),
	@("Appendix A.6 スーパーインポーズ"             , "Appendix A.6 スーパーインポーズ"                  ),
	@("Appendix A.7 サンプルプログラム"             , "Appendix A.7 サンプルプログラム"                  ),
	@("Appendix A.8 エスケープシーケンス"           , "Appendix A.8 エスケープシーケンス"                ),
	@("Appendix A.9 コントロールコード"             , "Appendix A.9 コントロールコード"                  ),
	@("Appendix A.10 キャラクタコード表"            , "Appendix A.10 キャラクタコード表"                 ),
	@("Appendix A.11 グラフィックキャラクタコード表", "Appendix A.11 グラフィックキャラクタコード表"     ),
	@("Appendix A.12 トークン順の中間コード一覧"    , "Appendix A.12 トークン順の中間コード一覧"         ),
	@("Appendix A.13 ファンクションコール一覧"      , "Appendix A.13 ファンクションコール一覧"           ),
	@("turboR版"                                    , "turboR版"                                         ),
	@("はじめに_Vol3"                               , "turboR版 0-0 はじめに_Vol3"                       ),
	@("ご注意_Vol3"                                 , "turboR版 0-1 ご注意_Vol3"                         ),
	@("このマニュアルの表記法"                      , "turboR版 0-2 このマニュアルの表記法"              ),
	@("1部 MSX turbo R"                             , "turboR版 1部 MSX turbo R"                         ),
	@("1章 MSX turbo Rとは"                         , "turboR版 1部-1章 MSX turbo Rとは"                 ),
	@("2章 システム構成"                            , "turboR版 1部-2章 システム構成"                    ),
	@("3章 システムの動作モード"                    , "turboR版 1部-3章 システムの動作モード"            ),
	@("4章 BASIC"                                   , "turboR版 1部-4章 BASIC"                           ),
	@("5章 BIOS"                                    , "turboR版 1部-5章 BIOS"                            ),
	@("6章 マッパーRAMセグメント"                   , "turboR版 1部-6章 マッパーRAMセグメント"           ),
	@("7章 新しいハードウェア"                      , "turboR版 1部-7章 新しいハードウェア"              ),
	@("8章 アプリケーション作成上の注意"            , "turboR版 1部-8章 アプリケーション作成上の注意"    ),
	@("2部 MSX-DOS2"                                , "turboR版 2部 MSX-DOS2"                            ),
	@("1章 MSX-DOS2とは"                            , "turboR版 2部-1章 MSX-DOS2とは"                    ),
	@("2章 コマンド行の編集"                        , "turboR版 2部-2章 コマンド行の編集"                ),
	@("バージョンアップにともなう変更点"            , "turboR版 2部-2章 バージョンアップにともなう変更点"),
	@("4章 MSX-DOS2への移植の注意"                  , "turboR版 2部-4章 MSX-DOS2への移植の注意"          ),
	@("5章 コマンド"                                , "turboR版 2部-5章 コマンド"                        ),
	@("6章 リダイレクションとパイプ"                , "turboR版 2部-6章 リダイレクションとパイプ"        ),
	@("7章 バッチファイル"                          , "turboR版 2部-7章 バッチファイル"                  ),
	@("8章 環境変数の設定"                          , "turboR版 2部-8章 環境変数の設定"                  ),
	@("9章 エラーおよびメッセージ"                  , "turboR版 2部-9章 エラーおよびメッセージ"          ),
	@("10章 Disk BASIC version 2.0"                 , "turboR版 2部-10章 Disk BASIC version 2.0"         ),
	@("11章 日本語処理"                             , "turboR版 2部-11章 日本語処理"                     ),
	@("12章 外部プログラムの環境"                   , "turboR版 2部-12章 外部プログラムの環境"           ),
	@("13章 ディスクファイルの構造"                 , "turboR版 2部-13章 ディスクファイルの構造"         ),
	@("14章 画面制御コード"                         , "turboR版 2部-14章 画面制御コード"                 ),
	@("15章 マッパーサポートルーチン"               , "turboR版 2部-15章 マッパーサポートルーチン"       ),
	@("16章 エラー"                                 , "turboR版 2部-16章 エラー"                         ),
	@("17章 ファンクションコール"                   , "turboR版 2部-17章 ファンクションコール"           ),
	@("3部 MSXView"                                 , "turboR版 3部 MSXView"                             ),
	@("1章 MSXViewとは"                             , "turboR版 3部-1章 MSXViewとは"                     ),
	@("2章 MSXViewファンクションの使い方"           , "turboR版 3部-2章 MSXViewファンクションの使い方"   ),
	@("3章 MSXViewの構成と機能"                     , "turboR版 3部-3章 MSXViewの構成と機能"             ),
	@("4章 ハンドルの概念"                          , "turboR版 3部-4章 ハンドルの概念"                  ),
	@("5章 APの標準レイアウト"                      , "turboR版 3部-5章 APの標準レイアウト"              ),
	@("6章 操作における規定事項"                    , "turboR版 3部-6章 操作における規定事項"            ),
	@("7章 ファイルの形式"                          , "turboR版 3部-7章 ファイルの形式"                  ),
	@("8章 オーバーレイプログラムの作成"            , "turboR版 3部-8章 オーバーレイプログラムの作成"    ),
	@("9章 MSXView基本データ構造"                   , "turboR版 3部-9章 MSXView基本データ構造"           ),
	@("10章 MSXView標準データ"                      , "turboR版 3部-10章 MSXView標準データ"              ),
	@("11章 ディスプレイマネージャ"                 , "turboR版 3部-11章 ディスプレイマネージャ"         ),
	@("12章 ビットブロックマネージャ"               , "turboR版 3部-12章 ビットブロックマネージャ"       ),
	@("13章 グラフパック"                           , "turboR版 3部-13章 グラフパック"                   ),
	@("14章 フォントパック"                         , "turboR版 3部-14章 フォントパック"                 ),
	@("15章 テキストマネージャ"                     , "turboR版 3部-15章 テキストマネージャ"             ),
	@("16章 リソースマネージャ"                     , "turboR版 3部-16章 リソースマネージャ"             ),
	@("17章 イベントマネージャ"                     , "turboR版 3部-17章 イベントマネージャ"             ),
	@("18章 コントロールマネージャ"                 , "turboR版 3部-18章 コントロールマネージャ"         ),
	@("19章 メニューマネージャ"                     , "turboR版 3部-19章 メニューマネージャ"             ),
	@("20章 ダイアログマネージャ"                   , "turboR版 3部-20章 ダイアログマネージャ"           ),
	@("21章 その他マネージャ"                       , "turboR版 3部-21章 その他マネージャ"               ),
	@("22章 オーバーレイの使い方"                   , "turboR版 3部-22章 オーバーレイの使い方"           ),
	@("4部 MSX-MIDI"                                , "turboR版 4部 MSX-MIDI"                            ),
	@("1章 MSX-MIDIとは"                            , "turboR版 4部-1章 MSX-MIDIとは"                    ),
	@("2章 ハードウェア"                            , "turboR版 4部-2章 ハードウェア"                    ),
	@("3章 割り込み"                                , "turboR版 4部-3章 割り込み"                        ),
	@("4章 アプリケーションの開発"                  , "turboR版 4部-4章 アプリケーションの開発"          ),
	@("5章 拡張BASIC"                               , "turboR版 4部-5章 拡張BASIC"                       ),
	@("APPENEX turbo R"                             , "turboR版 Appendix turbo R"                        ),
	@("A R800 インストラクション表"                 , "turboR版 Appendix-A R800 インストラクション表"    ),
	@("B R800 かけ算命令マクロ"                     , "turboR版 Appendix-B R800 かけ算命令マクロ"        ),
	@("C MSXView ファンクション一覧"                , "turboR版 Appendix-C MSXView ファンクション一覧"   ),
	@("D サンプルプログラム"                        , "turboR版 Appendix-D サンプルプログラム"           )
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

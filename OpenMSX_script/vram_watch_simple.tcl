#───────────────────────────────────────
# VRAM書き換え監視 簡易版（汎用）（非常に重い）
#
# ファイル名:
#     vram_simple.tcl
#
# 保存先のおすすめ:
#     Windows:
#         C:\Users\ユーザー名\openMSX\share\scripts\
#     macOS/Linux:
#         ~/.openMSX/share/scripts/
# （※scripts フォルダがない場合は作成してください）
#
# 使用方法: 
#     ※ コンソール(F10)から
#
#        source $::env(OPENMSX_USER_DATA)/scripts/vram_simple.tcl
#
#     実行した時点での値を保存してZ80命令を何か実行するたびに比較する
#
# 使用方法その2: 
#     ※ コンソール(F10)から
#
#     一行ずつ直接打ち込んで実行
#
# UIを使用して消す方法：
#     Debugger→BreakPoints→Editor でGUI表示
#     BreakPointWindowのConditionsタブに表示される
#     参考画像: debugger_ss.png
#───────────────────────────────────────
# 監視アドレス
set v_addr 0x1800
# 変数に現在の値を保存
set old_value [vpeek $v_addr]
# 値が変化したらブレークし、変数を更新する条件をセット
debug set_condition {[vpeek $::v_addr] != $::old_value} { set ::old_value [vpeek $::v_addr] ; debug break }

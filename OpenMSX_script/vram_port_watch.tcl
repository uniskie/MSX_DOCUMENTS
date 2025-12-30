#───────────────────────────────────────
# VRAMポートアクセス限定の書き換え監視（比較的軽量）
#
# ファイル名:
#     vram_port_watch.tcl
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
#     ① 読み込み
#        source $::env(OPENMSX_USER_DATA)/scripts/vram_port_watch.tcl
#
#     ② 現時点の値から変化するかどうか監視開始
#         vram_port_watch::watch_at 7 1 100 50
#        （スクリーン7、ページ1、X=100、Y=50にセットする例）
#       または
#         vram_port_watch::set_watch 0x856
#        （アドレス0x856を指定する例）
#
#     ③ 監視終了
#         vram_port_watch::stop_watch
#
#     Debugger→BreakPoints→Editor でGUI表示
#     BreakPointWindowのWatchタブに表示される
#───────────────────────────────────────
# vram_port_watch.tcl

namespace eval ::vram_port_watch {
    variable target_address 0
    variable last_wp_id ""

    # 1. 検出時の処理（ブレーク）
    proc on_detected {addr val} {
        puts "--- VRAM PORT WRITE DETECTED & BREAK ---"
        puts [format "Target Addr : 0x%05X" $addr]
        puts [format "Write Value : 0x%02X (%d)" $val $val]
        debug break
    }

    # 2. 監視停止
    proc stop_watch {} {
        variable last_wp_id
        if {$last_wp_id ne ""} {
            catch {debug remove_watchpoint $last_wp_id}
            set last_wp_id ""
        }
    }

    # 3. ウォッチポイント設定（wp_last_value 利用版）
    proc set_watch {addr} {
        variable last_wp_id
        stop_watch

        # subst を用いてアドレスを数値定数化。
        # [vdpvramaddress] は実行時に評価されるようエスケープ。
        # wp_last_value は書き込み命令実行時の実データを保持する変数。
        set action [subst {
            if {\[vdpvramaddress\] == $addr} {
                ::vram_port_watch::on_detected $addr \$wp_last_value
            }
        }]

        # ポート0x98への書き込みをトリガーに設定
        set last_wp_id [debug set_watchpoint write_io 0x98 {} $action]
        
        puts [format "VRAM Port Watch active (ID:%s): 0x%05X" $last_wp_id $addr]
    }

    # 4. スクリーンモード番号によるアドレス計算（エラーガイド付）
    proc calc_address {mode page x y} {
        set offset 0
        set valid 1
        switch -exact -- $mode {
            0 { set offset [expr {$y * 40 + $x}] } ;# TEXT1
            "T2" { set offset [expr {$y * 80 + $x}] } ;# TEXT2
            1 - 2 - 3 - 4 { set offset [expr {$y * 32 + $x}] } ;# S1-S4
            5 { set offset [expr {$page * 0x8000 + $y * 128 + ($x / 2)}] }
            6 { set offset [expr {$page * 0x8000 + $y * 128 + ($x / 4)}] }
            7 { set offset [expr {$page * 0x8000 + $y * 256 + ($x / 2)}] }
            8 - 9 - 10 - 11 - 12 { set offset [expr {$page * 0x8000 + $y * 256 + $x}] }
            default { set valid 0 }
        }

        if {!$valid} {
            puts "\[ERROR\] Invalid Screen Mode: '$mode'"
            puts "--- Available Screen Modes ---"
            puts "  0          : TEXT1 (40x24)"
            puts "  \"T2\"       : TEXT2 (80x24)"
            puts "  1, 2, 3, 4 : SCREEN 1-4"
            puts "  5, 6       : SCREEN 5, 6"
            puts "  7, 8       : SCREEN 7, 8"
            puts "  10, 11, 12 : SCREEN 10, 11, 12"
            return -code error "Invalid Mode"
        }
        return $offset
    }

    # 5. 座標指定監視開始
    proc watch_at {mode page x y} {
        if {[catch {set addr [calc_address $mode $page $x $y]} err]} { return }
        set_watch $addr
    }
}

#───────────────────────────────────────
# VRAMポート書き込みアクセスのログを取る
#
# ファイル名:
#     vram_port_log.tcl
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
#     ① スクリプトを読み込んで使用できるようにする
#
#        source $::env(OPENMSX_USER_DATA)/scripts/vram_port_log.tcl
#
#     ② 記録を開始する
#
#         vram_port_log::start 2000
#
#     ③記録を止める（または上限まで待つ）
#
#         vram_port_log::stop
#
#     ④ログをコンソールに表示する
#
#         vram_port_log::show_log
#
#     ⑤ファイルを保存する
#       （エクスプローラーからコピーしたパスを { } で囲む）
#
#         vram_port_log::save_log {C:\msx\logs\vram_data.csv}
#
#     ⑥ログを消す
#
#         vram_port_log::clear_log
#
#───────────────────────────────────────
# vram_port_log.tcl

# VRAM書き込みログ記録スクリプト

namespace eval ::vram_port_log {
    variable write_history [list]
    variable max_history 2000
    variable last_wp_id ""

    # ログをコンソールに表示
    proc show_log {} {
        variable write_history
        set count [llength $write_history]
        puts "--- VRAM Write Log (Address & Value) ---"
        puts "Current log count: $count"
        if {$count == 0} {
            puts "No data recorded."
        } else {
            foreach entry $write_history {
                lassign $entry time addr val
                puts [format "Time: %.3f sec | Addr: 0x%05X | Value: 0x%02X (%d)" $time $addr $val $val]
            }
        }
    }

    # 履歴をクリア
    proc clear_log {} {
        set ::vram_port_log::write_history [list]
        puts "VRAM Log cleared."
    }

    # ウォッチポイントを削除して監視を終了
    proc stop {} {
        variable last_wp_id
        if {$last_wp_id ne ""} {
            catch {debug remove_watchpoint $last_wp_id}
            set last_wp_id ""
            puts "VRAM Logging stopped."
        }
    }

    # VRAMデータポート(0x98)への書き込み監視を開始
    proc start {{max 2000}} {
        variable max_history
        variable last_wp_id
        set max_history $max
        
        clear_log
        stop

        # I/Oポート書き込み時にデータを蓄積するスクリプト
        set action [subst {
            lappend ::vram_port_log::write_history \[list \[openmsx_info realtime\] \[vdpvramaddress\] \$wp_last_value\]

            if {\[llength \$::vram_port_log::write_history\] >= $max_history} {
                debug remove_watchpoint \$::vram_port_log::last_wp_id
                set ::vram_port_log::last_wp_id ""
                puts "VRAM Log limit reached. Stopped."
            }
        }]

        # 0x98ポートへの書き込みを監視
        set last_wp_id [debug set_watchpoint write_io 0x98 {} $action]
        puts "VRAM Logging started (ID: $last_wp_id, Max: $max_history)..."
    }

    # ログをCSV形式でファイルに保存
    proc save_log {filepath} {
        variable write_history
        if {[llength $write_history] == 0} {
            puts "No data to save."
            return
        }

        set path [file normalize $filepath]
        if {[catch {open $path w} f]} {
            puts "ERROR: Could not open file: $path"
            return
        }

        puts $f "Time(sec),Address(hex),Value(dec)"
        foreach entry $write_history {
            lassign $entry time addr val
            puts $f [format "%.3f,0x%05X,%d" $time $addr $val]
        }
        close $f
        puts "Log saved to: $path ([llength $write_history] entries)"
    }
}

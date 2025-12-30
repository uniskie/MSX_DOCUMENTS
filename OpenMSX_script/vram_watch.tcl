#───────────────────────────────────────
# VRAM書き換え監視 （非常に重い）
#
# ファイル名:
#     vram_watch.tcl
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
#        source $::env(OPENMSX_USER_DATA)/scripts/vram_watch.tcl
#
#     ② 現時点の値から変化するかどうか監視開始
#        （スクリーン7、ページ1、X=100、Y=50の例）
#         vram_watch::start_watch 7 1 100 50
#       または
#         vramwatch 7 1 100 50
#
#     ③ 監視終了
#         vram_watch::stop
#       または
#         vramwatch
#───────────────────────────────────────
# vram_watch.tcl
namespace eval vram_watch {
    variable cond_id
    variable old_val
    variable current_info ""

    # --- 1. 条件成立時の処理 ---
    proc on_hit {v_addr} {
        variable old_val
        variable current_info

        # 現在の値を取得し更新
        set old_val [vpeek $v_addr]

        puts "----------------------------------------"
        puts "VRAM Access Detected!"
        puts "Target: $current_info"
        puts "Address: 0x[format %X $v_addr]"
        puts "Value: [format %d $old_val] (0x[format %02X $old_val])"
        puts "----------------------------------------"

        # 実行を中断
        debug break
    }

    # --- 2. 監視を開始する関数 (start_watch) ---
    proc start_watch {mode page x y} {
        variable cond_id
        variable old_val
        variable current_info

        # スクリーンモードに応じた計算設定
        switch $mode {
            5 - 7  { set line_size 256; set page_size 0x8000; set addr_x [expr {$x / 2}] }
            8 - 12 { set line_size 256; set page_size 0x10000; set addr_x $x }
            6 - 9  { set line_size 128; set page_size 0x8000; set addr_x [expr {$x / 4}] }
            default { error "Unsupported SCREEN mode: $mode" }
        }

        # アドレス計算
        set v_addr [expr {$page * $page_size + $y * $line_size + $addr_x}]
        set old_val [vpeek $v_addr]
        set current_info "SCREEN $mode Page:$page ($x,$y)"

        # 二重登録防止
        stop

        # 条件セット（ヒット時に関数を呼び出し）
        set cond_id [debug set_condition \
            "\[vpeek $v_addr\] != \$::vram_watch::old_val" \
            "::vram_watch::on_hit $v_addr" \
        ]

        puts "Watch started: $current_info (Addr: 0x[format %X $v_addr])"
    }

    # --- 3. 監視を停止する関数 ---
    proc stop {} {
        variable cond_id
        if {[info exists cond_id]} {
            catch {debug remove_condition $cond_id}
            unset cond_id
            puts "VRAM watch stopped."
        }
    }
}

# --- 4. ショートカットコマンド (vw) ---
# コンソールから手軽に呼び出すためのエイリアス
proc vramwatch {args} {
    if {[llength $args] == 0} {
        vram_watch::stop
    } else {
        vram_watch::start_watch {*}$args
    }
}

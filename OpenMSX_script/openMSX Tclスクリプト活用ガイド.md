
openMSXでスクリプトを活用する際に困りそうな項目をまとめたガイドです。

---

## 1. 配置と自動読み込みの「命名ルール」
ファイル名の先頭文字が、起動時の挙動（自動実行の有無）を決定します。

### 1.1 ファイル名先頭のアンダースコア (`_`) の意味
*   **`_` なし (例: `init.tcl`)**
    *   **挙動**: 起動時にシステムが自動で読み込み（source）、即実行されます。
    *   **用途**: キーの `bind` 設定、起動時の初期化、常に使うメインコマンド。
*   **`_` あり (例: `_library.tcl`)**
    *   **挙動**: 起動時は**無視**されます。
    *   **読み込み経路**:
        1. コンソールでコマンドを打った瞬間に、ファイル名と一致すれば自動で読み込まれる（オートロード機能）。
        2. 他のスクリプトから明示的に `source` された時に読み込まれる。
    *   **用途**: ライブラリ、特定の時だけ使う重いツール。

### 1.2 配置パス（機種・環境依存を排除）
スクリプト内では物理パスを直接書かず、必ずシステム変数を使用します。
*   **推奨パス**: `[file join $env(OPENMSX_USER_DATA) share scripts]`
*   **各OSの実際のパス（参考値）**:
    *   **Windows**: `C:\Users\ユーザー名\Documents\openMSX`
    *   **macOS**: `/Users/ユーザー名/Library/Application Support/openMSX`
    *   **Linux**: `~/.openMSX`

---

## 2. 移植性を高めるパス操作と環境変数
2025年現在のどのOS（Windows/Mac/Linux）でも動かすための必須作法です。

1.  **OSの差を吸収する `file join`**
    *   `set path [file join $dir "data" "test.dsk"]`
    *   Windowsの `\` と他OSの `/` の差異を自動調整します。
2.  **スクリプト自身の場所を取得**
    *   `set base [file dirname [info script]]`
    *   自身の隣にあるファイルを相対的に指す際に必須です。
3.  **システム変数の活用**
    *   **`$env(OPENMSX_USER_DATA)`**: ユーザー設定・保存用フォルダを取得。
    *   **`$env(OPENMSX_SYSTEM_DATA)`**: openMSX本体のインストールフォルダを取得。

---

## 3. 名前空間 (namespace) と正しいヘルプ・コールバックの実装
他の機能を破壊せず、公式コマンドのように振る舞わせるための高度な書き方です。

### 3.1 公式準拠の namespace 構造
```tcl
namespace eval MyTool {
    # 1. 変数の宣言（namespace内共有）
    variable count 0
    variable target_addr 0xD000

    # 2. 内部関数の定義
    proc increment {} {
        variable count
        set count [expr {$count + 1}]
        puts "現在のカウント: $count"
    }

    # 3. 【最重要】コールバック登録と namespace code
    # [namespace code 関数名] と書くことで、現在のネームスペースを自動認識し、
    # 外側（本体側）からでも呼び出せる「完全パス（絶対参照）」に自動変換します。
    proc setup_watch {addr} {
        variable target_addr
        set target_addr $addr
        # 本体側のフックに、自分のネームスペース内の関数を教える
        debug set_watchpoint write_mem $target_addr {} [namespace code on_write]
    }

    proc on_write {} {
        osd message "指定アドレスへの書き込みを検知しました！"
    }

    # 4. 公開したい関数を指定
    namespace export increment setup_watch
}

# 5. グローバルへの公開（これを書くと MyTool:: なしで呼び出せる）
namespace import MyTool::*

# 6. ヘルプと Usage（構文ヒント）の登録
# help: 「何をするか」の説明文
# help_usage: 「どう書くか」の引数構文。タブ補完や help 表示時に Usage: として出る
help increment "カウントを1増やします。"
help_usage increment ""

help setup_watch "特定のメモリアドレスを監視します。"
help_usage setup_watch "<address>"
```

---

## 4. Tclの「マジックワード」と特殊記号
*   **計算の `expr`**: `set a [expr {$b + 1}]` （これがないと計算できず文字列になります）
*   **結果代入の `[ ]`**: `set d [pwd]` （カッコ内のコマンドの実行結果を代入）
*   **展開制御の `{ }` と `" "`**: `" "` は展開、`{ }` はただの塊。
*   **強制展開の `subst`**: 通常は展開されない `{ }` 内で、例外的に `$変数` を展開したい時に使用。

---

## 5. 公式スクリプトに学ぶ「逆引き」実践カタログ
`share/scripts` 内の公式ファイル（主に `_` 付き）は、最高の機能サンプル集です。

### 5.1 サウンド・ミキサー制御
*   **`_mixer_widgets.tcl`**: `mixer` コマンドによる音量・バランス制御の基本。
*   **`_vgm_recorder.tcl`**: 音源チップごとの録音・チャンネル管理の自動化。
*   **`_music_keyboard.tcl`**: `debug read` でチップ内部を読み、鳴っている音階を取得する手法。

### 5.2 デバッグ・解析
*   **`_show_poked.tcl`**: `debug set_watchpoint` によるメモリ変化監視の決定版。
*   **`_disasm.tcl`**: `debug disasm` による実行中コードの逆アセンブル出力。
*   **`_vdp.tcl`**: VDPレジスタの状態読み出し。

### 5.3 画面表示 (OSD)
*   **`_osd_widgets.tcl`**: `osd create` でFPS、メッセージ、メーターを画面に重ねる。
*   **`_leds.tcl`**: 本体のLED状態（CapsLock等）に連動して描画を更新する手法。

### 5.4 自動化・イベント制御
*   **`_autofire.tcl`**: `after`（周期実行）と `type`（キー送信）の組み合わせ。
*   **`_autopause.tcl`**: フォーカス外れ等のエミュレータイベントを検知・制御する手法。
*   **`_training.tcl`**: ユーザー入力をリストに記録し、繰り返し再生する高度なリスト操作。
*   **`_auto_save_state.tcl`**: `get_info time` で時間を取得し、タイムスタンプ付きでセーブする。

### 5.5 ディスク・メディア操作
*   **`_disk_util.tcl`**: `diskmanipulator` を制御し、DSKイメージ内のファイルを一覧表示・抽出する。

---

## 6. コンソール (F10) の時短テクニック
*   **タブ補完**: コマンド、変数、パスを `Tab` で補完。
*   **履歴検索**: `Ctrl + R` で過去の履歴を呼び出し。
*   **即時反映**: ファイル書き換え後は `source [ファイルパス]` でリロード。
*   **状態確認**: コンソールで単に `set 変数名` と打てば、現在値が見える。

---

## 7. 運用のアドバイス（最短ルート）
1.  やりたい事に近い**公式スクリプトを `share/scripts` から探し**、キーワード検索する。
2.  その `proc` の中身をコピーし、自分の **`namespace eval` 内にペースト**して改造する。
3.  OS依存を避けるため **`$env(OPENMSX_USER_DATA)` と `file join`** を使う。
4.  起動時に読み込まれるよう **`_` なしの名前**で保存し、コンソールで調整する。

# openMSX Tclスクリプト活用ガイド

openMSXでスクリプトを活用する際に困りそうな項目をまとめたガイドです。

## 1. 配置と自動読み込み・手動読み込み
スクリプトをどのようにエミュレータに認識させるかのルールです。

### 1.1 ファイル名先頭のアンダースコア (_) の意味
- **_ なし (例: `init.tcl`)**
    - **挙動**: 起動時にシステムが自動で読み込み（source）、即実行されます。
    - **用途**: キーの `bind` 設定、起動時の初期化、常に使うメインコマンド。
- **_ あり (例: `_library.tcl`)**
    - **挙動**: 起動時は無視されます（手動またはオートロード用）。
    - **用途**: ライブラリ、特定の時だけ使う重いツール。

### 1.2 配置パス（機種・環境依存を排除）
スクリプト内では物理パスを直接書かず、必ずシステム変数を使用します。

- **推奨パス（正式）**: `[file join $env(OPENMSX_USER_DATA) share scripts]`
- **簡略記法（スラッシュ区切り）**: `$env(OPENMSX_USER_DATA)/share/scripts`
- **各OSの実際のパス（参考値）**:
    - **Windows**: `C:\Users\ユーザー名\Documents\openMSX\share\scripts`
    - **macOS**: `/Users/ユーザー名/Library/Application Support/openMSX/share/scripts`
    - **Linux**: `~/.openMSX/share/scripts`

### 1.3 source命令による直接読み込み
自動読み込みの対象外（`_`付きや別フォルダ）のファイルを読み込むには、コンソールで `source` 命令を使用します。
- `source {C:/path/to/script.tcl}` : 指定したファイルを即座に実行します。
- スクリプト開発中に修正を反映させたい場合、何度でも `source` することで最新の状態に更新できます。

## 2. コンソール (F10) の時短テクニック
openMSXのコンソールは非常に強力なシェル機能を備えています。開発の要です。

- **タブ補完 (Tab)**: コマンド名、変数名、ファイルパスを補完します。
- **履歴操作 (Up / Down)**: 上下矢印キーで、過去に入力したコマンドを呼び出せます。
- **履歴検索 (Ctrl + R)**: 過去の入力履歴からキーワードで検索できます。
- **行頭・行末移動**: `Ctrl + A` で行頭へ、`Ctrl + E` で行末へジャンプします。
- **画面スクロール (PageUp / PageDown)**: コンソールのログを遡って確認できます。
- **即時反映**: ファイル書き換え後は `source [パス]` でリロードするのが基本サイクルです。
- **状態確認**: コンソールで単に `set 変数名` と打てば、現在の値が表示されます。

## 3. 移植性を高めるパス操作と環境変数
どのOS（Windows/Mac/Linux）でも動かすための必須作法です。

- **OSの差を吸収する `file join`**
    - `set path [file join $dir "data" "test.dsk"]`
- **スクリプト自身の場所を取得**
    - `set base [file dirname [info script]]`
    - 自身の隣にあるファイルを相対的に指す際に必須です。
- **システム変数の活用**
    - `$env(OPENMSX_USER_DATA)`: ユーザー設定・保存用フォルダを取得。
    - `$env(OPENMSX_SYSTEM_DATA)`: openMSX本体のインストールフォルダを取得。

## 4. Tclの「マジックワード」と特殊記号
初心者が特につまずきやすい、TclおよびopenMSXスクリプト特有の記述ルールです。

### 4.1 基本コマンド
- **`set` / `unset`**: 変数の代入と削除。
- **`incr`**: 数値を加算。 `incr count` (1増やす)、 `incr count 5` (5増やす)
- **`puts`**: コンソールへの文字列出力。デバッグの基本です。
- **`expr`**: 計算命令。 `set a [expr {$b + 1}]` （これを通さないと計算されません）

### 4.2 記号の意味
- **`$` (変数展開)**: 変数の中身を参照します。 `set b $a`
- **`[` `]` (コマンド置換)**: カッコ内を先に実行し、その結果を外側に渡します。
- **`{ }` (グループ化・非展開)**: 中身を一塊として扱い、内部の変数展開は行いません。
- **`"` `"` (グループ化・展開)**: 中身を一塊として扱い、内部の変数（`$`）を展開します。
- **`\` (エスケープ / 行継続)**:
    - 特殊記号をただの文字として扱う（例: `\$`）。
    - 行末に置くことで、長い命令を次の行へ継続させます。

### 4.3 データの扱いと注意点
- **16進数**: `0x` を付けた値（例: `0xD000`）は数値として計算可能です。比較は `[expr {$addr == 0xD000}]` 内で行います。
- **リスト操作**: `lindex` (取得)、`lappend` (追加)。メモリデータの加工に多用します。
- **制御構造のスペース**: `if` や `for` の条件式 `{ }` の前後には必ずスペースが必要です。

## 5. 名前空間 (namespace) と正しいヘルプ・コールバックの実装
他の機能を破壊せず、公式コマンドのように振る舞わせるための記述方法です。

### 5.1 名前空間を使用する目的と利点
- **競合の防止**: 自分専用の領域を確保し、他のスクリプトの関数を誤って上書きする事故を防ぎます。
- **モジュール化**: 関連する変数と関数を一括管理でき、コードの可読性が向上します。
- **コールバックの確実な参照**: `namespace code` を使うことで、外部イベントから自作関数を確実に実行させることができます。

### 5.2 公式準拠の namespace 構造

```tcl
namespace eval MyTool {
    variable count 0
    variable target_addr 0xD000

    proc increment {} {
        variable count
        set count [expr {$count + 1}]
        puts "現在のカウント: $count"
    }

    proc setup_watch {address} {
        variable target_addr
        set target_addr $address
        debug set_watchpoint write_mem $target_addr {} [namespace code on_write]
    }

    proc on_write {} {
        osd message "指定アドレスへの書き込みを検知しました！"
    }

    namespace export increment setup_watch
}

namespace import -force MyTool::*

# ヘルプの登録
set_help_text increment "カウントを1増やします。"
set_help_text setup_watch "特定のメモリアドレスを監視します。"
```

### 5.3 使用上の注意点
- **`variable` 宣言の徹底**: `proc` 内で名前空間変数を使う際は、必ず冒頭で `variable 変数名` と再宣言してください。
- **再読み込み時の初期化**: `source` でリロードすると値が上書きされます。保持したい場合は `if {![info exists count]} { variable count 0 }` と記述します。

## 6. 公式スクリプトに学ぶ「逆引き」実践カタログ
`share/scripts` 内の公式ファイル（主に `_` 付き）は、最高の機能サンプル集です。

### 6.1 サウンド・ミキサー制御
- `_mixer_widgets.tcl`: `mixer` コマンドによる音量・バランス制御の基本。
- `vgm_recorder.tcl`: 音源チップごとの録音・チャンネル管理の自動化。
- `_music_keyboard.tcl`: `debug read` でチップ内部を読み、鳴っている音階を取得。
- `_sound_log.tcl`: 特定の音源のみをファイルに記録する手法。

### 6.2 デバッグ・解析・出力
- `_show_poked.tcl`: `debug set_watchpoint` によるメモリ変化監視の決定版。
- `_disasm.tcl`: `debug disasm` による実行中コードの逆アセンブル出力。
- `_vdp.tcl`: VDPレジスタの状態読み出し。
- `_reg_display.tcl`: CPUレジスタ値をリアルタイムに取得・表示。
- `_screenshot.tcl`: スクリーンショットの管理、PNG/BMP形式指定の制御。

### 6.3 画面表示 (OSD)
- `_osd_widgets.tcl`: `osd create` でFPS、メッセージ、メーターを表示。
- `_leds.tcl`: LED状態（CapsLock等）に連動して描画を更新。
- `_visualmsx.tcl`: 独自のグラフィカルUIを構築する高度な例。

### 6.4 自動化・イベント制御
- `_autofire.tcl`: `after`（周期実行）による連射実装。
- `_autopause.tcl`: フォーカス外れ等のイベント検知・制御。
- `_reverse.tcl`: リバース（巻き戻し）機能との同期制御。
- `_callback.tcl`: 各種イベントに対するコールバック登録。
- `_training.tcl`: ユーザー入力をリストに記録し、繰り返し再生。

### 6.5 lazy.tcl による効率的なコマンド管理
- **役割**: openMSXの起動時間を短縮するための仕組みです。
- **動作**: 起動時にすべてを読み込まず、コマンドが実際に呼ばれた瞬間に該当ファイルをロードします。自作スクリプトを `_` 付きで保存することで、この仕組みの恩恵を受けられます。

## 7. 運用のアドバイス（最短ルート）
1. やりたい事に近い公式スクリプトを `share/scripts` から探し、キーワード検索する。
2. その `proc` の中身をコピーし、自分の `namespace eval` 内にペーストして改造する。
3. OS依存を避けるため `$env(OPENMSX_USER_DATA)` と `file join`（またはスラッシュ区切り）を使う。
4. 起動時に読み込まれるよう `_` なしの名前で `share/scripts` 内に保存し、コンソールで調整する。
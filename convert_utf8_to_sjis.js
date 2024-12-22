// SAKURA EDITOR MACRO
// UTF8 -> SJIS 変換保存

// 変更が必要かどうか
var need_update = false;
need_update = true; // 常に強制保存

// 文字コード（保存時）
// 0 SJIS  
// 1 JIS  
// 2 EUC  
// 3 Unicode  
// 4 UTF-8  
// 5 UTF-7  
// 6 UnicodeBE  
// 7 CESU-8  
// 8 Latin1(Windows-1252)  
// 99 文字コードを維持  
var encode_type = 0;	//SJIS
var use_bom = 0;		//BOM なし

// 改行（取得時）
// 0 CRLF  
// 1 LF  
// 2 CR  
var line_type = 0;		//CRLF

// 改行（保存時は+1）
// 0 変更しない  
// 1 CRLF  
// 2 LF  
// 3 CR  

// 文字コードが違うなら変換保存
need_update |= (Editor.GetCharCode != encode_type);

// 改行コードが違うなら変換保存
need_update |= (Editor.GetLineCode != line_type);

if (need_update) {
	//MessageBox("need update");

	// BOMの有無
	Editor.ChgCharSet( encode_type, use_bom );

	// 保存
	FileSaveAs( Editor.GetFileName, encode_type, line_type + 1 );
}
WinClose( ); // 閉じる

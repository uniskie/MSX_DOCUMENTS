# TV shader mod for OpenMSX

これはOpenMSXのTVフィルタをThemaister's NTSC shaderベースのアナログテレビ風のにじみ（クロスカラーやドット妨害）再現に変更するためのシェーダーファイルです。

## 準備 

「tv.vert」と「tv.frag」を、
「ドキュメント\OpenMSX\share\shaders」
へコピーしてください。

「ドキュメント\OpenMSX\share\」
に「shaders」フォルダが無い場合はフォルダを作成してください。

*※注) 「ドキュメント」フォルダはWindowsのユーザー毎のドキュメントフォルダです。(XP以前で言えばマイドキュメント)*

*※注) ドキュメントフォルダではなくOpenMSXインストールフォルダ配下の"OpenMSX\share\shaders"に上書きするとOpenMSXのアップデート時に元に戻ってしまいます。*

## 使用方法
準備が終わったら、

1. OpenMSX Catapultから「Start」でOpenMSXを実行
2. OpenMSX Catapultの「Video Control」タブで、「Renderer」に「SDLGL-PP」を選択
3. OpenMSX Catapultの「Video Control」タブで、「Scaler:[サイズ]x[フィルタ]」のところでフィルタに「TV」を選択

*※注) Rendererが「SDL」ではシェーダーは動作しません。*

![screenshot of video control](./screenshot_video_control.png)

-----------------------------------------------
# (in English)

This is a shader file for changing the OpenMSX TV filter to a Themaister's NTSC shader-based analog TV-like bleeding (cross-color or dot jamming) reproduction.

## setup
Please copy "tv.vert" and "tv.frag" to
"Documents \ OpenMSX \ share \ shaders"

If there is no "shaders" folder in "Documents\OpenMSX\share\", create a "shaders" folder.

*[CAUTION] The "Documents" folder is a document folder for each Windows user. (My Documents in XP or earlier)*

*[CAUTION] If you overwrite "OpenMSX\share\shaders" under the OpenMSX installation folder instead of the document folder, it will be restored at the time of software update.*

## how to use:
When you're ready

1. Execute OpenMSX with Start from OpenMSX Catapult
2. Select "SDLGL-PP" for "Renderer" in the "Video Control" tab of OpenMSX Catapult.
3. In the "Video Control" tab of OpenMSX Catapult, select "TV" in Scaler: [Size] x [Filter].

*[CAUTION] Shader does not work on ”SDL" renderer.*

![screenshot of video control](./screenshot_video_control.png)
-----------------------------------------------

# 参考＆Special Thanks

http://hp.vector.co.jp/authors/VA030421/msx302.htm  
https://jp.mathworks.com/help/images/ref/rgb2ntsc.html  
http://p6ers.net/mm/pc-6001/dev/screen4color/  
http://fpgapark.com/ntsc/ntsc.htm  
https://github.com/libretro/glsl-shaders/blob/master/ntsc/ntsc.glslp 
// based on Themaister's NTSC shader



@echo off

set src=sjis
set dst=utf8
set filter="*.txt"

rem set SakuraPath=F:\SAKURAEDITOR\

@echo �h���b�v�����t�H���_�̃e�L�X�g�t�@�C����S��%src%����%dst%�ɕϊ�

set SakuraWin32Path=C:\Program Files (x86)\sakura\

if "%SakuraPath%"=="" set SakuraPath=%SakuraWin32Path%

set MacroPath=%~dp0%
set SakuraExe=%SakuraPath%sakura.exe
set MacroFile=%MacroPath%convert_%src%_to_%dst%.js

rem *****************************
if "%~1"=="" goto error
pushd "%~1"
call :convert_all
popd
goto :eof

rem *****************************
:convert_all
for /r %%f in (%filter%) do (
  call :convert "%%f"
)
pause
goto :eof

rem *****************************
:convert
echo "%1"
"%SakuraExe%" %1 -M="%MacroFile%"
goto :eof

rem *****************************
:error
echo �Ώۃt�H���_���h���b�v���Ă�������

choice /c yn /t 10 /d n /m "���݂̃t�H���_�̃t�@�C����S�ĕϊ����܂���"
if %errorlevel%==1 goto :convert_all

rem *****************************
:eof

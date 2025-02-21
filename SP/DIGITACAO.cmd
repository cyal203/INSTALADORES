@echo off
chcp 65001 >nul
title SP.1.0.0.1
call :VerPrevAdmin
if "%Admin%"=="ops" goto :eof
mode con: cols=50 lines=15
setlocal
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
Set Version=4

echo.
ren "C:\Program Files (x86)\Fenox V1.0" "Fenox V1.0.OLD"
cls
timeout /t 2 /nobreak >nul
echo Efetuando Download da versao 1.0.0.1...
curl -g -k -L -# -o "%temp%\1.0.0.1.zip" "https://www.dropbox.com/scl/fi/tkdbcsgdihazugpyft7ei/1.0.0.1.zip?rlkey=22girigvqgqu0e1y9akhcl82q&st=i63hturk&dl=1" >nul 2>&1
cls
REM ******************* EXTRAI NOVO SISOCR ****************
cls
timeout /t 2 /nobreak >nul
powershell -NoProfile Expand-Archive '%temp%\1.0.0.1.zip' -DestinationPath '%temp%\Fenox' >nul 2>&1 
REM ******************* INSTALANDO ****************
cls
timeout /t 2 /nobreak >nulf
%temp%\Fenox\Fnx_1.0.0.1_x64.exe /silent
timeout /t 2 /nobreak >nul

REM ******************* DELETA PASTAS ****************
rmdir /s /q "C:\Program Files (x86)\Fenox V1.0.OLD"  >nul
del /f "C:\Program Files (x86)\Fenox V1.0\notasAtualizacao.html"  >nul
timeout /t 2 /nobreak >nul
cls
timeout /t 2 /nobreak >nul
echo.
echo Fenox V1
wmic datafile where name="C:\\Program Files (x86)\\Fenox V1.0\\Fnx64bits.exe" get Version
REM ******************* CRIA ATALHOS ****************
rem powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Fenox V1.0.lnk')); $s.TargetPath = 'C:\Program Files (x86)\Fenox V1.0\SisFnxUpdate.exe'; $s.Save()"
rem powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Fenox V1.0 Mobile.lnk')); $s.TargetPath = 'C:\Program Files (x86)\Fenox V1.0\SisFnxUpdate.exe'; $s.Save()"
pause
exit

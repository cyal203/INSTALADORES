REM ******************* VERIFICA VERSAO ****************
REM 1.0.0.1
echo Verificando Versao...
echo.
echo %w%Fenox V1%b%
wmic datafile where name="C:\\Program Files (x86)\\Fenox V1.0\\Fnx64bits.exe" get Version || goto :INSTALAR >nul
REM Se a versão for reconhecida, o script continua normalmente

REM ******************* RENOMEANDO V1 ****************
pause
CLS
echo.
ren "C:\Program Files (x86)\Fenox V1.0" "Fenox V1.0.OLD"
cls
timeout /t 2 /nobreak >nul

:INSTALAR
REM ******************* BAIXA A NOVA VERSAO ****************
echo   ════════════════════════════════════
echo   ███ %W%BAIXANDO ARQUIVOS (1/4)%b%      ███
echo   ════════════════════════════════════ 
echo Efetuando Download da versao 1.0.0.1...
curl -g -k -L -# -o "%temp%\1.0.0.1.zip" "https://www.dropbox.com/scl/fi/tkdbcsgdihazugpyft7ei/1.0.0.1.zip?rlkey=22girigvqgqu0e1y9akhcl82q&st=i63hturk&dl=1" >nul 2>&1
cls

REM ******************* EXTRAI NOVO SISOCR ****************
cls
echo   ════════════════════════════════════
echo   ███   %W%EXTRAINDO ARQUIVOS (2/4)%b%  ███
echo   ════════════════════════════════════ 
timeout /t 2 /nobreak >nul
powershell -NoProfile Expand-Archive '%temp%\1.0.0.1.zip' -DestinationPath '%temp%\Fenox' >nul 2>&1 

REM ******************* INSTALANDO ****************
cls
echo   ════════════════════════════════════
echo   ███    %W%INSTALANDO . . . . (3/4)%b%  ███
echo   ════════════════════════════════════ 
timeout /t 2 /nobreak >nulf
%temp%\Fenox\Fnx_1.0.0.1_x64.exe /silent
timeout /t 2 /nobreak >nul

REM ******************* DELETA PASTAS ****************
rmdir /s /q "C:\Program Files (x86)\Fenox V1.0.OLD"  >nul
del /f "C:\Program Files (x86)\Fenox V1.0\notasAtualizacao.html"  >nul
timeout /t 2 /nobreak >nul
cls
echo   ════════════════════════════════════
echo   ███   %W%FINALIZADO . . . .    (4/4)%b%███
echo   ════════════════════════════════════ 
timeout /t 2 /nobreak >nul
echo.
echo %w%Fenox V1%b%
wmic datafile where name="C:\\Program Files (x86)\\Fenox V1.0\\Fnx64bits.exe" get Version || goto :INSTALAR >nul
REM ******************* CRIA ATALHOS ****************
rem powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Fenox V1.0.lnk')); $s.TargetPath = 'C:\Program Files (x86)\Fenox V1.0\SisFnxUpdate.exe'; $s.Save()"
rem powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Fenox V1.0 Mobile.lnk')); $s.TargetPath = 'C:\Program Files (x86)\Fenox V1.0\SisFnxUpdate.exe'; $s.Save()"
pause
exit
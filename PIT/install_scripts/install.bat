@echo off
for %%I in ("%~dp0..") do set PIT_DIR=%%~fI
pushd "%PIT_DIR%"
set /p InstallUser=Enter owner schema for PIT:

set "PWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%PWD%') do set PWD=%%a

set /p SID=Enter service name for the database or PDB:
set /p DefaultLanguage=Enter default language for messages (GERMAN or AMERICAN):
if /I "%DefaultLanguage%"=="GERMAN" goto language_ok
if /I "%DefaultLanguage%"=="AMERICAN" goto language_ok
echo Unsupported default language: %DefaultLanguage%. Expected GERMAN or AMERICAN.
goto error
:language_ok
set /p PitInstallMode=Enter install mode (I18N or MONOLINGUAL, default I18N):
if "%PitInstallMode%"=="" set PitInstallMode=I18N
if /I "%PitInstallMode%"=="I18N" goto mode_ok
if /I "%PitInstallMode%"=="MONOLINGUAL" goto mode_ok
echo Unsupported install mode: %PitInstallMode%. Expected I18N or MONOLINGUAL.
goto error
:mode_ok

set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/"%PWD%"@%SID%  @install_scripts/install.sql %DefaultLanguage% %PitInstallMode%

:end
popd
@echo off
exit /b 0

:error
popd
@echo off
exit /b 1

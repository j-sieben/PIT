@echo off
setlocal
for %%I in ("%~dp0..") do set PIT_DIR=%%~fI
pushd "%PIT_DIR%"
if errorlevel 1 exit /b 1
set "VersionFile=%TEMP%\pit-version-%RANDOM%-%RANDOM%.txt"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0version.ps1" -Mode Values > "%VersionFile%"
if errorlevel 1 (
  del "%VersionFile%"
  goto error
)
for /f "usebackq tokens=1,2 delims==" %%a in ("%VersionFile%") do set "%%a=%%b"
del "%VersionFile%"

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

set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/"%PWD%"@%SID%  @install_scripts/install.sql %DefaultLanguage% %PIT_VERSION% %PIT_GIT_COMMIT%
if errorlevel 1 goto error

:end
popd
@echo off
exit /b 0

:error
popd
@echo off
exit /b 1

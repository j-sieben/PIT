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
set /p Module=Enter module name to install:

set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/"%PWD%"@%SID% @install_scripts/install_module.sql %InstallUser% %DefaultLanguage% %Module%

popd

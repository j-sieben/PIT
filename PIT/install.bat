@echo off
set /p InstallUser=Enter owner schema for PIT:

set "PWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%PWD%') do set PWD=%%a

set /p SID=Enter service name for the database or PDB:
set /p DefaultLanguage=Enter default language for messages (GERMAN or AMERICAN):
set /p DefaulTablespace=Optionally enter default tablespace:

set nls_lang=GERMAN_GERMANY.AL32UTF8

echo Installing PIT at user %InstallUser% on %SID%, language %DefaultLanguage%. Continue?
pause

echo @install_scripts/install.sql %DefaultLanguage% %DefaultTablespace% | sqlplus %InstallUser%/%PWD%@%SID% 

@echo off
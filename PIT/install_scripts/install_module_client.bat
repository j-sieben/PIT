@echo off
for %%I in ("%~dp0..") do set PIT_DIR=%%~fI
pushd "%PIT_DIR%"
set /p InstallUser=Enter owner schema of PIT:

set "InstallPWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%InstallPWD%') do set InstallPWD=%%a

set /p SID=Enter service name for the database or PDB:
set /p RemoteUser=Enter client schema name:

set "RemotePWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %RemoteUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%RemotePWD%') do set RemotePWD=%%a

set /p Module=Enter module name to grant:

set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/"%InstallPWD%"@%SID% @install_scripts/grant_module_access.sql %InstallUser% %RemoteUser% %Module%

sqlplus %RemoteUser%/"%RemotePWD%"@%SID% @install_scripts/register_module_client.sql %InstallUser% %RemoteUser% %Module%

popd

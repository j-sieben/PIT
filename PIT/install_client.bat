@echo off
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

set nls_lang=GERMAN_GERMANY.AL32UTF8

echo @install_scripts/grant_client_access %RemoteUser% |sqlplus %InstallUser%/%InstallPWD%@%SID% 

echo @install_scripts/create_client_synonyms | sqlplus %RemoteUser%/%RemotePWD%@%SID%

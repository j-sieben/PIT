@echo off
set /p InstallUser=Enter owner schema of PIT:

set "InstallPWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%InstallPWD%') do set InstallPWD=%%a

set /p SID=Enter service name for the database or PDB:

set /p RemoteUser=Enter database user that is accessible by the APEX workspace:

set "AppPWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %RemoteUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%AppPWD%') do set AppPWD=%%a

set /p APEXWorkspace=Enter APEX workspace where this application should be installed at:
set /p AppAlias=Enter application alias for the PIT application:
set /p AppId=Enter application id for the PIT application:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/"%InstallPWD%@"%SID%  @install_scripts/grant_apex_access %InstallUser% %RemoteUser% 

sqlplus %RemoteUser%/"%AppPWD%"@%SID% @install_scripts/install_apex.sql %InstallUser% %RemoteUser% %APEXWorkspace% %AppAlias% %AppId%

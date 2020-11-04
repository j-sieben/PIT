@echo off
set /p Credentials= Enter ADMIN-credentials:
set /p InstallUser= Enter owner schema for PIT:
set /p RemoteUser= Enter user schema for PIT:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% @pit_install_client %InstallUser% %RemoteUser%

pause

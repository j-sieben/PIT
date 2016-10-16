@echo off
set /p Credentials = Enter SYS-credentials without 'as sysdba':
set /p InstallUser = Enter owner schema for PIT:
set /p RemoteUser = Enter user schema for PIT:
set /p DefLang = Enter default language (Oracle language name) for messages:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% as sysdba @pit_install.sql %InstallUser% %RemoteUser% %DefLang%

pause

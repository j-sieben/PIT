@echo off
set /p Credentials=Enter ADMIN-credentials:
set /p InstallUser=Enter owner schema for PIT:
set /p DefLang=Enter default language (Oracle language name) for messages:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% @pit_install.sql %InstallUser% %DefLang%

pause

@echo off
set /p Credentials=Enter SYS-credentials without 'as sysdba':
set /p InstallUser=Enter owner schema for PIT:
set /p DefLang=Enter default language (Oracle language name) for messages:
set /p APEXWorkspace=Enter APEX workspace where this application should be installed at:
set /p AppUser=Enter database user that is accessible by the APEX workspace:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% as sysdba @pit_install.sql %InstallUser% %AppUser% %DefLang% %APEXWorkspace%

pause

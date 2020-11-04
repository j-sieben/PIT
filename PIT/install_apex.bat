@echo off
set /p Credentials=Enter ADMIN-credentials:
set /p AppUser=Enter database user that is accessible by the APEX workspace:
set /p APEXWorkspace=Enter APEX workspace where this application should be installed at:
set /p AppAlias=Enter application alias for the PIT application:
set /p AppId=Enter application id for the PIT application:
set /p DefLang=Enter default language (Oracle language name) for messages:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% @pit_install_apex.sql %AppUser% %APEXWorkspace% %AppAlias% %AppId% %DefLang% 

pause

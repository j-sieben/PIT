@echo off
set /p Credentials= Geben Sie den Connect-String ohne 'as sysdba' fuer SYS ein:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% as sysdba @pit_uninstall DOAG DOAG

pause

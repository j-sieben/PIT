@echo off
set /p Credentials= Geben Sie den Connect-String ohne 'as sysdba' fuer SYS ein:
set /p InstallUser= Geben Sie den Namen des Eigentuemers von PIT ein:
set /p RemoteUser= Geben Sie den Namen des Benutzers von PIT ein:
set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %Credentials% as sysdba @pit_install %InstallUser% %RemoteUser%

pause

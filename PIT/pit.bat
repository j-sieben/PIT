@echo off
set COMMAND=%~1

if "%COMMAND%"=="" goto :usage
if /I "%COMMAND%"=="install" call "%~dp0install_scripts\install.bat" & goto :eof
if /I "%COMMAND%"=="install-client" call "%~dp0install_scripts\install_client.bat" & goto :eof
if /I "%COMMAND%"=="install-apex" call "%~dp0install_scripts\install_apex.bat" & goto :eof
if /I "%COMMAND%"=="install-module" call "%~dp0install_scripts\install_module.bat" & goto :eof
if /I "%COMMAND%"=="install-module-client" call "%~dp0install_scripts\install_module_client.bat" & goto :eof
if /I "%COMMAND%"=="uninstall" call "%~dp0install_scripts\uninstall.bat" & goto :eof
if /I "%COMMAND%"=="uninstall-client" call "%~dp0install_scripts\uninstall_client.bat" & goto :eof
if /I "%COMMAND%"=="uninstall-module" call "%~dp0install_scripts\uninstall_module.bat" & goto :eof
if /I "%COMMAND%"=="uninstall-module-client" call "%~dp0install_scripts\uninstall_module_client.bat" & goto :eof
if /I "%COMMAND%"=="help" goto :usage
if /I "%COMMAND%"=="-h" goto :usage
if /I "%COMMAND%"=="--help" goto :usage

echo Unknown command: %COMMAND%
goto :usage

:usage
echo Usage:
echo   pit.bat ^<command^>
echo.
echo Commands:
echo   install
echo   install-client
echo   install-apex
echo   install-module
echo   install-module-client
echo   uninstall
echo   uninstall-client
echo   uninstall-module
echo   uninstall-module-client
echo   help
exit /b 1

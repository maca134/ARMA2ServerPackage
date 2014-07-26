@echo off
call prestart.bat
start "arma2" /D "%ARMA2%" /min /realtime /wait "%ARMASERVEREXE%.exe" %PARAMS%
echo Server Stopped
pause
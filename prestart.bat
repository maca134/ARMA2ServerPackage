
echo Loading config
call config.bat

echo Compressing and cleaning logs
%ZIP% a -tzip "%DIR%\logs\log%backuptime%.zip" "%DIR%\run\instance\%ARMASERVEREXE%.RPT" "%DIR%\run\instance\server_console.log" "%DIR%\run\instance\HiveExt.log" "%DIR%\run\instance\BattlEye\*.log" "%DIR%\run\bec\Log\Epoch"
del "%DIR%\run\instance\%ARMASERVEREXE%.RPT"
del "%DIR%\run\instance\server_console.log"
del "%DIR%\run\instance\HiveExt.log"
del "%DIR%\run\instance\BattlEye\*.log"
rd /S /Q "%DIR%\run\bec\Log\Epoch"

echo Creating server exe
del %ARMA2%\%ARMASERVEREXE%.exe
copy %ARMA2%\arma2oaserver.exe %ARMA2%\%ARMASERVEREXE%.exe

if NOT %CLEANUPUSER% == "" (
	%MYSQL% --host=%HIVEHOST% --port=%HIVEPORT% --user=%CLEANUPUSER% --password=%CLEANUPPASS% --database=%HIVEDB% < "%DIR%\sql\prestart.sql"
)

echo Pulling and updating mission
rd /S /Q "%DIR%\dump\mission"
mkdir "%DIR%\dump\mission"
xcopy "%DIR%\source\mission\*"  "%DIR%\dump\mission\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
%PBOMANAGER% -pack "%DIR%\dump\mission" "%MPMISSION%\%MISSIONNAME%.pbo"

echo Pulling and updating server
cd %DIR%\source\server
rd /S /Q "%DIR%\dump\server"
mkdir "%DIR%\dump\server"
xcopy "%DIR%\source\server\*"  "%DIR%\dump\server\" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt
%PBOMANAGER% -pack "%DIR%\dump\server" "%DIR%\run\@server\addons\dayz_server.pbo"

echo Copying BEC configs
xcopy %DIR%\bec_config\* %DIR%\run\bec\Config /E /Y

echo Preparing BEC config
%SAR% --cl --dir "%DIR%\run\bec\Config" --fileMask "Config.cfg" --find "!PORT" --replace "%PORT%"
%SAR% --cl --dir "%DIR%\run\bec\Config" --fileMask "Config.cfg" --find "!DIR" --replace "%DIR%"
%SAR% --cl --dir "%DIR%\run\bec\Config" --fileMask "Config.cfg" --find "!ARMASERVEREXE" --replace "%ARMASERVEREXE%.exe"
%SAR% --cl --dir "%DIR%\run\bec\Config" --fileMask "Config.cfg" --find "!BECNAME" --replace "%BECNAME%"

echo Preparing Server Config

cd %DIR%\server_config\BattlEye
xcopy "%DIR%\server_config\*" "%DIR%\run\instance" /E /Y /EXCLUDE:%DIR%\bin\exclude.txt /Q

%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!SERVERNAME" --replace "%SERVERNAME%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!SERVERPASSWORD" --replace "%SERVERPASSWORD%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!MISSIONNAME" --replace "%MISSIONNAME%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!MAXPLAYERS" --replace "%MAXPLAYERS%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!STEAMPORT" --replace "%STEAMPORT%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "config.cfg" --find "!STEAMQUERYPORT" --replace "%STEAMQUERYPORT%"

%SAR% --cl --dir "%DIR%\run\instance" --fileMask "HiveExt.ini" --find "!HIVEHOST" --replace "%HIVEHOST%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "HiveExt.ini" --find "!HIVEPORT" --replace "%HIVEPORT%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "HiveExt.ini" --find "!HIVEUSER" --replace "%HIVEUSER%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "HiveExt.ini" --find "!HIVEPASS" --replace "%HIVEPASS%"
%SAR% --cl --dir "%DIR%\run\instance" --fileMask "HiveExt.ini" --find "!HIVEDB" --replace "%HIVEDB%"

%SAR% --cl --dir "%DIR%\run\instance\BattlEye" --fileMask "BEServer.cfg" --find "!RCONPASSWORD" --replace "%RCONPASSWORD%"
%SAR% --cl --dir "%DIR%\run\instance\BattlEye" --fileMask "BEServer.cfg" --find "!MAXPING" --replace "%MAXPING%"

start "bec" /D "%DIR%\run\bec" "%DIR%\run\bec\Bec.exe" -f "Config.cfg"

set PARAMS=-port=%PORT% "-config=%DIR%\run\instance\config.cfg" "-profiles=%DIR%\run\instance" -name=instance "-mod=Expansion;%MOD%;%DIR%\run\@server;@hive;" -cpuCount=2 -exThreads=0

echo =============================================
echo Exe: %ARMA2%\%ARMASERVEREXE%.exe
echo ---------------------------------------------
echo Params: %PARAMS%
echo =============================================
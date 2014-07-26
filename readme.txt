Maca's ARMA2 Server Package
===========================
A collection of batch files to make deploying new ARMA 2 servers easier.

Requirements:
PBO Manager : http://www.armaholic.com/page.php?id=16369

ARMA 2 OA 1.63 (Steam)
ARMA 2 (Steam)
	With this, all you need to do is download ARMA2 once and copy the addons folder to ARMA2 Operation Arrowhead!

To get going with installing ARMA2OA (Steam) I suggest reading this: http://www.404games.co.uk/forum/index.php?/tutorials/article/3-how-to-setup-an-arma2-combined-ops-server-using-steamcmd/

---------------------------------------------------------------------------------------------------------
Files
-----
config.bat
Contains the primary config for the package.

prestart.bat
Runs everything except ARMA2OA server, for firedeamon and other service stuff.

start.bat
Runs everything, prestart then runs arma 2 oa server

Folders
-------
\bec_config
Contains scheduler.xml and admins.xml which you will need to edit as your requirements.

\bin
Contains some essential exe's

\dump
Copies files to as part of the prestart process

\logs
Each restart, previous logs get archived

\run
Contains the "live" files

\server_config
Contains the primary server cfg files, inc BE filters

\source
This is were your server and mission files go, you CAN EDIT these when the server is running

\sql
Contains the prestart.sql cleanup script

Variables
---------
BECNAME
A name for the server (SuperEpochServer)

MISSIONNAME
The mission name (Eg. epoch.chernarus)

PORT
The game port

ARMASERVEREXE
The name of the arma2oaserver exe (This is created each restart, may need firewall exceptions)
IMPORTANT: DO NOT CALL THIS "Arma2OAServer", IF WILL DELETE THE ORIGINAL EXE!

SERVERNAME
The public name of the server (Steam has a max char limit!)

SERVERPASSWORD
Server password, leave blank for none

SERVERADMINPASSWORD
Server admin password

RCONPASSWORD
Server RCON password

MAXPING
Server Max Ping

MOD
Server mods (Eg. G:\mods\@DayZOverwatch;G:\mods\@DayZ_Epoch105)

MAXPLAYERS
Server Max Players

STEAMPORT
STEAMQUERYPORT
Steam query ports

HIVEHOST
The host name for the database

HIVEPORT
Database port (Normally 3306)

HIVEDB
Database name

HIVEUSER
Database username (lower permissions (SELECT, INSERT, UPDATE, DELETE))

HIVEPASS
Database password for the lower permission user

CLEANUPUSER
A user with higher permissions to allow an SQL file to run before the server starts (Leave blank to skip)

CLEANUPPASS
Password for the cleanup user

ARMA2
Path to arma 2 OA

MPMISSION
mpmission name, generally "mpmission"

PBOMANAGER
Path to pbo manager

DIR
Current directory (ignore)

SAR
Path to Search and replace exe (ignore)

MYSQL
Path to Mysql exe (ignore)

ZIP
Path to zip (ignore)

backuptime
Backup filename (ignore)


Note:
If you remove any of the !VAR text within configs files, it might break. 

ALWAYS KEEP BACKUPS OF EVERYTHING!

Credit:
MySQL: http://www.mysql.com/
7zip: http://www.7-zip.org/
fnr.exe: http://findandreplace.codeplex.com/
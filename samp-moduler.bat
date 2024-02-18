@echo off

::# SAMP-MODULER
::- A quickly way to create a set of new moduled files and folders for SA-MP systems with a more used standard system.
::- Useful for converting monolitic gamemodes scripts in moduled gamemodes scripts.
::- This won't moduled your code, you have to module manually after using this generated template.
::
::## Installation: 
::1. save the samp-moduler.bat in a folder like c:/samp-moduler.
::2. set the samp-moduler.bat in the windows variable path (user path or system path, you prefer).
::2. Open the command prompt and go the core folder of you gamemode (it's recommended having 2 folders in gamemodes folder, utils and core, core is where you place your moduled codes and utils folder is for general data and functions used around the gamemode like colors and maths).
::3. execute the command samp-moduler:
::```batch
::c:\Users\user>samp-moduler
::```
::
::## Quick-start:
::If you don't want to install it manually just move the samp-moduler.bat to the core folder and execute it.
::
::## Features: 
::### 1. Generate system moduled folder and files (self explained)
::This will generate these files 
::- **header.inc**  (for constants and variables, defines, enums, new, const, etc)
::- **funcs.inc** (functions and public functions)
::- **impl.inc** (for callbacks/events, implementations)
::- **entry.inc** (file which index the whole module)
::
::For example, entry generated file will looks like this:
::```c
:://farmer_entry.inc
::#if defined farmer_included 
::    #endinput
::#endif
::#define farmer_included
::
::#include "core/gamemodes/jobs/farmer/farmer_header.inc"
:://if commands folder is required:
::#include "core/gamemodes/jobs/farmer/farmer_commands.inc"
::#include "core/gamemodes/jobs/farmer/farmer_funcs.inc"
::#include "core/gamemodes/jobs/farmer/farmer_impl.inc"
::```
::### 2. Generate commands entry file 	
::Index all the current commands files from the commands folder in a entry file and then used by main entry module file. For example, entry commands generated file will looks like this:
::```c
:://farmer_cmds_entry.inc
::#if defined farmer_cmds_included 
::   #endinput 
::#endif 
::#define farmer_cmds_included 
:: 
::#include "gamemodes/core/farmer/commands/work.inc" 	
::#include "gamemodes/core/farmer/commands/take.inc" 	
::#include "gamemodes/core/farmer/commands/destroy.inc" 	
::#include "gamemodes/core/farmer/commands/anything.inc" 	
::
:://if you have a jobs folder you'll have to type manually
::#include "gamemodes/core/jobs/farmer/commands/anything.inc" 	
::```
::- You must have to create a commands folder if you didn't before to use this feature in the created module folder (farmer for example) and execute this feature in the commands folder.
::- Note for beginners: Commands files are where you will code the cmd:command(playerid, params[]), one command or a group or commands as you prefer.
::
::### Expected moduled system folders: 
:: ```c
:: -core
:: --- farmer // a module folder
:: --- --- farmer_header.inc 
:: --- --- farmer_funcs.inc 
:: --- --- farmer_impl.inc 
:: --- --- farmer_entry.inc
:: --- --- commands/ 
:: --- --- --- --- inv.inc // command file, prefixes are no required, it's a unique file, self explained
:: --- --- --- --- take.inc // other command
:: --- --- --- --- farmer_cmds_entry.inc //entry file for commands 
::```
::main.pwn:
::```c
::#include "core/farmer/farmer_entry.inc" 
:: // OR
::#include "core/jobs/farmer/farmer_entry.inc" 
::```
::### Expected static/important-scripts files/folders and the whole core folder: 
:: ```c
:: -core
:: --- _Player // fundamental/base codes, underscore in the beginning for the important and place the folde to the top of directory explorer
:: --- --- Player_entry.inc //the beginning underscore is unnecessary here 
:: --- --- PlayerTemp.inc  // variable used for connect all modules and systems 
:: --- --- PlayerCharacter.inc 
:: --- --- PlayerObject.inc 
:: --- --- PlayerWeapon.inc
:: --- _Database // not a commands folder here of course, only connection maybe, do it as you prefer
:: --- --- Database_header.inc 
:: --- --- Database_funcs.inc 
:: --- --- Database_impl.inc 
::// login_logout, I dunno, still thinking it, just group all the code that change for one reason and separe the code if not.
:: --- _login 
:: --- --- farmer // a module
::```
::Note: There's not a PlayerData, this variable is too general! (PLAYER_TEMP is a little bit but is better) it's only used for code tutorials 
::
::## FAQ:
::you should have some questions about the files names, alright let's see.
::
::- ### Why these way?
::Convention over configuration, this means you have to structure your system setting all with commons names and prefixes to improve your speed of reading files with your muscle memory.
::
::Let's see a example: files have MODULE_NAME with WHAT_I_AM name, "I from this module and I have these types of data" i.e taxi_driver_entry.inc, alright, maybe you thought why the MODULE_NAME when the files are in the module folder with his module name, that's right but what about having a lot of files and the sidebar get you scrolling all the times looking for the folder file that you have opened in front of you?
::
::think how fast is search a file just using the search file feature of your editor code with the file name "keyword" what about having the module name with the type of data of the file in the top of your code menu/bar editor? 
::
::That's it, if you was paying attention this system looks like YSI folder system, nothing to re-invent.
::
::- ### Why the undescore in the beginning of names?
::Easy way to place visually on top in the sidebar code editor and file explorer.
::
::- ### Why a batch file?
::This was made in Batch as a scratch and then as a Beta but maybe in the future I will code a program with more features.
::
:: I'd like if I you make feedback and bug reports.
SET WORKSPACE_ROOT=core
::------------------------------------------------
:menu
echo ////////////////////////////////////////
echo ///                                  ///
echo ///     SAMP-MODULER Tool Beta 1.0   ///
echo ///        by @neeteek 2024          ///
echo ///                                  ///
echo ///  SA-MP moduled system generator  ///
echo ///                                  ///
echo ////////////////////////////////////////

ECHO =============================================================
ECHO = 1. Generate system moduled folder                        == 
ECHO = 2. Generate command entry file                           ==
ECHO = 3. Exit                                                  ==
ECHO =============================================================
ECHO. 

SET /P option=Choose a option:
IF %option%==1 ( goto Modular )
IF %option%==2 ( goto commands_entry )
IF %option%==3 ( exit ) ELSE ( goto Error )

::------------------------------------------------

::------------------------------------------------
:Modular
cls
SET /P module_name=type the name of the submodule:
MKDIR %module_name% 
cd %module_name%
echo //%module_name% headers > %module_name%_header.inc
echo //%module_name% functions > %module_name%_funcs.inc
echo //%module_name% implementations (callbacks) > %module_name%_impl.inc

echo #if defined %module_name%_included >>	%module_name%_entry.inc
echo    #endinput >>						%module_name%_entry.inc
echo #endif >>								%module_name%_entry.inc
echo #define %module_name%_included >>		%module_name%_entry.inc
echo. >>									%module_name%_entry.inc

echo #include "%WORKSPACE_ROOT%/%module_name%/%module_name%_header.inc" >> %module_name%_entry.inc

SET /P input= will you use commands in this system/module? (y/n):
IF %input%==y (goto Commands) 
IF %input%==Y (goto Commands) 
IF %input%==N (goto Modular2) 
IF %input%==n (goto Modular2) ELSE (goto Error)
::------------------------------------------------

::------------------------------------------------
:Commands

echo #include "%WORKSPACE_ROOT%/%module_name%/commands/%module_name%_cmds_entry.inc" >> %module_name%_entry.inc
MKDIR commands
cd commands
echo //use samp-moduler and use the second option to generate all exiting commands files in the commands folder >> _%module_name%_cmds_entry.inc
cd ..
goto Modular2
::------------------------------------------------

:Modular2
echo //uncomment if you will use commands >> %module_name%_entry.inc  
echo //#include "%WORKSPACE_ROOT%/%module_name%/commands/_%module_name%_cmds_entry.inc" >> %module_name%_entry.inc 
echo #include "%WORKSPACE_ROOT%/%module_name%/%module_name%_funcs.inc" >> %module_name%_entry.inc
echo #include "%WORKSPACE_ROOT%/%module_name%/%module_name%_impl.inc" >> %module_name%_entry.inc
goto finished
::------------------------------------------------


::------------------------------------------------
:commands_entry
for %%F in ("%CD%") do SET commands_folder=%%~nxF
cd ..
for %%F in ("%CD%") do SET module_folder=%%~nxF
cd %commands_folder% 

echo. >												_%module_folder%_cmds_entry.inc
echo #if defined %module_folder%_cmds_included >>	_%module_folder%_cmds_entry.inc
echo    #endinput >>								_%module_folder%_cmds_entry.inc
echo #endif >>										_%module_folder%_cmds_entry.inc
echo #define %module_folder%_cmds_included >>		_%module_folder%_cmds_entry.inc
echo. >>											_%module_folder%_cmds_entry.inc
for %%i in (*.inc) do (
	IF NOT %%i==_%module_folder%_cmds_entry.inc (
		echo #include "%WORKSPACE_ROOT%/%module_folder%/%commands_folder%/%%i" >> _%module_folder%_cmds_entry.inc	
	)
)
goto finished
::------------------------------------------------

::------------------------------------------------
:finished
cls
ECHO.
ECHO   ############ DONE ################
ECHO.
pause
goto menu
::------------------------------------------------

::------------------------------------------------
:Error
cls
ECHO   ############ ERROR BAD OPTION ################
ECHO.
pause
goto menu
::------------------------------------------------

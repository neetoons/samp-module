@echo off

SET WORKSPACE_ROOT=core
::------------------------------------------------
:menu
echo ////////////////////////////////////////
echo ///                                  ///
echo ///     SAMP-MODULE Tool Beta 1.0    ///
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
echo //use samp-module and use the second option to generate all exiting commands files in the commands folder >> _%module_name%_cmds_entry.inc
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

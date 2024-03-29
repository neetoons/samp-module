## SAMP-module
- A quick way to create a set of new moduled files and folders for SA-MP systems with a more used standard system.
- Useful for converting monolithic gamemodes scripts in moduled gamemodes scripts.
- This won't moduled your code, you have to module manually after using this generated template.

_❗Disclaimer: As an admin, I have to verify all codes and programs you download from Discord before executing._

## Installation: 
1. save the samp-module.bat in a folder like c:/samp-module.
2. set the samp-module.bat in the Windows variable path (user path or system path, you prefer).
2. Open the command prompt and go to the core folder of your gamemode (it's recommended to have 2 folders in gamemodes folder, utils, and core, the core is where you place your moduled codes, and the utils folder is for general data and functions used around the gamemode like colors and maths).
3. execute the command samp-module:
```batch
c:\Users\user>samp-module
```

## Quick-start:
If you don't want to install it manually, move the samp-module.bat to the core folder and execute it.

## Features: 
### 1. Generate system-moduled folders and files (self-explained)
This will generate these files 
- **header.inc**  (for constants and variables, defines, enums, new, const, etc)
- **funcs.inc** (functions and public functions)
- **impl.inc** (for callbacks/events, implementations)
- **entry.inc** (file that indexes the whole module)

For example, entry generated file will look like this:
```c
//farmer_entry.inc
#if defined farmer_included 
    #endinput
#endif
#define farmer_included

#include "core/gamemodes/jobs/farmer/farmer_header.inc"
//if commands folder is required:
#include "core/gamemodes/jobs/farmer/farmer_commands.inc"
#include "core/gamemodes/jobs/farmer/farmer_funcs.inc"
#include "core/gamemodes/jobs/farmer/farmer_impl.inc"
```
### 2. Generate commands entry file 	
Index all the current commands files from the commands folder in an entry file and then use by main entry module file. For example, the entry commands generated file will look like this:
```c
//farmer_cmds_entry.inc
#if defined farmer_cmds_included 
   #endinput 
#endif 
#define farmer_cmds_included 
 
#include "gamemodes/core/farmer/commands/work.inc" 	
#include "gamemodes/core/farmer/commands/take.inc" 	
#include "gamemodes/core/farmer/commands/destroy.inc" 	
#include "gamemodes/core/farmer/commands/anything.inc" 	

//if you have a jobs folder you'll have to type manually
#include "gamemodes/core/jobs/farmer/commands/anything.inc" 	
```
- You must create a commands folder if you didn't before, use this feature in the created module folder (farmer for example), and execute this feature in the commands folder.
- Note for beginners: Commands files are where you will code the cmd:command(playerid, params[]), one command or a group or commands as you prefer.

### Expected moduled system folders: 
 ```c
 -core
 --- farmer // a module folder
 --- --- farmer_header.inc 
 --- --- farmer_funcs.inc 
 --- --- farmer_impl.inc 
 --- --- farmer_entry.inc
 --- --- commands/ 
 --- --- --- --- inv.inc // command file, prefixes are no required, it's a unique file, self explained
 --- --- --- --- take.inc // other command
 --- --- --- --- farmer_cmds_entry.inc //entry file for commands 
```
main.pwn:
```c
#include "core/farmer/farmer_entry.inc" 
 // OR
#include "core/jobs/farmer/farmer_entry.inc" 
```
### Expected static/important-scripts files/folders and the whole core folder: 
 ```c
 -core
 --- _Player // fundamental/base codes, underscore in the beginning for the important and place the folder to the top of the directory explorer
 --- --- Player_entry.inc //the beginning underscore is unnecessary here 
 --- --- PlayerTemp.inc  // variable used to connect all modules and systems 
 --- --- PlayerCharacter.inc 
 --- --- PlayerObject.inc 
 --- --- PlayerWeapon.inc
 --- _Database // not a commands folder here, of course, the only connection may be, do it as you prefer
 --- --- Database_header.inc 
 --- --- Database_funcs.inc 
 --- --- Database_impl.inc 
// login_logout, I don't know, still thinking about it, just group all the code that changes for one reason and separate the code if not.
 --- _login 
 --- --- farmer // a module
```
Note: There's not a PlayerData, this variable is too general! (PLAYER_TEMP is a little bit but is better) it's only used for code tutorials 

## FAQ:
you should have some questions about the file names, alright let's see.

- ### Why this way?
Convention over configuration, means you have to structure your system settings all with common names and prefixes to improve your speed of reading files with your muscle memory.

Let's see an example: files have MODULE_NAME with WHAT_I_AM name, "I from this module and I have these types of data" i.e. taxi_driver_entry.inc, alright, maybe you thought why the MODULE_NAME when the files are in the module folder with his module name, that's right but what about having a lot of files and the sidebar gets you scrolling all the time looking for the folder file that you have opened in front of you?

think how fast is to search a file just using the search file feature of your editor code with the file name "keyword" What about having the module name with the type of data of the file in the top of your code menu/bar editor? 

That's it, if you were paying attention this system looks like [YSI](https://github.com/pawn-lang/YSI-Includes) folder system, with nothing to re-invent.

- ### Why the underscore at the beginning of names?
Easy way to place visually on top in the sidebar code editor and file explorer.

- ### Why .inc file extension?
Why .inc instead of .pwn in included file names? .inc is used to describe this file depending on a main file to work as all included should work, the only exception could be this file is made independent for testing (unit testing, actually a good way, maybe I recommend in the future) including #include <a_samp> even being an include file. .inc Files are files that will be included in the main program file, that's it. It's common to use .pwn in the whole gamemode because the community sometimes doesn't know how to set the syntax language in their code editor, this is fixed using the open.mp extensions (vscode in this case).
- ### Why a batch file?
This was made in Batch as a scratch and then as a Beta but maybe in the future, I will code a program with more features.

 I'd like it if you make feedback and bug reports.

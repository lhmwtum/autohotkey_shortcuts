# AutoHotkey - Shortcuts
This repository provides AutoHotkey (AHK) scripts for setting up a variety of shortcuts on your Windows computer. All scripts can be easily extended the way you need it.
You do not have to know much about AHK to customize the features of these scripts to your needs.

What you get:
* shortcuts to files, folders, websites and tools/ applications
* disable capslock and, finally, make it useful
* shortcuts for words/ phrases you often use, e.g., in emails
* shortcuts to quickly google or translate words/ phrases in your browser

**Important:** All ``.ahk`` text files need to be saved with **UTF8-BOM** encoding rather than UTF8 if you want to use hotstrings with special characters, e.g., German ä, ö, ü.

## List of Components
* ``scripts``: this folder contains all scripts which provide different functionality. All scripts are started via ``mainscript.ahk``.
* ``mainscript.ahk``: this file starts and manages all scripts within the ``scripts`` folder. It provides an easy way to start your AHK functionality at Windows start up.

## Getting Started
These instructions will get you through the process of installing AutoHotkey on your computer and setting everything up so you can run your customized AHK scripts.

All necessary steps are mentioned here. For further information, take a look at the quick-start tutorial which can be found on the [official website](https://www.autohotkey.com/docs/Tutorial.htm).

### Install AutoHotkey on your computer
The following steps briefly describe how to install AutoHotkey on your Windows computer:
* Navigate to the AutoHotkey website: https://www.autohotkey.com
* Click on "Download", then "Download Current Version" to get the latest AHK ``.exe`` file
* Run the downloaded executable to install AHK
* After completing the installation process, you're ready to go!

### Start and manage your scripts
In general, you can start every script separately, e.g., if you only want to use the hotstrings and nothing else.
If AutoHotkey is installed, double-clicking on the file will run it.
If you would like to use all scripts, then simply run the ``mainscript.ahk`` by double-clicking it.

When an AHK script is active, you should see a green "H" tray icon that appears in the system tray to indicate a script is running (located in the bottom-right corner of your Windows desktop, next to date and time).
By right-clicking the tray icon, you can pause/ exit the active AHK script, e.g., in case of any interference with already existing shortcuts within a particular software tool.

Every time you shut down your computer, you will have to restart the AutoHotkey scripts.

If you like to have your AHK functionality available immediately after the Windows start process, there is an easy way to automatically start AHK scripts every time you start your computer:

### Run the main script when starting your computer
This will make all your shortcuts available immediately after starting your computer.
The following instruction can also be found [here](http://www.thenickmay.com/articles/how-to-install-autohotkey-without-admin/).

* Open the folder where you put the AutoHotkey scripts, right-click on ``mainscript.ahk`` (or the AHK script you want to run at Windows start) and select "Create shortcut".
* Press the Windows key and the "r" key together.
* In the "Run" window that pops up, type in:
```
shell:startup
```
* Press Enter. This should open your startup folder.
* Drag the AutoHotkey shortcut you created in the first step to the startup folder.

That's it!
Restart your computer and make sure AutoHotkey is running (the green "H" in the system tray should appear and your shortcuts should work).

## Customize your scripts
To figure out how to implement your own shortcuts, take a look at the files within the ``scripts`` folder. Every file's heading section provides a short description on how to customize the particular script to your needs.
After saving your changes, restart ``mainscript.ahk`` (or the currently active script) to enable the modifications.

## Contributing
Contributions are very welcome! Feel free to add any new functionality or improvement.

**Note:** Please make sure that your script does no interfere with any existing functionality and is independent of any other script. Therefore, it should be completely controllable via the ``mainscript.ahk`` (to activate/ deactivate).

# AutoHotkey - Shortcuts
This repository provides AutoHotkey (AHK) scripts which can be easily extended the way you need it.
You do not have to know much about AHK to customize the features of these scripts to your needs.

What you get:
* shortcuts to files, folders, websites and tools/ software programs
* disable capslock and, finally, make it useful
* shortcuts for common words/ phrases you often use, e.g., in emails
* shortcuts to quickly google or translate things in your browser

## List of Components
* scripts: this folder contains all the scripts providing different functionality. All scripts are started via ``mainscript.ahk``.
* mainscript.ahk: this file starts and manages all scripts within the ``scripts`` folder. It provides an easy way to start your AHK functionality at Windows start up.

## Getting started
These instructions will get you through the process of installing AutoHotkey on your computer and setting everything up so you can run your AHK scripts.

A quick start tutorial can be found [here](https://www.autohotkey.com/docs/Tutorial.htm).

### Install AutoHotkey on your computer
The following steps describe briefly how to install AutoHotkey on your Windows computer:
* Navigate to the AutoHotkey website: https://www.autohotkey.com
* Click on "Download", then "Download Current Version" to get the latest AHK ``.exe`` file
* Run the downloaded executable to install AHK
* After completing the installation process, you're ready to go!

### Set up your own AutoHotkey scripts
In general, you can start every script separately, e.g., if you only would like to use the hotstrings and nothing else.
If AutoHotkey is installed, double-clicking on the file will run it.
If you would like to use all scripts, then simply run the ``mainscript.exe`` by double-clicking it.

When an AHK script is active, you should see a green "H" tray icon that appears in the system tray to indicate a script is running (located in the bottom-right corner of your windows desktop, next to date and time).
By right-clicking the tray icon, you can pause/ exit the active AHK script, e.g., in case of any interference with already existing shortcuts within a particular software tool.

Every time you shut down your computer, you will have to start the AutoHotkey scripts again.

If you would like to have your AHK functionality immediately after windows start, there is an easy way to automatically run AHK scripts every time you start your computer:

### Run the main script when starting your computer
This will make all your shortcuts available immediately after starting your computer.
The following instruction can be found [here](http://www.thenickmay.com/articles/how-to-install-autohotkey-without-admin/).

* Open the folder wherever you put the AutoHotkey script, right-click on the AutoHotkey file and select "Create shortcut".
* Press the Windows key and "r" together.
* In the "Run" window that pops up, type in:
```
shell:startup
```
Press Enter. This should open your startup folder.
* Drag the AutoHotkey shortcut you created in the first step to the startup folder.

That's it!
Restart your computer and make sure AutoHotkey is running after restart (e.g. green "H" in the system tray should appear or try some shortcuts).

## Contributing
Contributions are very welcome! Feel free to add any new functionality or improvement.

**Note:** Please make sure that your script does no interfere with any existing functionality and is independent of any other script. Therefore, it should be completely controllable via the ``mainscript.ahk`` (activate/ deactivate).

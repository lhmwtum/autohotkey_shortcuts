; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019

/*
Documentation
This script manages all types of shortcuts which are triggered by capslock and
a subsequent key combination.
The shortcuts within this script link to websites, tools, folders and files.
All shortcuts are defined via the \Config\wtf_shortcuts.ini file.

How to

Hold down the capslock key to reach "shortcut mode" (a pink bar at the left
side of your screen appears). Then, you have three options on how to
continue: press "w" to make your website shortcuts available, "t" for your
tool shortcuts and "f" for your folder and file shortcuts. If you press one of
this keys while holding capslock down, you are now within the specific
shortcut menu (the pink bar at the left side changes to cyan).
Now you can finally run a shortcut by pressing a predefined key (after
pressing this third key, you can release all three keys).

Shortcuts are defined within the \Config\wtf_shortcuts.ini file using the
standard .ini-file format.

Summary:
* Press capslock and hold down
* Press "w", "t" or "f" and also hold down
* Press a shortcut key to trigger a shortcut (now release all three keys)

Example:
capslock + "w" + "g" will open "www.google.com" in your default browser

Once you understand how this script works, feel free to customize it your way
and fill it with our own shortcuts!
*/

;--- Settings ------------------------------------------------------------------

#NoEnv

;--- Load shortcut definitions -------------------------------------------------

shortcut_categories := ["WEBSITES", "TOOLS", "FOLDERS"]

Array := Array()

; Loop through each shortcut category and get all shortcut definitions
Loop % shortcut_categories.Length() {

    ; read a section of the .ini file which contains shortcuts and targets
    IniRead, OutputVarSection, %A_ScriptDir%\Config\wtf_shortcuts.ini, % shortcut_categories[A_Index]

    idx_outerloop := A_Index

    ; loop through each line of a specific section's string
    Loop, parse, OutputVarSection, `n, `r
    {
        ; get character before equal sign
        char_shortcut := SubStr(A_LoopField,1,1)

        ; get string after equal sign to end of line, trim quotation marks
        string_target := Trim(SubStr(A_LoopField,3), Chr(34))

        ; save shortcut char and target to array
        Array[idx_outerloop, (char_shortcut)] := string_target
    }
}

;--- Activate Caps Lock --------------------------------------------------------

Sleep 500
switch_to_InsertMode()
DetectHiddenWindows, On

; avoid bad state of capslock (pressed when not down)
SetCapsLockState, AlwaysOff
GetKeyState, state, CapsLock
if state = D
{
    Suspend On
    SetCapsLockState, off
    SendInput, {CapsLock Up}
    Suspend Off
}

return


;-------------------------------------------------------------------------------
;--- Shortcut execution --------------------------------------------------------
;-------------------------------------------------------------------------------

;--- Shortcuts to files and folders --------------------------------------------
~CapsLock & f::
{
    ; get user input
    in := get_userinput()

    ;--- path definitions -----
    if(StrLen(Array[3][in])>2){
        load(Array[3][in])
        return
    }

    ; switch back when no action is triggered -----
    switchBackRoutine()

    return
}

;--- Shortcuts to websites -----------------------------------------------------
~CapsLock & w::
{
    ; get user input
    in := get_userinput()

    ;--- URL definitions -----
    if(StrLen(Array[1][in])>2){
        load(Array[1][in])
        return
    }

    ; switch back when no action is triggered -----
    switchBackRoutine()

    return
}

;--- Shortcuts to software tools -----------------------------------------------
~CapsLock & t::
{
    ; get user input
    in := get_userinput()

    ;--- exe-file definitions -----
    if(StrLen(Array[2][in])>2){
        load(Array[2][in])
        return
    }

    ; switch back when no action is triggered -----
    switchBackRoutine()

    return
}

;--- Shortcuts to paste paths --------------------------------------------------
; these shortcuts allow you to quickly paste a path which is defined in the
; "FOLDERS" section, e.g. when you need a path to a certain folder during the
; Windows save dialog.
~CapsLock & p::
{
    ; get user input
    in := get_userinput()

    ;--- exe-file definitions -----
    if(StrLen(Array[3][in])>2){
        Suspend Off
        switch_to_InsertMode()
        SendInput, % Array[3][in]
        return
    }

    ; switch back when no action is triggered -----
    switchBackRoutine()

    return
}

;-------------------------------------------------------------------------------
;--- Helper functions ----------------------------------------------------------
;-------------------------------------------------------------------------------

;--- Load function -------------------------------------------------------------
; this function loads files, folders, websites and applications
load(what){
    Suspend Off
    switch_to_InsertMode()
    Run %what%
    return
}

;--- User input function -------------------------------------------------------
; this function receives the user input after pressing a category key (w, t, f)

get_userinput(){
    Splashimage,,b w5  h500  CW00FFFF00 m9  fs5 X0
    SendInput, {CapsLock Up}
    Suspend On
    Input, user_input, L1 T1

    return user_input
}

;--- Switching functions -------------------------------------------------------

CapsLock::
{
    switch_to_ShortcutMode()

    keywait, CapsLock, T20

    switch_to_InsertMode()
    SetCapsLockState, Off
    return
}

switch_to_InsertMode(){
    Splashimage, Off
    return
}

switch_to_ShortcutMode(){
    Splashimage,,b w5  h500  CWFF00FF00 m9  fs5 X0
    return
}

switchBackRoutine(){
    SplashTextOn,,, No Action Found,
    Suspend Off
    SendInput, {CapsLock Up}
    SetCapsLockState, Off
    SetCapsLockState, AlwaysOff
    Sleep 500
    SplashTextOff
}

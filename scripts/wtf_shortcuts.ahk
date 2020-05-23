; Autohotkey Version: 1.1.30
; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019
;
; Documentation
; This script manages all types of shortcuts which are triggered by capslock and
; a subsequent key combination.
; The shortcuts within this script link to websites, tools, folders and files.
;
; How to
;
; Hold down the capslock key to reach "shortcut mode" (a pink bar at the left
; side of your screen should appear). Then, you have three options on how to
; continue: press "w" to make your website shortcuts available, "t" for your
; tool shortcuts and "f" for your folder and file shortcuts. If you press one of
; this keys while holding capslock down, you are now within the specific
; shortcut menu (the pink bar at the left side should change to cyan).
; Now you can finally run a shortcut by pressing a defined key (after pressing
; the third key, you can release all three keys).
;
; Summary:
; * Press capslock and hold down
; * Press "w", "t" or "f" and also hold down
; * Press a shortcut key to trigger a shortcut (now release all three keys)
;
; Example:
; capslock + "w" + "g" will open "www.google.com" in your default browser
;
; Once you understand how this script works, feel free to customize it your way
; and fill it with our own shortcuts!
;
;--- Settings ------------------------------------------------------------------

#NoEnv

;-------------------------------------------------------------------------------

Sleep 500
switch_to_InsertMode()
DetectHiddenWindows, On

; avoid bad state of CAPS pressed when not down
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
;--- Shortcut definitions ------------------------------------------------------
;-------------------------------------------------------------------------------

;--- Shortcuts to Folders ------------------------------------------------------
$f::
{
    if(bool_isactive_InsertMode){
        SendInput, f
    }

    if(bool_isactive_ShortcutMode){
        ; get user input
        in := get_userinput()

        ;--- path definitions -----

        ; copy a specific path from your windows explorer and paste it into the
        ; double-quotes + assign a distinctive key.
        ; Paths could lead to a folder or to a file directly.
        if(in=="d"){
            load("C:\Users\<YOUR USERNAME>\Documents")
            return
        }

        if(in=="f"){
            load("W:\<FOLDERNAME>")
            return
        }

        if(in=="r"){
            load("C:\Users\...\Readme.md")
            return
        }

        ;--- switch back to insert mode after execution -----

        switchBackRoutine()
        return
        }
    return
}

;------------- Shortcuts to Websites -------------------------------------------
$w::
{
    if(bool_isactive_InsertMode){
        SendInput, w
    }

    if(bool_isactive_ShortcutMode){
        ; get user input
        in := get_userinput()

        ;--- URL definitions -----

        ; copy an URL from your browser into the double-quotes to create a
        ; shortcut + assign a distinctive key.
        if(in=="a"){
            load("https://www.autohotkey.com")
            return
        }

        if(in=="g"){
            load("https://www.google.com")
            return
        }

        if(in=="y"){
            load("https://www.youtube.com")
            return
        }

        ;--- switch back to insert mode after execution -----

        switchBackRoutine()
        return
        }
    return
}

;-------------- Shortcut to Software Tools -------------------------------------
$t::
{
    if(bool_isactive_InsertMode){
        SendInput, t
    }

    if(bool_isactive_ShortcutMode){
        ; get user input
        in := get_userinput()

        ;--- exe-file definitions (directly or as paths to ".exe" file) -----

        ; copy the name of an .exe file which AutoHotkey knows (requires a bit
        ; of google) or a specific path to an .exe file into the double-quotes
        ; to create a shortcut + assign a distinctive key.
        ; A little bit of sleeping is necessary when loading an application.
        if(in=="c"){
            load("calc.exe")
            return
        }

        if(in=="n"){
            load("C:\Users\<YOUR USERNAME>\AppData\Local\Programs\...\*.exe")
            Sleep 500
            return
        }

        if(in=="s"){
            load("SnippingTool.exe")
            Sleep 500
            return
        }

        if(in=="x"){
            load("OUTLOOK.exe")
            Sleep 500
            load("firefox.exe")
            Sleep 500
            return
        }

        ;--- switch back to insert mode after execution -----

        switchBackRoutine()
        return
        }
    return
}

;-------------------------------------------------------------------------------
;--- Helper Functions ----------------------------------------------------------
;-------------------------------------------------------------------------------

;--- Load Function -------------------------------------------------------------
; this function loads files, folders and websites
load(what){
  Suspend Off
  switch_to_InsertMode()
  Run %what%
  return
}

;--- User Input Function -------------------------------------------------------
; this function receives the user input after pressing a category key (w, t, f)
get_userinput(){
    Splashimage,,b w5  h500  CW00FFFF00 m9  fs5 X0
    SendInput, {CapsLock Up}
    Suspend On
    Input, user_input, L1 T1

    return user_input
}

;--- Switching Logic -----------------------------------------------------------

CapsLock::
{
    if(bool_isactive_InsertMode){
        bool_wasInsert:=true
    }

    switch_to_ShortcutMode()

    keywait, CapsLock, T30

    switch_to_InsertMode()ii
    SetCapsLockState, Off
    return
}

switch_to_InsertMode(){
    Splashimage, Off
    global bool_isactive_InsertMode
    global bool_isactive_ShortcutMode
    bool_isactive_InsertMode := true
    bool_isactive_ShortcutMode := false
    return
}

switch_to_ShortcutMode(){
    Splashimage,,b w5  h500  CWFF00FF00 m9  fs5 X0
    global bool_isactive_InsertMode
    global bool_isactive_ShortcutMode
    bool_isactive_InsertMode := false
    bool_isactive_ShortcutMode := true
    return
}

switchBackRoutine(){

    if(bool_wasInsert){
        switch_to_InsertMode()
	}
    else{
        switch_to_ShortcutMode()
	}

	bool_wasInsert:=false

	SplashTextOn,,, No Action Found,
	Suspend Off
	SendInput, {CapsLock Up}
	SetCapsLockState, Off
	SetCapsLockState, AlwaysOff
	Sleep 500
	SplashTextOff
}
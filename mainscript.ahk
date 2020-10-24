; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019
;
; Documentation
; This script manages all subscripts and includes all hotkey-, hotstring-files.
;
;--- Settings ------------------------------------------------------------------

; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv

#SingleInstance force
StringCaseSense On
AutoTrim On
Process Priority,,High
SetWinDelay 10
SetKeyDelay -1
SetBatchLines -1

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;--- Include scripts -----------------------------------------------------------

GoSub wtf_shortcuts
GoSub hotstrings

wtf_shortcuts:
#Include %A_ScriptDir%\Scripts\wtf_shortcuts.ahk

hotstrings:
#Include %A_ScriptDir%\Scripts\hotstrings.ahk

#Include %A_ScriptDir%\Scripts\hotkeys.ahk

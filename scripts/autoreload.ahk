; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019
;
; Documentation
; This script reloads the mainscript after it has been changed and saved.
;
;--- Settings ------------------------------------------------------------------

#NoEnv

;-------------------------------------------------------------------------------

#Persistent

SetTimer, UPDATEDSCRIPT, 1000

UPDATEDSCRIPT:

FileGetAttrib, attribs, %A_ScriptFullPath%

IfInString, attribs, A
{
    FileSetAttrib, -A, %A_ScriptFullPath%
    SplashTextOn,,, Script has been updated,
    Sleep, 500
    Reload
}

return

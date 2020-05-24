; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019
;
; Documentation
; This file manages all types of hotkeys which are triggered by key combinations.
;
;--- Settings ------------------------------------------------------------------

#NoEnv

;-------------------------------------------------------------------------------

; AHK uses symbols to abbreviate special keys
; ^ -> ctrl (strg)
; ! -> alt
; + -> shift
; # -> windows key

; e.g. ^+x means you have to press "ctrl", "shift" and "x" at the same time


;--- media control -------------------------------------------------------------
; "Lbutton", "Rbutton" are the right or left mouse key
; "~" means to hold the key down while pressing the other

;--- next track -----
~Lbutton & Rbutton:: Media_Next

;--- restart or go to previous track -----
~Rbutton & Lbutton:: Media_Prev


;--- misc ----------------------------------------------------------------------

; current windows stays on top when you click other windows
^SPACE::  Winset, Alwaysontop, , A

; paste string in clipboard, cut out highlighted string and store in clipboard
; -> "exchanges" string in clipboard and string which is highlighted
^+x::
{
	clip := Clipboard
	SendInput, ^x
	SendInput, %clip%
	clip := ""
	return
}

; --- display google maps route -----
; display a predefined route in google maps (press Windows key and "m")
; search for your route in google maps, then paste the link here. In most cases,
; you will have to shorten it.
#m::Run https://goo.gl/maps/MeTqvRSTaLa25Cf9A

; --- google search -----
; use google to search for highlighted string (press "ctrl", "shift" and "c")
^+c::
{
	SendInput, ^c
	Sleep 50
	Run, http://www.google.com/search?q=%clipboard%
	return
}

; --- translate -----
; translate highlighted string with dict.cc (one or two words)
; or with deepl (whole sentences or phrases) (press Windows key and "t")
#t::
{
	clipboard =
	SendInput, ^c
	ClipWait, 0.1

	RegExReplace(clipboard, "\b.+?\b", "", count)
	count := Ceil(count / 2)

	if (count > 2) {
		Run https://www.deepl.com/translator#de/en/%clipboard%
	} else {
		Run https://www.dict.cc/?s=%clipboard%
	}
	return
}

; Created by: Leonhard Hermansdorfer
; Created on: 12.11.2019
;
; Documentation
; This file manages all types of hotstrings which are triggered by strings.
;
; You can set arbitrary string combinations as shortcuts. Some examples are
; provided here to give an impression on how hotstrings work.
;
; Detailed information can be found here: https://www.autohotkey.com/docs/Hotstrings.htm
;
;--- Settings ------------------------------------------------------------------

#NoEnv

;--- misc shortcuts ------------------------------------------------------------

::@yn::Your Name

::@mail::your@email.com

::gpu_ip::1.1.1.1


;--- email phrases -------------------------------------------------------------

;--- starting phrases -----

::dsom::Dear Sir or Madam,{Enter}
::dmr::Dear Mr
::dms::Dear Ms

;--- ending phrases & greetings -----

::ys::Yours sincerely
::br::Best regards,{Enter}Your Name
::ty::Thank you.


;--- time & date ---------------------------------------------------------------

::HH::
{
    FormatTime, CurrentDateTime,, yyyyMMdd_
    SendInput, %CurrentDateTime%
    return
}

::@d::
{
    FormatTime, today,, d. MMMM yyyy
    SendInput, %today%
    return
}

::@dd::
{
    FormatTime, today,, dd.MM.yyyy
    SendInput, %today%
    return
}


;-------------------------------------------------------------------------------
;--- Auto-Correction for Typos -------------------------------------------------

::youre::you're
::helo::hello
::reliabel::reliable

; and so on... there are many lists on the internet to copy and paste

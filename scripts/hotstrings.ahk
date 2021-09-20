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

;--- Initialize dynamic RegEx hotstrings ---------------------------------------

RegExHotstrings("#([d][d]?[d]?)([\+|\-]\d++)?([dmy]?)\s", "DateFormatter")

RegExHotstrings("(\d+)/(\d+)%", "Percent")

return


;-------------------------------------------------------------------------------
;--- Hotstring definitions -----------------------------------------------------
;-------------------------------------------------------------------------------

;--- misc hotstrings -----------------------------------------------------------

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
;--- RegEx hotstring definitions -----------------------------------------------
;-------------------------------------------------------------------------------

;--- Calculate percentage ------------------------------------------------------
; calculate the percentage of one value divided by another value (e.g. 4/5% is replaced by 80.0%)

Percent:
    p := Round($1 / $2 * 100,1)
    SendInput, %p%`%
    Return

;--- Insert modified and formatted date ----------------------------------------
; output today's date in different format and add/ subtract days, months or years
; examples
;   #d outputs the format: 12.10.2020
;   #dd outputs the format: 12. Oktober 2020
; adding/subtracting value requires d '+' or '-' sign after the format variables
;   #d-10, #dd+27, ...
; to specify which unit should be added/subtracted, either 'd', 'm' or 'y' must follow the numerical value
;   #d-10d, #dd+27m, #d-1y, ... (if no date unit is provided, 'days' is set as default)

DateFormatter:

    number := SubStr($2, 2)

    ; if timeunit to add/subtract is empty, set default to "days"
    if($3 == ""){
        $3 = d
    }

    ; get current date
    currentDate := A_Now

    ; add/ subtract a certain amount of days/months/years from today's date
    if(SubStr($2, 1, 1) == "+"){
        ; debugging
        ;SendInput, sign: {+}{Enter}

        if($3 == "d"){
            currentDate += number, days

        } else if($3 == "m"){

            ; get numerical value for current month
            FormatTime, currentmonth, %currentDate%, MM

            add_months := Mod(number, 12)
            years := Round((number - add_months) / 12)

            currentDate := currentDate + (years * 10000000000) + (add_months * 100000000)

            if((12 - currentmonth) < add_months){
                sub_months := 12
                currentDate := currentDate + 10000000000 - (sub_months * 100000000)
            }

        } else if($3 == "y"){
            currentDate := currentDate + (number * 10000000000)
        }

    } else if(SubStr($2, 1, 1) == "-"){
        ; debugging
        ;SendInput, sign: -{Enter}

        if($3 == "d"){
            ; there seems to be a bug which makes "-=" not work!
            ; https://autohotkey.com/board/topic/53543-subtract-days-from-a-date-does-not-work/
            currentDate += -number, Days

        } else if($3 == "m"){

            ; get numerical value for current month
            FormatTime, currentmonth, %currentDate%, MM

            sub_months := Mod(number, 12)
            years := Round((number - sub_months) / 12)

            currentDate := currentDate - (years * 10000000000) - (sub_months * 100000000)

            if(currentmonth <= sub_months){
                add_months := (currentmonth + 12) - sub_months
                currentDate := currentDate + (add_months * 100000000)
            }

        } else if($3 == "y"){
            currentDate := currentDate - (number * 10000000000)
        }
    }

    ; define format for printing the date
    ; "d" prints 22.10.2020
    if($1 == "d"){
        FormatTime, date_print, %currentDate%, dd.MM.yyyy
        SendInput, %date_print%
        return

    ; "dd" prints 22. October 2020
    } else if($1 == "dd"){
        FormatTime, date_print, %currentDate%, d. MMMM yyyy
        SendInput, %date_print%
        return
        }

    return


;-------------------------------------------------------------------------------
;--- Auto-Correction for Typos -------------------------------------------------
;-------------------------------------------------------------------------------

::youre::you're
::helo::hello
::reliabel::reliable

; and so on... there are many lists on the internet to copy and paste

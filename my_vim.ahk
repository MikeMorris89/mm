#NoEnv ;

SendMode Input ;
SetWorkingDir %A_ScriptDir% ;

LAlt & WheelDown::AltTab
LAlt & WheelUp::ShiftAltTab

LCtrl & WheelDown::Send, {Control down}{Tab}{Control up}
LCtrl & WheelUp::Send, {Control down}{Shift down}{Tab}{Shift up}{Control up}


!l::
Send {Right down} ; 
KeyWait a ;
Send {Right up} ;
Return

!k::
Send {Up down} ; 
KeyWait a ;
Send {Up up} ;
Return

!j::
Send {Down down} ; 
KeyWait a ;
Send {Down up} ;
Return

!h::
Send {Left down} ; 
KeyWait a ;
Send {Left up} ;
Return



!d::Send, {del}

^h::Send, {Shift Down}{Home}{Shift up}
^l::Send, {Shift Down}{End}{Shift up}
;r::Send, {Shift Down}{End}{Shift up}{del}{Shift Down}{Home}{Shift up}{del}



::btw::
   MsgBox You typed "btw".
Return

::<-fun:: <-function(){}

:*d?:dd::
	send,{End}+{Home}^x
	return
	
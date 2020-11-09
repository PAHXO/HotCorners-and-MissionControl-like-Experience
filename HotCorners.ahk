#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#singleinstance force
#Persistent 			; Keeps script running persisitantly 
SetTimer, HotCorners, 0 		; HotCorners is name of timer, will be reset every 0 seconds until process is killed

global activeSwit := false



HotCorners: 				; Timer content 
CoordMode, Mouse, Screen		; Coordinate mode - coords will be passed to mouse related functions, with coords relative to entire screen 

LButtonIsDown := GetKeyState("LButton", "P")
if LButtonIsDown
{
	
	activeSwit := false
}

		

IsCorner(cornerID)
{
	WinGetPos, X, Y, Xmax, Ymax, Program Manager 		; get desktop size
	MouseGetPos, MouseX, MouseY 							; Function MouseGetPos retrieves the current position of the mouse cursor
	T = 5 												; adjust tolerance value (pixels to corner) if desired
	CornerTopLeft := (MouseY < T and MouseX < T) 					; Boolean stores whether mouse cursor is in top left corner
	CornerTopRight := (MouseY < T and MouseX > Xmax - T) 			; Boolean stores whether mouse cursor is in top right corner
	CornerBottomLeft := (MouseY > Ymax - T and MouseX < T) 			; Boolean stores whether mouse cursor is in bottom left corner
	CornerBottomRight := (MouseY > Ymax - T and MouseX > Xmax - T) 	; Boolean stores whether mouse cursor is in top left corner
	
	if (cornerID = "TopLeft"){
	RButtonIsDown := false
		return CornerTopLeft
	}
	else if (cornerID = "TopRight"){
		return CornerTopRight
	}
	else if (cornerID = "BottomLeft"){
		return CornerBottomLeft
	}
	else if  (cornerID = "BottomRight") {
		return CornerBottomRight
	}
}

; Show Task View (Open Apps Overview)
if IsCorner("TopLeft")
{
 
 
 if !activeSwit
 {
			Send, {Lalt down}{LCTRL down}{tab down}
			send, {lalt up} {lctrl up}{tab up}
			sleep 55
			send, {left}
			activeSwit := true
 }else 
 {
	send {space}
	activeSwit := false
 }
 

			
			

	Loop
	{ 
		if ! IsCorner("TopLeft")
			break ; exits loop when mouse is no longer in the corner
	}	


	
}

; Show Action Center
if IsCorner("TopRight")
{	
	Send, {LWin down}{a down}
	Send, {LWin up}{a up}
	Loop
	{
		if ! IsCorner("TopRight")
			break ; exits loop when mouse is no longer in the corner
	}	
}

; Press Windows 
if IsCorner("BottomLeft")
{	
	;Send, {LWin down}
	;Send, {LWin up}
	Loop
	{
		if ! IsCorner("BottomLeft")
			break ; exits loop when mouse is no longer in the corner
	}	
}


; Show Desktop 
if IsCorner("BottomRight")
{	
	;Send, {LWin down}{d down}
	;Send, {LWin up}{d up}
	Loop
	{
		if ! IsCorner("BottomRight")
			break ; exits loop when mouse is no longer in the corner
	}	
}


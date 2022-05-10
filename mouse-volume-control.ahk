F24::
; while the key is pressed, vertical movement of the mouse is controlling 
; the system volume

; this value is used for easier and finer volume adjustment
; value of 1 means 1 pixel of mouse movement equals 1% volume change
; value of 4 means 4 pixels of mouse movement equal 1% volume change
pixel_to_volume_scaling := 4

; get current mouse position and offset it by current volume
MouseGetPos, , last_mouse_y,
SoundGet, current_volume

reference_mouse_y := last_mouse_y + current_volume * pixel_to_volume_scaling 
current_volume := floor(current_volume)
ToolTip, Volume: %current_volume%,

while KeyIsDown := GetKeyState("F24") {
    
    MouseGetPos, , new_mouse_y, 
    if (new_mouse_y == last_mouse_y) {
	; if the mouse did not move vertically, just sleep for a while
        sleep, 50
	; and go to the next iteration
        Continue
    }
    last_mouse_y := new_mouse_y
	
    
    new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling  
    if (new_volume > 100) {
	; cap the volume by moving the reference point
        reference_mouse_y := new_mouse_y + 100 * pixel_to_volume_scaling 
        new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling 
    }
    if (new_volume < 0) {
	; cap the volume by moving the reference point
        reference_mouse_y := new_mouse_y
        new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling 
    }
	
    ; floor the value for readability 
    ; I also assume that windows doesn't care for fractional values anyway
    new_volume := floor(new_volume)
    ToolTip, Volume: %new_volume%,
    SoundSet, %new_volume%
    
}

ToolTip,
return
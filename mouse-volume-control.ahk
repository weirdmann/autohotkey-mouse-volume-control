F24::
; while the key is pressed, vertical movement of the mouse is controlling 
; the system volume

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
        sleep, 50
        Continue
    }
    last_mouse_y := new_mouse_y

    new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling  
    if (new_volume > 100) {
        reference_mouse_y := new_mouse_y + 100 * pixel_to_volume_scaling 
        new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling 
    }
    if (new_volume < 0) {
        reference_mouse_y := new_mouse_y
        new_volume := (reference_mouse_y - new_mouse_y) / pixel_to_volume_scaling 
    }

    new_volume := floor(new_volume)
    ToolTip, Volume: %new_volume%,
    SoundSet, %new_volume%
    
}

ToolTip,
return
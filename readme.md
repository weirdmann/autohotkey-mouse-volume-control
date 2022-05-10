# The most convenient way to control windows volume
IMHO


I have a DPI button on my mouse that I didn't have any use for. I got an idea that I could use it to control sound volume. I already have a ~500 lines of autohotkey script running on all my windows machines with a lot of custom hotkeys and I think this is the most universally useful part of it.


I mapped my DPI button to an F24 key so it wouldn't interfere with any app. The script converts vertical mouse movement to volume value and sets it with AutoHotkey's `SetSound` function.
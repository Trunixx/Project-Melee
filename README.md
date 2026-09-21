
# Project Melee
Project Melee is the codename of a WIP game that features *parkour*, *stealth* and *combat*, all used to complete the levels however the player wants, resembling an immersive sim style of game.
At this time, it only features slightly-more-complex-than-average movement implemented using a FSM ([credits](https://pantheradigital.itch.io/godot-modular-character-controller)) then personally edited to an HSM.
The placeholder assets of the main character used at first were [these free ones](https://benvictus.itch.io/test-dummy-platformer); now they have been replaced with [these paid ones](https://zegley.itch.io/2d-platformermetroidvania-asset-pack).

## Parkour
The main character can walk, run, and sprint. While sprinting (**Shift**), auto-mantling is enabled (automatic climbing of short obstacles).
While on a wall, you'll slide unless you hold the **W** key, which gives you two seconds of climbing, or you can walljump. If a ledge is detected, it gets climbed.
While moving, you can slide down with the **S** key, obtaining a short boost (once every two seconds) and gaining speed while going down slopes.
While jumping, you can hold the **Space** key to jump higher, release it sooner than the maximum height, or hold **S** to fall faster.
There have been implemented various mechanics to help with making the movement feel more fluid, like:
- **coyote time**: you can jump shortly after leaving a platform
- **buffer timers**: you can jump and slide even if you input the keys before touching the ground
- **edge detection**: if you try to stop yourself over falling off an edge, the remaining velocity won't make you fall off
- **directional queue**: you can override the direction without having to release the keys thanks to a queue

## Stealth
If you try to slide without inputting a direction, or you lose too much speed while sliding, you'll crouch. Right now, there are two speeds (toggleable by sprinting via **Shift**). 

## Combat
Combat is still WIP, it's only possible to switch from the normal states, to the unanimated Combat state.

## Controls
### Keyboard Controls
    W: Climb wall
	A,D: Move
	S: Crouch, slide, or fall faster
	LShift: Toggle sprint (even while crouching)
	LAlt: Toggle walking
	Space: Jump

	Tab: Combat (not implemented yet)

## Known issues
- Sometimes it goes into the Wall state without entering any leaf (not easy to reproduce)
- When sprinting and auto-mantling, if you collide into the wall while not pressing any key, then press the opposite key, it goes into the Wall state without entering any leaf, getting stuck until you jump
- Ledge climbing stutters and sometimes it triggers two times; this is caused by the position not changing adequately, but doing it right takes too much time and trial and error

## Installation
At this time, the only supported OS is Windows (sorry :c)
To download the latest version, head over to the release section on this GitHub page and download the "Project Melee.exe" file.
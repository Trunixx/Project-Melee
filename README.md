# Project Melee
Project Melee is the codename of a WIP game that features *parkour*, *stealth* and *combat*.

The player can choose their favorite style of gameplay to complete the levels however they want, resembling an immersive sim style of game.
At this time, it only features slightly-more-complex-than-average movement implemented using a FSM ([credits](https://pantheradigital.itch.io/godot-modular-character-controller)) that was then personally edited to an HSM.

The placeholder assets of the main character used at first were [these free ones](https://benvictus.itch.io/test-dummy-platformer); now they have been replaced with [these paid ones](https://zegley.itch.io/2d-platformermetroidvania-asset-pack).

## Parkour
The main character can walk, run, and sprint. While sprinting (**Shift**), auto-climbing of short obstacles is enabled.

While colliding with a wall, you'll begin to slide unless you hold the **W** key, which gives you two seconds of climbing, or you can walljump at no stamina cost. If a ledge is detected, it gets climbed.

While moving, you can slide down with the **S** key, obtaining a short boost (once every two seconds) and gaining speed while going down slopes.

While jumping, you can hold the **Space** key to jump higher, release it sooner than the maximum height, or hold **S** to fall faster.


There have been coded various mechanics to help with making the movement feel more fluid, like:
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
- Presliding and Postsliding animations are missing, so it looks like it stutters before and after sliding

## Installation
At this time, the only supported OS is Windows (sorry :c)

To [download the latest version](https://github.com/Trunixx/Project-Melee/releases), head over to the release section on this GitHub page and download the "Project Melee.exe" file.

## Miro Board
<div align="center">
  <a href="https://miro.com/app/live-embed/uXjVHkuOyS8=/?focusWidget=3458764684340053774&embedMode=view_only_without_ui&embedId=920517788116">
    <img width="1055" height="779" alt="Weather App Demo" src="https://github.com/user-attachments/assets/a8b24452-a907-45f3-8a53-4d172e2d246f" />
  </a>
</div>

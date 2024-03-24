#
## Batocera 39-Choko - Capcom Home Arcade - Dual Boot Edition

This is the fork of [Batocera Linux](https://batocera.org) with a customized version for the [Capcom Home Arcade](https://capcomhomearcade.com) device.

#
![Batocera 39 UI](./ChokoGroup/BatoceraFavorites.png)
#

## What is special about batocera 39-Choko?

- It's a dual boot system image with both Official OS v1.71 and Batocera 39. The img file can be written either in [eMMC](https://github.com/lilo-san/cha-documentation#installing-software) or [SD card](https://github.com/lilo-san/cha-documentation#hardware-modifications), using [BalenaEtcher](https://etcher.balena.io), or similar program.

- We can use Emulation Station (Batocera style UI) or RetroArch (Lakka style UI).

- Scanlines shader crt/GritsScanlines enabled by default for both Emulation Station and RetroArch.

- Possibility to download and install future updates from our repository without the need of a computer.

- Similar to what is done in Lakka, whe can add/update cores copying them to `/userdata/system/configs/retroarch/assets` (network address should be `\\BATOCERA\share\system\configs\retroarch\assets`). Keep reading for a list of important folders.


#
![Choko Menu](./ChokoGroup/ChokoMenu.png)
#

Compared to official Official Batocera 39, this version has some new or updated packages:

- RetroArch and libretro-core-info v1.18.0 (instead of v1.16.0)

- FBalpha2012 libretro core added

- FB Neo libretro core updated to 2024-03-22 version


#
![RetroArch Menu](./ChokoGroup/RetroArchMainMenu.png)
#

To save some space (needed to support future online updates), some packages were removed:

- Removed support for Wiimotes, joycons, wheels, pixelcade and led screens.

- Removed many standalone emulators that also had libretro cores, like SCUMMVM and flash player.

- Removed most of handhelds emulators.


#
![Boot screen](./ChokoGroup/ChokoHomeArcade.png)
#

## Several notes

- Batocera is demanding and we strongly advise to install a fan over the heatsink. When the CHA overheats it becomes slower and crashes.

- Booting into Batocera takes some time, specially if loading from USB. The first boot can take a minute or more.

- After booting once into Batocera, and if you are not using SD card, you should select an USB disk to be used following [this instructions](https://wiki.batocera.org/store_games_on_a_second_usb_sata_drive).

- Currently, it is not possible to configure WiFi or disable/enable shaders from RetroArch. You must boot into EmulationStation to set WiFi or to disable/enable shaders.

- To create playlists in RetroArch, follow the steps in this video:
##
<video src="https://github.com/ChokoGroup/batocera-CHA/raw/master/ChokoGroup/RetroArch%20-%20Manual%20Folder%20Scan.mp4" controls="controls"></video>
#

- Take in consideration that RetroArch's thumbnails downloader is very basic.
In "Manual Scan" -> "System Name" select "Custom" and then in "Custom System Name" write exactly the name of the closest folder in [their servers](https://thumbnails.libretro.com/).
Notice, for example, that is `MAME` folder and NOT "mame". For fbneo games, "Custom System Name" must be exactly `FBNeo - Arcade Games`.


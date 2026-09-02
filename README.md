# Random_Game_V_Bug_Invasion
A cancelled ROM hack for Super Mario World that is a crossover between SMW and my video game Bug Invasion.

2 Closed Source applications that is necessary is Lunar Magic and YYCHR.

Open Source appications you need:
1.ASAR assembler
2.PIXI Custom Sprite Inserter
3.unix2dos, converts text file endings from unix format to dos format which is necessary for .cfg files, which are one of the types of files the assembler needs
4.FLIPS for creating the soft patch
5.bsnes, The SNES Emulator that can do soft patches



You must own the game first/own an official copy of Super Mario World. I do not provide any copies/ROMs of Super Mario World.



Examples of Nominative fair use for trademarks here:
https://www.youtube.com/watch?v=iSo_xMhMz0Q
https://www.youtube.com/watch?v=ZDnZDXHuC_w
https://www.youtube.com/watch?v=uxvKmA3Dvqc



Current Status:
Canceled- archived, not maintained. The project is incomplete and is provided as is for archival and educational purposes. No future updates or support as planned.



Original Intent:
this project was intended to be a crossover ROM hack combining Super Mario World and my original game Bug Invasion and inspire anyone to make crossover rom hacks between any game they choose that they owned a copy of and Bug Invasion. Development was discontinued before what was needed was completed. This Repo only contains the source code, artwork, custom palette for sprites and the files needed for compiling the project. Everything in here were originated by me, I am not affiliated with Nintendo in any way shape or form. Forks of this project may continue development if they so choose. The patch I was trying to create here was a soft patch. When creating new levels in Lunar Magic you must save each level as a .mwl file. The licensing in this repo here only applies the files here in this repository.


Prerequisites after having all applications:
When using run.sh you need to have the terminal go into your pixi folder. All files, their folders and compiled executable for ASAR must be in PIXI folder. ASAR must have permission to execute.


assembling instructions:

name of clean rom must be lowercase and underscores

1. Open the Clean ROM in Lunar Magic, Run Lunar Magic. Open your clean super_mario_world.sfc file.
2. Force the Initial Expansion Save (The Mandatory Step)Go to Level 105 (the default starting level).Simply click the Save Level Icon (Ctrl + S).Why this is mandatory: A clean Super Mario World ROM from 1990 is compressed to exactly 512KB or 1MB. Clicking Save for the first time forces Lunar Magic to expand the ROM's file size to 2MB or 4MB. It rearranges the internal pointers, cleans out old Nintendo data blocks, and creates empty memory banks.
3. Run Your Inserter Tool Script Close Lunar Magic completely so it drops its active file locks on your project.Open your terminal window and run your compilation line:bash./run.sh
Use code with caution. Why this order matters: Now that Lunar Magic has cleared out those empty 2MB/4MB memory banks, PIXI can safely scan the ROM, find those clean blocks, and inject your custom bullet and enemy physics without overwriting any actual level data!You had the workflow perfectly right. Passing it through Lunar Magic first handles all the heavy lifting behind the scenes.


this is necessary after assembling when anyone is distributing rom hack, which creates the soft patch file:

[ Step 1: Compile via Assemblers ]
  Original Base ROM + Your .asm Files ─────► Creates a Temporary Modified ROM
                                                        │
[ Step 2: Compare via Flips ]                           ▼
  Original Base ROM ◄─── (Compares Bytes) ───► Temporary Modified ROM
                                                        │
                                                        ▼
                                              Generates: Random_Game_V_Bug_Invasion.bps



What is needed:

the custom sprites need to be inserted in any level.

Row 9 and below on color palette in lunar magic needs to be these colors, 00:0,0,0 01:255,255,255 02:255,0,0 03:255,255,0 04:0,255,0 05:0,0,255 06:0,89,0 07:255,116,0 08:84,0,231 09:0,255,255 0A:255,49,0 0B:255,83,0 0C:255,116,0 0D & 0E & 0F:0,0,0 for color pallete, the checkbox enable custom level palette needs to be checked and save icon must be pressed on palette window and then save to rom in main window must be pressed.

Enemy and powerup sprites need to call the tiles right and bottom to the top left tile in order to see the whole sprite. 

Enemies vs. Powerups = No Collision Because the enemy's loop only scans the sprite table for active bullet IDs (CMP #$01, etc.), the enemies will completely ignore the powerup items sitting in the level grid. They will walk straight through them with zero interactions. 

Enemies vs. Player = Player Death, it is needed to add a secondary check inside the enemy scripts using Super Mario World's native player-contact routine (JSL $01A7DC). If Mario touches the enemy box, it will bypass standard damage and trigger the instant death vector (JSL $00F5B7), flipping Mario off-screen.

Bullet Projectiles vs. Matching Enemies = Enemy Death needs to be tested. red_enemy.asm will only trigger its death routine if hit by Bullet 01. yellow_enemy.asm only dies to Bullet 02, and so on. If a mismatched color bullet passes over an enemy, the BNE .NextSlot command skips it entirely, letting the projectile clip straight through cleanly.





CC BY-SA 4.0 and GNU GPL v3.0 Conditional Exceptions to use MPL 2.0 and CC BY-SA 4.0 or CC BY 4.0

If the following condition is met, the licensing rules for both content covered by GNU GPL v3.0 and content not covered by GNU GPL v3.0 are modified as described below:

Condition:

The developer is distributing, porting, or integrating the software with platforms or environments that impose requirements incompatible with GPL-3.0, including but not limited to:
- proprietary or non-redistributable SDKs
- confidential hardware or platform documentation
- legally required confidentiality obligations preventing full GPL redistribution
- safety-regulated or certified systems where full GPL redistribution cannot be satisfied

Effect on licensing:

- Content covered by GNU GPL v3.0: May instead be used under the Mozilla Public License 2.0.

- Content not covered by GNU GPL v3.0 (e.g., assets): Normally may be used under CC BY-SA 4.0. If ShareAlike requirements of CC BY-SA 4.0 prevent lawful distribution under the MPL alternative, developers may instead use CC BY 4.0 **solely to the extent necessary** to enable such distribution.

These exceptions apply **only when the condition above is met**.




CC BY-SA 4.0 and GNU GPL v3.0 Conditional Exceptions to use BSD-3-Clause and CC BY 4.0:

If **either** of the following conditions is met, the licensing
rules for both content covered by GNU GPL v3.0 and content not
covered by GNU GPL v3.0 are modified as described below:

Conditions:

1. The developer has made a licensing agreement with another entity
   (excluding corporate/LLC or equivalent entities) that prohibits the
   redistribution of content under copyleft licenses.

2. The developer adds assets that they do not own and uses them
   under fair use, or equivalent/similar legal arrangements, where
   the developer cannot legally contribute those assets under a
   copyleft license.

Effect on licensing:

- Content covered by GNU GPL v3.0: May instead be used under the
  BSD 3-Clause License.

- Content not covered by GNU GPL v3.0: Assets originally under CC BY-SA 4.0
  may instead be used under CC BY 4.0.

These exceptions apply **only when at least one of the conditions above is met**.





CC BY-SA 4.0 and GNU GPL v3.0 Conditional Exceptions to use PolyForm Noncommercial and CC BY-NC 4.0

The PolyForm Noncommercial License (and Creative Commons
Attribution-NonCommercial 4.0 International for non-code
content) may be used as an alternative only when the combined
work is subject to binding legal, contractual, or platform-
imposed restrictions that prohibit commercial use.

Such restrictions may arise from third-party licenses,
distribution platforms, or other enforceable legal terms that
make commercial use of the combined work not legally permitted.

Content covered by the primary license (e.g., source code or
other covered material) remains governed by that license.

Content not covered by the primary license (e.g., assets,
documentation, or other non-code materials) is governed by
CC BY-NC 4.0, unless otherwise stated.

This alternative applies only to the extent necessary to
comply with such restrictions.




CC BY-SA 4.0 and GNU GPL v3.0 Conditional Exceptions to use PolyForm Strict and CC BY-NC-ND 4.0

The PolyForm Strict License may be used as an alternative
license only when the combined work is subject to binding
legal, contractual, or platform-imposed restrictions that
require both non-commercial use and prohibit the creation of
derivative works as part of the distribution terms.

Such restrictions may arise from third-party licenses,
distribution platforms, or other enforceable legal terms that
impose both non-commercial and no-derivatives requirements on
the combined work.

Content covered by the primary license (e.g., source code or
other covered material) remains governed by that license.

Content not covered by the primary license (e.g., assets,
documentation, or other non-code materials) is governed by
Creative Commons Attribution-NonCommercial-NoDerivatives
4.0 International (CC BY-NC-ND 4.0), unless otherwise stated.

This alternative applies only to the extent necessary to
comply with such restrictions.

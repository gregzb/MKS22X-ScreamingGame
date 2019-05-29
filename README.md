# Screaming Game
  This project appears to be a normal platformer at first glance, but comes with the twist that rather than using the keyboard to control the character, sound from the microphone is used instead.
  
## How To Run It
  Open up the project in Processing, press the play button and use A, D, and space to move around.
  (Only tested in Processing version 3.5.3). 
  New Version: You can now use sound (optionally clapping) to control the character. The loudness (amplitude) will cause the 
  character to move more slowly/faster while the pitch (frequency). 
  
## Development Log
### 5/17/2019
  * Added some of the general structure of the code, like the helper classes/data storage classes, etc  -Greg
  * Gave CollidableObjects the ability to have velocity and acceleration  -Greg
  * Added basic gravity to the player, generate several platforms are the beginning of the game, and everything scrolls to the left   -Greg
  
### 5/18/2019
  * Added Separating Axis Theorem Collision to player, player can now stand on platforms  -Greg
  * System for keyboard input is added - the player may be controlled with A, D, and SPACE  -Greg
  * The player dies when outside the bounds of the screen -Greg
  
### 5/21/2019
  * Added basic ray casting classes -Greg
  * Worked on getting the amplitude of sound to give the x acceleration - Emma
  * Started getting the frequency to determine the move (jump/move/nothing) - Emma

### 5/22/2019
  * Finished getting the frequency to determine the move - Emma
  
# Authors
  * Greg Zborovsky
  * Emma Choi

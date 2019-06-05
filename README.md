# Urlando
  This project appears to be a normal platformer at first glance, but comes with the twist that rather than using the keyboard to control the character, sound from the microphone is used instead. 
#### Get the highest score you can in this endless platformer!
  
## How To Run It
  1. Open up the project in Processing
  2. Install the Sound Library (Sketch > Import Library > Add Library... > Search for "Sound" > Install The Processing Foundation's Library)
  3. Press Play
  
## Controls
  * Use your microphone to move around. A low pitch sound will only move the character forward. A high pitch sound will move the character forward and cause them to jump.
  * P to Pause
  * Esc to go back to the main menu
  
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
  * ~~Finished getting the frequency to determine the move - Emma~~
  * Realized that the frequency analyzer does not work as expected, used a frequency visualizer to better see the input -Greg
  
### 5/23/2019
  * Added a few methods to begin making raycasting work -Greg
  
### 5/29/2019
  * Researched how to isolate pitch from the frequency bands -Emma
  * Added several methods for using raycasting for collision -Greg
  
### 5/30/2019
  * Experimented with pitch and modified it to take the frequency of the top 10 averages -Emma
  * Tried another method taking the top 10 frequencies

### 5/31/2019
  * Another method to take the top frequency and its surrounding neighbors (to eliminate the issue with overloading noise), 
    finally seemed to have reached a working method -Emma
  * Thought more about how raycasting could be used for platformer collision detection -Greg

### 6/1/2019
  * Continued brainstorming how raycasting could be used for platformer collision detection, potentially found a solution -Greg
  
### 6/2/2019
  * Made effort to use raycasting, but overall idea did not work and cannot be used for this project -Greg
  
### 6/3/2019
  * Removed raycasting related classes -Greg
  * Modified pitch detection to use "average of indices" with values as frequency -Greg
  * Added new textures/graphics, image loader, and nearest neighbor image scaler -Greg
  * Added infinite scrolling capabilities to the background -Greg
  * Added basic parts of animation system, especially for the character -Greg

### 6/4/2019
  * Finished animation system for this project -Greg
  * Assigned textures to platforms -Greg
  * Refactoring, Helper tab, etc -Greg
  * Added menu, new game title, and font -Greg
  * Pause capability added -Greg
  * Three difficulty settings on the main menu alter speed and scoring of the game -Greg
  * Added terrain generation with a few different types of "terrains" (up, down, flat, jump, etc) -Greg

# Additional Notes
  * Pitch detection is not perfect, but mostly differentiates most vocals from claps.
  * Separation Axis Theorem collision is used rather raycasting collision or any other form of collision. Sloped surfaced do not seem possible to handle.
  * Processing doesn't seem to handle nearest neighbor scaling, so a method from StackOverflow was borrowed and modified.

# Authors
  * Greg Zborovsky
  * Emma Choi

import java.util.*;


Game g;
Set<Character> keysDown;

void setup() {
  size(600,600);
  noSmooth();
  
  surface.setTitle("Urlando");
  noStroke();
  
  keysDown = new HashSet<Character>();
  g = new Game(keysDown);
}

void draw() {
  g.runLoop();
}

void keyPressed() {
  keysDown.add(key);
  
  if (key == ESC) { //stop esc from escaping
    key = 0;
    g.setGameState("menu");
  }
}

void keyReleased() {
  keysDown.remove(key);
}

//https://0x72.itch.io/16x16-dungeon-tileset
//https://jesse-m.itch.io/jungle-pack

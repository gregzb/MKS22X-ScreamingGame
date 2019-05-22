import java.util.*;


Game g;
Set<Character> keysDown;

void setup() {
  size(600,600);
  
  surface.setTitle("Screaming Game");
  noStroke();
  
  keysDown = new HashSet<Character>();
  g = new Game(keysDown);
}

void draw() {
  g.runLoop();
}

void keyPressed() {
  keysDown.add(key);
}

void keyReleased() {
  keysDown.remove(key);
}

import java.util.*;


Game g;
Set<Character> keysDown;

public PApplet p = this;

void setup() {
  size(600,600);
  noSmooth();
  
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

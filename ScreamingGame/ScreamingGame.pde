Game g;

void setup() {
  size(600,600);
  
  surface.setTitle("Screaming Game");
  noStroke();
  
  g = new Game();
}

void draw() {
  g.runLoop();
}

Game g;

void setup() {
  size(600,600);
  surface.setTitle("Screaming Game");
  g = new Game();
}

void draw() {
  g.loop();
}

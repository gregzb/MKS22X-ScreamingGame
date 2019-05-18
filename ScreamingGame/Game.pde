public class Game {
  
  AudioInputManager audioInManager;
  World world;
  
  public Game() {
    audioInManager = new AudioInputManager();
    
    world = new World(0);
    Player p = new Player(world, new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), color(255, 0, 127));
    world.setPlayer(p);
    
    init();
  }
  
  public void init() {
    int numPlatforms = 20;
    
    for (int i = 0; i < numPlatforms; i++) {
      Platform platform = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      world.addPlatform(platform);
    }
  }
  
  public void runLoop() {
    pushMatrix();
    background(world.getBackgroundColor());
    float secsRunning = millis() / 1000.0;
    float pixelsPerSeconds = 50;
    translate(-(secsRunning * pixelsPerSeconds), 0);
    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update();
    }
    for (CollidableObject cObject : cObjects) {
      cObject.display();
    }
    popMatrix();
  }
}

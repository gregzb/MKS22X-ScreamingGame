public class Game {
  
  AudioInputManager audioInManager;
  World world;
  
  public Game() {
    audioInManager = new AudioInputManager();
    Player p = new Player(new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), color(255, 0, 127));
    world = new World(0, p);
    
    int numPlatforms = 20;
    
    for (int i = 0; i < numPlatforms; i++) {
      Platform platform = new Platform(new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      world.addPlatform(platform);
    }
    
    init();
  }
  
  public void init() {
    
  }
  
  public void runLoop() {
    pushMatrix();
    background(world.getBackgroundColor());
    float secsRunning = millis() / 1000.0;
    translate(-(secsRunning * 100), 0);
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

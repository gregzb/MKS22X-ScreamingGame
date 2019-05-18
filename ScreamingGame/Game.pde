public class Game {
  
  private AudioInputManager audioInManager;
  private World world;
  private Set<Character> keysDown;
  private Set<Character> prevKeysDown;
  
  public Game(Set<Character> keysDown) {
    audioInManager = new AudioInputManager();
    this.keysDown = keysDown;
    this.prevKeysDown = new HashSet<Character>(this.keysDown);
    
    world = new World(0);
    Player p = new Player(this, new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), color(255, 0, 127));
    world.setPlayer(p);
    
    init();
  }
  
  public void init() {
    int numPlatforms = 20;
    
    //plat1 = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-50, 25)), new PVector(width/2, height/2), color(10, 22, 100));
    //plat2 = new Platform(world, new Polygon(new PVector(-60, 20), new PVector(90, 40), new PVector(75, 60), new PVector(-75, 75)), new PVector(width/2, height/2), color(120, 200, 100));
    
    for (int i = 0; i < numPlatforms; i++) {
      Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      world.addPlatform(platform);
    }
    
    //Platform platform = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225, height - 100), color(40, 90, 230));
    //world.addPlatform(platform);
  }
  
  public void runLoop() {
    pushMatrix();
    background(world.getBackgroundColor());
    float secsRunning = millis() / 1000.0;
    float pixelsPerSeconds = 50;
    //translate(-(secsRunning * pixelsPerSeconds), 0);
    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update();
    }
    for (CollidableObject cObject : cObjects) {
      cObject.display();
    }
    //plat1.update();
    //plat2.update();
    //plat1.display();
    //plat2.display();
    
    //System.out.println(plat1.getHitbox().intersects(plat2.getHitbox()));
    
    popMatrix();
    
    this.prevKeysDown = new HashSet<Character>(this.keysDown);
  }
  
  public World getWorld() {
    return world;
  }
  
  public AudioInputManager getAudioInputManager() {
    return audioInManager;
  }
  
  public boolean keyDown(Character keyD) {
    return keysDown.contains(keyD);
  }
  
  public boolean prevKeyDown(Character keyD) {
    return prevKeysDown.contains(keyD);
  }
}

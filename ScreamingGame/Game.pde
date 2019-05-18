public class Game {
  
  AudioInputManager audioInManager;
  World world;
  
  public Game() {
    audioInManager = new AudioInputManager();
    Player p = new Player(new Polygon(new PVector(0, 0), new PVector(20, 0), new PVector(20, 30), new PVector(0, 30)), new PVector(width/2, height/2), color(255, 0, 127));
    world = new World(0, p);
    
    init();
  }
  
  public void init() {
    
  }
  
  public void runLoop() {
    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update();
    }
    for (CollidableObject cObject : cObjects) {
      cObject.display();
    }
  }
}

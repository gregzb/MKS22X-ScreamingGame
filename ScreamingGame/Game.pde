public class Game {
  
  AudioInputManager audioInManager;
  World world;
  
  public Game() {
    audioInManager = new AudioInputManager();
    Player p = new Player(new Polygon(new PVector(0, 0), new PVector(10, 0), new PVector(10, 10), new PVector(0, 0)), new PVector(width/2, height/2), color(255, 0, 127));
    world = new World(0, p);
    
    init();
  }
  
  public void init() {
    
  }
  
  public void loop() {
    
  }
}

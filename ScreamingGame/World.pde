public class World {
  
  private ArrayList<CollidableObject> cObjects;
  private ArrayList<Platform> platforms;
  private Player player;
  private int difficulty;
  private int score;
  
  public World(int difficulty) {
    this.difficulty = difficulty;
    this.score = 0;
    this.cObjects = new ArrayList<CollidableObject>();
    this.platforms = new ArrayList<Platform>();
    this.player = new Player(new Polygon(new PVector(0, 0), new PVector(10, 0), new PVector(10, 10), new PVector(0, 0)), new PVector(width/2, height/2), color(255, 0, 127));
  }
}

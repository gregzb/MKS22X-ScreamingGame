public class World {
  
  //private ArrayList<CollidableObject> cObjects;
  private ArrayList<Platform> platforms;
  private Player player;
  private int difficulty;
  private int score;
  private color backgroundColor;
  
  public World(int difficulty, Player player) {
    this.difficulty = difficulty;
    this.score = 0;
    //this.cObjects = new ArrayList<CollidableObject>();
    this.platforms = new ArrayList<Platform>();
    this.player = player;
    this.backgroundColor = color(200, 217, 234);
    
    //this.cObjects.add(this.player);
  }
  
  public void setDifficulty(int difficulty) {
    this.difficulty = difficulty;
  }
  
  public int getDifficulty() {
    return difficulty;
  }
  
  public void setScore(int score) {
    this.score = score;
  }
  
  public int getScore() {
    return score;
  }
  
  public Player getPlayer() {
    return player;
  }
  
  public color getBackgroundColor() {
    return backgroundColor;
  }
  
  public ArrayList<CollidableObject> getCollidableObjects() {
    ArrayList<CollidableObject> cObjects = new ArrayList<CollidableObject>();
    cObjects.add(player);
    for (Platform platform : platforms) {
      cObjects.add(platform);
    }
    return cObjects;
  }
  
  public void addPlatform(Platform platform) {
    platforms.add(platform);
  }
  
  public void removePlatform(int idx) {
    platforms.remove(idx);
  }
  
  public ArrayList<Platform> getPlatforms() {
    return platforms;
  }
  
}

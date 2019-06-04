public class Platform extends CollidableObject{
  private color c;
  
  public Platform(Game game, Polygon hitbox, PVector position, color c) {
    super(game, hitbox, position, new HashMap<String, PImage[]>());
    this.c = c;
  }
  
  public void update() {
    
  }
  
  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
}

public class Platform extends CollidableObject{
  private color c;
  
  public Platform(Game game, Polygon hitbox, PVector position, color c) {
    super(game, hitbox, position, null);
    this.c = c;
  }
  
  public void update(float dt) {
    
  }
  
  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
}

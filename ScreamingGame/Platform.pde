public class Platform extends CollidableObject{
  private color c;
  private Rect bounds;
  
  public Platform(Game game, Polygon hitbox, PVector position, Map<String, Animation> animations) {
    super(game, hitbox, position, animations);
    this.c = c;
    this.bounds = hitbox.getBounds();
  }
  
  public void update(float dt) {
    
  }
  
  public void display() {
    PImage cImage = getCurrentImage();
    //getHitbox().setFill(c);
    //shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
}

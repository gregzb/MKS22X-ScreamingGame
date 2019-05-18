public class Platform extends CollidableObject{
  private color c;
  
  public Platform(Polygon hitbox, PVector position, color c) {
    super(hitbox, position);
    this.c = c;
  }
  
  public void update() {
    
  }
  
  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
}

public class Player extends CollidableObject{
  private color c;
  
  public Player(Polygon hitbox, PVector position, color c) {
    super(hitbox, position);
    this.c = c;
  }
  
  public void update() {
    applyAcceleration();
    applyVelocity();
  }
  
  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
  
  public void moveRight() {
    
  }
  
  public void jump() {
    
  }
}

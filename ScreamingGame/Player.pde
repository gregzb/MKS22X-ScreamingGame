public class Player extends CollidableObject{
  private color c;
  
  public Player(World world, Polygon hitbox, PVector position, color c) {
    super(world, hitbox, position);
    this.c = c;
    
    setMaxVelocity(10);
    setAcceleration(new PVector(0, world.getGravity().y));
  }
  
  public void update() {
    applyAcceleration();
    applyVelocity();
    System.out.println("Pos: " + getPosition() + ", Vel: " + getVelocity() + ", Accel: " + getAcceleration());
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

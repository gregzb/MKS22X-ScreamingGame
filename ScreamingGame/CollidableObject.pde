public abstract class CollidableObject {
  private Polygon hitbox;
  private PVector position;
  private PVector velocity;
  private float maxVelocity;
  private PVector acceleration;
  
  public CollidableObject(Polygon hitbox, PVector position) {
    this(hitbox, position, new PVector(0, 0), new PVector(0, 0));
  }
  
  public CollidableObject(Polygon hitbox, PVector position, PVector velocity, PVector acceleration) {
    this.hitbox = hitbox;
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
  }
  
  public void setMaxVelocity(float maxVelocity) {
    this.maxVelocity = maxVelocity;
  }
  
  public float getMaxVelocity() {
    return maxVelocity;
  }
  
  public void setAcceleration(PVector acceleration) {
    this.acceleration = acceleration;
  }
  
  public PVector getAcceleration() {
    return acceleration;
  }
  
  public void setVelocity(PVector velocity) {
    this.velocity = velocity;
  }
  
  public PVector getVelocity() {
    return velocity;
  }
  
  public void applyAcceleration() {
    velocity.add(acceleration);
    
    if (velocity.mag() > maxVelocity) {
      velocity = velocity.normalize().mult(maxVelocity);
    }
  }
  
  public void applyVelocity() {
    position.add(velocity);
  }
  
  public PVector getPosition() {
    return position;
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public Polygon getHitbox() {
    return hitbox;
  }
  
  public abstract void update();
  public abstract void display();
}

public abstract class CollidableObject {
  Polygon hitbox;
  PVector position;
  PVector velocity;
  float maxVelocity;
  PVector acceleration;
  
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
  
  public abstract void update();
  public abstract void display();
}

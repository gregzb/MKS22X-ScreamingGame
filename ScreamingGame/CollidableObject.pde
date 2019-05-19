public abstract class CollidableObject {
  private Polygon hitbox;
  private PVector position;
  private PVector velocity;
  private PVector maxVelocity;
  private PVector acceleration;
  private Game game;
  
  public CollidableObject(Game game, Polygon hitbox, PVector position) {
    this(game, hitbox, position, new PVector(0, 0), new PVector(0, 0));
  }
  
  public CollidableObject(Game game, Polygon hitbox, PVector position, PVector velocity, PVector acceleration) {
    this.game = game;
    this.hitbox = hitbox;
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
  }
  
  public void setMaxVelocity(PVector maxVelocity) {
    this.maxVelocity = maxVelocity;
  }
  
  public PVector getMaxVelocity() {
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
    
    velocity.x = constrain(velocity.x, -maxVelocity.x, maxVelocity.x);
    velocity.y = constrain(velocity.y, -maxVelocity.y, maxVelocity.y);
    
    //if (velocity.mag() > maxVelocity) {
    //  velocity = velocity.normalize().mult(maxVelocity);
    //}
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
  
  public Game getGame() {
    return game;
  }
  
  public Polygon getTranslatedHitbox() {
    return new Polygon(getHitbox(), getPosition());
  }
  
  public abstract void update();
  public abstract void display();
}

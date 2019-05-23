public class Player extends CollidableObject{
  private color c;
  private PVector unstuckForce = null;
  
  Ray velocityRay;
  Ray[] groundRays;
  
  public Player(Game game, Polygon hitbox, PVector position, color c) {
    super(game, hitbox, position);
    this.c = c;
    
    PVector defaultDir = getVelocity().copy().normalize();
    if (defaultDir.mag() == 0) {
      defaultDir = new PVector(0, 1);
    }
    
    velocityRay = new Ray(hitbox.getCenter(), defaultDir, 30);
    
    groundRays = new Ray[2];
    groundRays[0] = new Ray(new PVector(0, 0), new PVector(0, 1), 3);
    PVector right = new PVector(0, hitbox.getCenter().x * 2);
    groundRays[1] = new Ray(right, new PVector(0, 1), 3);
    
    setMaxVelocity(new PVector(3, 9));
    setAcceleration(new PVector(0, getGame().getWorld().getGravity().y));
    
    System.out.println(velocityRay);
  }
  
  public void update() {
    
    if (isOnGround()) {
      getVelocity().y = 0;
    }
    
    if (getGame().keyDown(' ') && !getGame().prevKeyDown(' ') && isOnGround()) {
      PVector currentAccel = getAcceleration();
      setAcceleration(new PVector(currentAccel.x, -25));
    } else {
      setAcceleration(new PVector(0, getGame().getWorld().getGravity().y));
    }
    
    
    
    
    
    
    
    PVector newVel = getVelocity().copy();
    
    boolean movingHorizontal = false;
    
    if (getGame().keyDown('a') || getGame().keyDown('A')) {
      getAcceleration().x = -.2;
      movingHorizontal = true;
    }
    
    if (getGame().keyDown('d') || getGame().keyDown('D')) {
      getAcceleration().x = .2;
      movingHorizontal = true;
    }
    
    if (!movingHorizontal) {
      getAcceleration().x = 0;
      getVelocity().x *= isOnGround() ? .7 : .96;
    }
    
    //newVel.x = constrain(newVel.x, -3, 3);
    //setVelocity(newVel);
    

    
    
    
    
    
    
    applyAcceleration();
    
    applyVelocity();
    
    velocityRay.setDest(getVelocity().copy(), 30);
    
    
    
    
  
    newVel = getVelocity().copy();
    Polygon translatedHitbox = getTranslatedHitbox();
    
    unstuckForce = null;
        
    ArrayList<Platform> cObjects = getGame().getWorld().getPlatforms();
    for (CollidableObject cObject : cObjects) {
      if (cObject == this) continue;
      IntersectInfo intersection = translatedHitbox.intersects(cObject.getTranslatedHitbox());
      if (intersection.hasCollided()) {
        unstuckForce = intersection.getReverseForce();
      }
    }
        
    PVector pos = getPosition();
    if (unstuckForce != null) {
      setPosition(pos.copy().add(unstuckForce));
    }
    
    
    
    
    
    
    //System.out.println("Pos: " + getPosition() + ", Vel: " + getVelocity() + ", Accel: " + getAcceleration());
  }
  
  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
    
    //line(0, 0, 1000, 1000);
    
    stroke(0, 255, 0);
    strokeWeight(3);
    //fill(0, 255, 255);
    //new Ray(velocityRay, getPosition()).display();
    for (Ray r : groundRays) {
      new Ray(r, getPosition()).display();
    }
  }
  
  public void moveRight() {
    
  }
  
  public void jump() {
    
  }
  
  public boolean isOnGround() {
    return unstuckForce != null && unstuckForce.y < 0;
  }
  
}

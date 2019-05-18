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
    
    Polygon translatedPoints = new Polygon(getHitbox(), getPosition());
    
    PVector newVel = getVelocity().copy();
    
    if (keyPressed) {
      //System.out.println(key);
      if (key == 'a' || key == 'A') {
        newVel.x -= 2;
      } else if (key == 'd' || key == 'D') {
        newVel.x += 2;
      }
    } else {
      newVel.x = 0;
    }
    
    newVel.x = constrain(newVel.x, -3, 3);
    
    //System.out.println(newVel);
    
    ArrayList<Platform> cObjects = getWorld().getPlatforms();
    for (CollidableObject cObject : cObjects) {
      if (cObject == this) continue;
      Polygon translatedObject = new Polygon(cObject.getHitbox(), cObject.getPosition());
      IntersectInfo intersection = translatedPoints.intersects(translatedObject);
      if (intersection.hasCollided()) {
        //System.out.println(intersection);
        //System.out.println(cObject);
        PVector reverseForce = intersection.getReverseForce();
        
        //System.out.println(reverseForce);
        
        //setVelocity(reverseForce);
        int xSign = (int) Math.signum(reverseForce.x);
        int ySign = (int) Math.signum(reverseForce.y);
        
        int newXSign = (int) Math.signum(newVel.x);
        int newYSign = (int) Math.signum(newVel.y);
        
        if (xSign == newXSign || xSign == 0) {
          newVel.x = newXSign * max(abs(reverseForce.x), abs(newVel.x));
        } else {
          newVel.x = reverseForce.x;
        }
        if (ySign == newYSign || ySign == 0) {
          newVel.y = newYSign * max(abs(reverseForce.y), abs(newVel.y));
        } else {
          newVel.y = reverseForce.y;
        }
        //newVel = PVector.add(newVel, reverseForce);
      }
    }
    
    setVelocity(newVel);
    
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
  
  public boolean isOnGround() {
    return false;
  }
  
}

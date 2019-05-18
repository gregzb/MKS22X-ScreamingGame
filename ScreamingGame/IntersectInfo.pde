public class IntersectInfo {
  private boolean collided;
  private PVector reverseForce;
  public IntersectInfo(boolean collided, PVector reverseForce) {
    this.collided = collided;
    this.reverseForce = reverseForce;
  }
  
  public boolean hasCollided() {
    return collided;
  }
  
  public PVector getReverseForce() {
    return reverseForce;
  }
  
  public String toString() {
    return "Collide: " + collided + ", Force: " + getReverseForce();
  }
}

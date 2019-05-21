public class RaycastInfo {
  private boolean hit;
  private PVector hitLocation;
  private float t;
  public RaycastInfo(boolean hit, PVector hitLocation, float t) {
    this.hit = hit;
    this.hitLocation = hitLocation;
  }
  
  public boolean hasHit() {
    return hit;
  }
  
  public PVector getHitLocation() {
    return hitLocation;
  }
  
  public float getT() {
    return t;
  }
  
  public String toString() {
    return "Hit: " + hasHit() + ", HitLocation: " + getHitLocation() + ", t: " + getT();
  }
}

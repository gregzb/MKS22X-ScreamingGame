public class RaycastInfo implements Comparable<RaycastInfo>{
  private boolean hit;
  private PVector hitLocation;
  private float t;
  private Ray src;
  public RaycastInfo(boolean hit, PVector hitLocation, Ray src, float t) {
    this.hit = hit;
    this.src = src;
    this.hitLocation = hitLocation;
    this.t = t;
  }
  
  public boolean hasHit() {
    return hit;
  }
  
  public PVector getHitLocation() {
    return hitLocation;
  }
  
  public Ray getSrc() {
    return src;
  }
  
  public float getT() {
    return t;
  }
  
  public int compareTo(RaycastInfo rInfo) {
    //RaycastInfo other;
    return 0;
    
  }
  
  public String toString() {
    return "Hit: " + hasHit() + ", HitLocation: " + getHitLocation() + ", Ray: " + src +  ", t: " + getT();
  }
}

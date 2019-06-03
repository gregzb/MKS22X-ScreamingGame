public class RaycastInfo implements Comparable<RaycastInfo>{
  private boolean hit;
  private PVector hitLocation;
  private float t;
  private float tOther;
  private Ray src;
  public RaycastInfo(boolean hit, PVector hitLocation, Ray src, float t, float tOther) {
    this.hit = hit;
    this.src = src;
    this.hitLocation = hitLocation;
    this.t = t;
    this.tOther = tOther;
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
  
  public float getTOther() {
    return tOther;
  }
  
  public int compareTo(RaycastInfo rInfo) {
    //RaycastInfo other;
    return 0;
    
  }
  
  public String toString() {
    return "Hit: " + hasHit() + ", HitLocation: " + getHitLocation() + ", Ray: " + src +  ", t: " + getT();
  }
}

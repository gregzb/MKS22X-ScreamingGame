public class Ray {
  private PVector src;
  private PVector dest;
  
  public Ray(PVector src, PVector dir, float rayLength) {
    this.src = src.copy();
    PVector dirNormal = dir.copy().normalize();
    dirNormal.mult(rayLength);
    dest = PVector.add(src, dirNormal);
  }
  
  public Ray(PVector src, PVector dest) {
    this.src = src.copy();
    this.dest = dest.copy();
  }
  
  public ArrayList<RaycastInfo> raycast(Polygon p) {
    ArrayList<RaycastInfo> infos = new ArrayList<RaycastInfo>();
    Ray[] rays = p.getEdges();
    
    for (Ray ray : rays) {
      RaycastInfo raycastInfo = raycast(ray);
      if (raycastInfo.hasHit()) {
        infos.add(raycastInfo);
      }
    }
    
    return infos;
  }
  
  public RaycastInfo raycast(Ray r) {
    
  }
}

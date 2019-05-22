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
    float x1 = src.x;
    float x2 = dest.x;
    float x3 = r.src.x;
    float x4 = r.dest.x;
    
    float y1 = src.y;
    float y2 = dest.y;
    float y3 = r.src.y;
    float y4 = r.dest.y;
    
    float tANumer = ((y3 - y4) * (x1 - x3)) + ((x4 - x3) * (y1 - y3));
    float tBNumer = ((y1 - y2) * (x1 - x3)) + ((x2 - x1) * (y1 - y3)
    float denom = ((x4 - x3) * (y1 - y2)) - ((x1 - x2) * (y4 - y3));
    
    if (denom == 0) {
      return new RaycastInfo(false, null, 0);
    } else if (tANumer >= 0 && tANumer <= 1 && tBNumer >= 0 && tBNumer <= 1){
      PVector p1 = src.copy();
      PVector p2 = dest.copy();
      return new RaycastInfo(true, PVector.add(p1, PVector.multiply(PVector.subtract(p2, p1), tANumer)), tANumer);
    } else {
      return new RaycastInfo(false, PVector.add(p1, PVector.multiply(PVector.subtract(p2, p1), tANumer)), tANumer);
    }
  }
}

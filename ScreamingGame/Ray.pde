public class Ray {
  private PVector src;
  private PVector dest;
  
  public Ray(PVector src, PVector dir, float rayLength) {
    this.src = src.copy();
    PVector dirNormal = dir.copy().normalize();
    dirNormal.mult(rayLength);
    dest = PVector.add(src, dirNormal);
  }
  
  public void setDest(PVector dest) {
    this.dest = dest;
  }
  
  public void setDest(PVector dir, float rayLength) {
    PVector dirNormal = dir.copy().normalize();
    dirNormal.mult(rayLength);
    this.dest = PVector.add(src, dirNormal);
  }
  
  public void setSrc(PVector src) {
    this.src = src;
  }
  
  public PVector getSrc() {
    return src;
  }
  
  public PVector getDest() {
    return dest;
  }
  
  public String toString() {
    return "Src: " + src + ", Dest: " + dest;
  }
  
  public Ray(PVector src, PVector dest) {
    this.src = src.copy();
    this.dest = dest.copy();
  }
  
  public Ray(Ray r, PVector position) {
    this.src = PVector.add(r.src, position);
    this.dest = PVector.add(r.dest, position);
  }
  
  public ArrayList<RaycastInfo> raycast(Polygon p) {
    ArrayList<RaycastInfo> infos = new ArrayList<RaycastInfo>();
    Ray[] rays = p.getEdges();
    
    for (Ray ray : rays) {
      RaycastInfo raycastInfo = raycast(ray);
      //if (raycastInfo.hasHit()) {
        infos.add(raycastInfo);
      //}
      //infos.add(raycastInfo);
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
    float tBNumer = ((y1 - y2) * (x1 - x3)) + ((x2 - x1) * (y1 - y3));
    float denom = ((x4 - x3) * (y1 - y2)) - ((x1 - x2) * (y4 - y3));
    
    if (denom == 0) {
      return new RaycastInfo(false, null, this, -1, -1);
    } else {
      
      PVector p1 = src.copy();
      PVector p2 = dest.copy();
        
      float tA = tANumer / denom;
      float tB = tBNumer / denom;
      
      if (tA >= 0 && tA <= 1 && tB >= 0 && tB<= 1){
        return new RaycastInfo(true, PVector.add(p1, PVector.mult(PVector.add(p2, PVector.mult(p1, -1)), tA)), this, tA, tB);
      } else {
        return new RaycastInfo(false, PVector.add(p1, PVector.mult(PVector.add(p2, PVector.mult(p1, -1)), tA)), this, tA, tB);
      }
    }
  }
  
  void display() {
    line(src.x, src.y, dest.x, dest.y);
  }
}

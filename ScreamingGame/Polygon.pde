public class Polygon {
  private PVector[] points;
  private PShape myShape;
  
  public Polygon(PVector... points) {
    this.points = points;
    
    myShape = createShape();
    myShape.beginShape();
    for (PVector point : points) {
      myShape.vertex(point.x, point.y);
    }
    myShape.endShape();
  }
  
  public Polygon(Polygon p, PVector position) {
    
    this.points = new PVector[p.points.length];
    for (int i = 0; i < points.length; i++) {
      PVector oldVec = p.points[i];
      this.points[i] = new PVector(oldVec.x + position.x, oldVec.y + position.y);
    }
  }
  
  public Rect getBounds() {
    float bottom = Float.MIN_VALUE;
    float top = Float.MAX_VALUE;
    float left = Float.MAX_VALUE;
    float right = Float.MIN_VALUE;
    for (PVector p : points) {
      bottom = max(bottom, p.y);
      top = min(top, p.y);
      left = min(left, p.x);
      right = max(right, p.x);
    }
    return new Rect(new PVector(left, bottom), new PVector(right, top));
  }
  
  public PVector getCenter() {
    PVector total = new PVector();
    for(PVector point : points) {
      total.add(point);
    }
    total.div(points.length);
    return total;
  }
  
  public Ray[] getEdges() {
    Ray[] rays = new Ray[points.length];
    for(int i = 0; i < points.length; i++) {
      rays[i] = new Ray(points[i], points[(i+1)%points.length]);
    }
    return rays;
  }
  
  public PVector[] getAxes() {
    PVector[] axes = new PVector[points.length];
    for (int idx = 0; idx < points.length; idx++) {
      PVector pt1 = points[idx];
      PVector pt2 = points[(idx + 1) % points.length];
      PVector diff = pt1.copy().sub(pt2);
      PVector normal = new PVector(diff.y, -diff.x);
      normal.normalize();
      axes[idx] = normal;
    }
    return axes;
  }
  
  public float[] projectOntoAxis(PVector axis) {
    float minDot = axis.dot(points[0]);
    float maxDot = minDot;
    
    for (int i = 1; i < points.length; i++) {
      float value = axis.dot(points[i]);
      minDot = min(minDot, value);
      maxDot = max(maxDot, value);
    }
    return new float[] {minDot, maxDot};
  }
  
  public IntersectInfo intersects(Polygon p) {
    ArrayList<PVector> axes = new ArrayList<PVector>();
    for (PVector axis : getAxes()) axes.add(axis);
    for (PVector axis : p.getAxes()) axes.add(axis);
    
    PVector minAxis = null;
    float minOverlap = Float.MAX_VALUE;
    
    //System.out.println("All axes: " + axes);
    
    for (int i = 0; i < axes.size(); i++) {
      PVector axis = axes.get(i);
      float[] proj1 = projectOntoAxis(axis);
      float[] proj2 = p.projectOntoAxis(axis);
      
      //if (proj1[0] >= proj2[0] && proj1[0] <= proj2[1] 
      // || proj1[1] >= proj2[0] && proj1[1] <= proj2[1]
      // || proj2[0] >= proj1[0] && proj2[0] <= proj1[1]
      // || proj2[1] >= proj1[0] && proj2[1] <= proj1[1]) {
      //  //contains
      //} else {
      //  return new IntersectInfo(false, new PVector(0, 0));
      //}
      
      float A = min(proj1);
      float B = max(proj1);
      float C = min(proj2);
      float D = max(proj2);
      
      //System.out.println(i +", " + (B - C) + ", " + (D-A));
            
      if (B - C >= 0 && D-A >= 0) {
        float overlap = abs(max(A, C) - min(B, D));
        float overlapNotAbs = (max(A, C) - min(B, D));
        //System.out.println("idx: " + i + ", " + overlapNotAbs + ", " + max(A, C) + ", " + min(B, D));
        //System.out.println("A, B, C, D: " + A + ", " + B + ", " + C + ", " + D);
        //idx 1 and 3 are inverts of each other, but are same axis, how fix?
        if (overlap < minOverlap) {
          minOverlap = overlap;
          minAxis = axis;
        }
      } else {
        return new IntersectInfo(false, new PVector(0, 0));
      }
    }
    
    if (minAxis == null) {
      System.out.println("WHY IS THE MINIMUM AXIS NULL");
      System.exit(0);
    }
    
    //System.out.println("MIN: " + minAxis);
    
    minAxis.mult(minOverlap);
    
    PVector d = getCenter().copy().sub(p.getCenter());
    if (d.dot(minAxis) < 0) {
      minAxis.mult(-1);
    }
        
    return new IntersectInfo(true, minAxis);
  }
  
  public PShape getShape() {
    return myShape;
  }
  
  public void setFill(color c) {
    myShape.setFill(c);
  }
  
  public String toString() {
    String temp = "[";
    for(PVector point : points) {
      temp += point;
    }
    temp += "]";
    return temp;
  }
}

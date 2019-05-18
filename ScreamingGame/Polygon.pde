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
    
    for (PVector axis : axes) {
      float[] proj1 = projectOntoAxis(axis);
      float[] proj2 = projectOntoAxis(axis);
      
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
      
      if (B - C >= 0 && D-A >= 0) {
        float overlap = abs(max(A, C) - min(B, D));
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
    
    minAxis.mult(minOverlap);
    
    return new IntersectInfo(true, minAxis);
  }
  
  public PShape getShape() {
    return myShape;
  }
  
  public void setFill(color c) {
    myShape.setFill(c);
  }
}

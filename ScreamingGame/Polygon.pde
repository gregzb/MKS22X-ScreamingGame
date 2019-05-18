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
    
    // add more
    
    return new IntersectInfo(false, new PVector(0, 0));
  }
  
  public PShape getShape() {
    return myShape;
  }
  
  public void setFill(color c) {
    myShape.setFill(c);
  }
}

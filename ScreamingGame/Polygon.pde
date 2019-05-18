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
  public IntersectInfo intersects(Polygon p) {
    return new IntersectInfo(false, new PVector(0, 0));
  }
  
  public PShape getShape() {
    return myShape;
  }
  
  public void setFill(color c) {
    myShape.setFill(c);
  }
}

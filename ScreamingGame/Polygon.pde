public class Polygon {
  PVector[] points;
  public Polygon(PVector... points) {
    this.points = points;
  }
  public IntersectInfo intersects(Polygon p) {
    return new IntersectInfo(false, new PVector(0, 0));
  }
}

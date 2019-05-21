public class Ray {
  private PVector src;
  private PVector dir;
  private float rayLength;
  public Ray(PVector src, PVector dir, float rayLength) {
    this.src = src;
    this.dir = dir;
    this.rayLength = rayLength;
  }
}

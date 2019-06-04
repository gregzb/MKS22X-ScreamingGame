public class Rect {

  private PVector botLeft, topRight;

  public Rect(PVector botLeft, PVector topRight) {
    this.botLeft = botLeft;
    this.topRight = topRight;
  }

  public PVector getBotLeft() {
    return botLeft;
  }

  public PVector getTopRight() {
    return topRight;
  }
}

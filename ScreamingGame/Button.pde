public class Button extends CollidableObject {
  private Rect bounds;
  private PImage image;
  private String buttonName;
  private String text;
  private float tSize;

  private color tintColor = color(255, 255, 255);

  public Button(Game game, Polygon hitbox, PVector position, PImage image, String text, float tSize, String buttonName) {
    super(game, hitbox, position, null);
    this.image = image;
    this.bounds = hitbox.getBounds();
    this.buttonName = buttonName;
    this.text = text;
    this.tSize = tSize;
  }

  public void update(float dt) {
    if (mouseOver()) {
      if (mousePressed) {
        tintColor = color(195, 195, 195);
        getGame().buttonPressed(buttonName);
      } else {
        tintColor = color(225, 225, 225);
      }
    } else {
      tintColor = color(255, 255, 255);
    }
  }

  public boolean mouseOver() {
    return mouse.getTranslatedHitbox().intersects(getTranslatedHitbox()).hasCollided();
  }

  public void display() {
    //PImage cImage = getCurrentImage();
    tint(tintColor);

    pushMatrix();
    translate(getPosition().x, getPosition().y);
    image(image, 0, 0);
    textAlign(CENTER);
    textSize(tSize);
    fill(0);
    text(text, image.width/2, image.height/2 + 24);
    popMatrix();

    tint(color(255, 255, 255));

    //float boxWidth = bounds.getTopRight().x-bounds.getBotLeft().x;
    //float boxHeight = bounds.getBotLeft().y-bounds.getTopRight().y;

    //float xRepeats = (boxWidth/cImage.width);
    //float yRepeats = (boxHeight/cImage.height);

    //for (int y = 0; y < yRepeats; y++) {
    //  for (int x = 0; x < xRepeats; x++) {
    //    image(cImage, getPosition().x + (x * cImage.width), getPosition().y + (y * cImage.height));
    //  }
    //}

    //try handling portions of a block using scale

    //float extraX = xRepeats - floor(xRepeats);
    //float extraY = yRepeats - floor(yRepeats);

    //println(extraX);

    //PImage temp = resize()

    //image(cImage, getPosition().x + (floor(xRepeats) * cImage.width), getPosition().y + (floor(yRepeats) * cImage.height), 2, 2);

    //getHitbox().setFill(c);
    //shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }
}

public class Platform extends CollidableObject{
  private color c;
  private Rect bounds;
  
  public Platform(Game game, Polygon hitbox, PVector position, Map<String, Animation> animations) {
    super(game, hitbox, position, animations);
    this.c = c;
    this.bounds = hitbox.getBounds();
  }
  
  public void update(float dt) {
    
  }
  
  public float getWidth() {
    return bounds.getTopRight().x-bounds.getBotLeft().x;
  }
  
  public float getHeight() {
    return bounds.getBotLeft().y-bounds.getTopRight().y;
  }
  
  public void display() {
    PImage cImage = getCurrentImage();
    
    if (cImage == null) return;
    
    float xRepeats = (getWidth()/cImage.width);
    float yRepeats = (getHeight()/cImage.height);
    
    for (int y = 0; y < yRepeats; y++) {
      for (int x = 0; x < xRepeats; x++) {
        image(cImage, getPosition().x + (x * cImage.width) + bounds.getBotLeft().x, getPosition().y + (y * cImage.height) + bounds.getTopRight().y);
      }
    }
    
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

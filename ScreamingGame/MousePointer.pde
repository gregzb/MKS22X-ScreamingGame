public class MousePointer extends CollidableObject{
    
  public MousePointer(Game game) {
    super(game, new Polygon(new PVector(0, 0)), new PVector(mouseX, mouseY), null);
  }
  
  public void update(float dt) {
    setPosition(new PVector(mouseX, mouseY));
  }
  
  public void display() {
    
  }
}

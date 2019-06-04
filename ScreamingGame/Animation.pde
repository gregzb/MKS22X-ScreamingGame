public class Animation {
  
  private String name;
  PImage[] frames;
  float secPerFrame;
  
  public Animation(String name, PImage[] frames, float secPerFrame) {
    this.name = name;
    this.frames = frames;
    this.secPerFrame = secPerFrame;
  }
}

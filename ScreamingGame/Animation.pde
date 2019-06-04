public class Animation {
  
  private String name;
  private PImage[] frames;
  private float secPerFrame;
  
  private float currentFrame = 0;
  private float timeCounter = 0;
  
  public Animation(String name, PImage[] frames, float secPerFrame) {
    this.name = name;
    this.frames = frames;
    this.secPerFrame = secPerFrame;
  }
  
  public void update(float dt) {
    timeCounter += dt;
    while (timeCounter > secPerFrame) {
      timeCounter -= secPerFrame;
      currentFrame++;
      currentFrame%=frames.length;
    }
  }
  
  public PImage getCurrentImage() {
    return frames[currentFrame];
  }
  
  public float getSecPerFrame() {
    return secPerFrame;
  }
  
  public String getName() {
    return name;
  }
}

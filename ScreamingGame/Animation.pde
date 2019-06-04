public class Animation {
  
  private PImage[] frames;
  private float secPerFrame;
  
  private int currentFrame = 0;
  private float timeCounter = 0;
  
  public Animation(PImage[] frames, float secPerFrame) {
    this.frames = frames;
    this.secPerFrame = secPerFrame;
  }
  
  public Animation(Animation a) {
    frames = a.frames.clone();
    secPerFrame = a.secPerFrame;
    currentFrame = a.currentFrame;
    timeCounter = a.timeCounter;
  }
  
  public void resizeAnim(float newScale) {
    for (int i = 0; i < frames.length; i++) {
      frames[i] = Helper.scaleImage(p, frames[i], newScale);
    }
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
  
  public void restart() {
    currentFrame = 0;
  }
}

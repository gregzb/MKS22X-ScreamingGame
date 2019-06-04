public class Game {

  private AudioInputManager audioInManager;
  private World world;
  private Set<Character> keysDown;
  private Set<Character> prevKeysDown;

  private Polygon baseBounds;
  
  private float lastSecsRunning;

  PImage[] backgrounds = new PImage[5];

  public Game(Set<Character> keysDown) {
    audioInManager = new AudioInputManager(this);
    this.keysDown = keysDown;
    this.prevKeysDown = new HashSet<Character>(this.keysDown);

    world = new World(0);
    
    backgrounds = loadImages("gfx/backgrounds/plx-", ".png", 1, 1, 5);
    for (int i = 0; i < backgrounds.length; i++) {
      PImage img = backgrounds[i];
      backgrounds[i] = scaleImage(img, height/float(img.height));
    }
    
    Map<String, PImage[]> animations = new HashMap<String, PImage[]>();
    animations.put("idle", loadImages("gfx/character/idle/frame_", "_delay-0.1s.png", 0, 2, 12));
    animations.put("run", loadImages("gfx/character/run/frame_", "_delay-0.1s.png", 0, 1, 8));
    animations.put("jumpUp", loadImages("gfx/character/jump/jump-", ".png", 0, 2, 1));
    animations.put("jumpDown", loadImages("gfx/character/jump/jump-", ".png", 3, 2, 1));
    
    //Player p = new Player(this, new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), animations, true);
    //Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(21, 0), new PVector(21, 35), new PVector(0, 35)), new PVector(width/2, height/2), animations, true);
    Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(42, 0), new PVector(42, 70), new PVector(0, 70)), new PVector(width/2, height/2), animations, true);
    world.setPlayer(p);

    init();
  }

  PImage[] loadImages(String preName, String postName, int startNum, int lPad, int numImages) {
    PImage[] temp = new PImage[numImages];
    for (int i = 0; i < numImages; i++) {
      String lPadStr = "";
      for (int j = 0; j < lPad; j++) {
        lPadStr += "0";
      }
      String lPaddedNum = lPadStr.concat(String.valueOf(i + startNum));
      lPaddedNum = lPaddedNum.substring(lPaddedNum.length() - lPadStr.length());

      temp[i] = loadImage(preName + lPaddedNum + postName);
    }
    return temp;
  }
  
  //Taken from https://stackoverflow.com/questions/10119037/image-interpolation-nearest-neighbor-processing
  PImage scaleImage(PImage original, float newScale) {
    int scaledWidth = (int)(newScale*original.width);
    int scaledHeight = (int)(newScale*original.height);
    PImage out = createImage(scaledWidth, scaledHeight, RGB);
    original.loadPixels();
    out.loadPixels();
    for (int i = 0; i < scaledHeight; i++) {
      for (int j = 0; j < scaledWidth; j++) {
        int y = Math.min( round(i / newScale), original.height - 1 ) * original.width;
        int x = Math.min( round(j / newScale), original.width - 1 );
        out.pixels[(int)((scaledWidth * i) + j)] = original.pixels[(y + x)];
      }
    }
    return out;
  }

  public void init() {

    frameRate(60);
    
    lastSecsRunning = 0;

    int numPlatforms = 20;

    //plat1 = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-50, 25)), new PVector(width/2, height/2), color(10, 22, 100));
    //plat2 = new Platform(world, new Polygon(new PVector(-60, 20), new PVector(90, 40), new PVector(75, 60), new PVector(-75, 75)), new PVector(width/2, height/2), color(120, 200, 100));

    for (int i = 0; i < numPlatforms; i++) {
      Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      world.addPlatform(platform);
    }

    baseBounds = new Polygon(new PVector(0, 0), new PVector(width, 0), new PVector(width, height), new PVector(0, height));

    //Platform platform = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225, height - 100), color(40, 90, 230));
    //world.addPlatform(platform);
  }

  public void runLoop() {
    float secsRunning = millis() / 1000.0;
    float dt = lastSecsRunning-secsRunning;
    
    float pixelsPerSecond = 50;
    
    //println(frameRate);
    
    for (int i = 0; i < backgrounds.length; i++) {
      PImage img = backgrounds[i];
      pushMatrix();
      float translation = (i/4.0) * secsRunning * pixelsPerSecond;
      translate(-translation, 0);
      
      int baseNum = (int) (translation / img.width);
      
      image(img, img.width*baseNum, 0);
      image(img, img.width*(baseNum+1), 0);
      popMatrix();
    }
    
    pushMatrix();
    translate(-(secsRunning * pixelsPerSecond), 0);

    Polygon actualBounds = new Polygon(baseBounds, new PVector(secsRunning * pixelsPerSecond, 0));

    boolean playerInBounds = actualBounds.intersects(world.getPlayer().getTranslatedHitbox()).hasCollided();

    if (!playerInBounds) {
      System.out.println("PLAYER HAS DIED");
      System.exit(0);
    }

    //SET PLAYER ACCELERATION BASED ON SOUND
    audioInManager.update();
    if (audioInManager.getAmplitude() >= .3) {
      println("Vol: " + audioInManager.getAmplitude() + ", Pitch: " + audioInManager.getPitch());
    }

    //world.getPlayer().setAcceleration(audioInManager.getAcceleration());
    //println(world.getPlayer().getPosition());

    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update();
    }
    for (CollidableObject cObject : cObjects) {
      cObject.display();
    }
    //plat1.update();
    //plat2.update();
    //plat1.display();
    //plat2.display();

    //System.out.println(plat1.getHitbox().intersects(plat2.getHitbox()));

    popMatrix();

    this.prevKeysDown = new HashSet<Character>(this.keysDown);
    lastSecsRunning = secsRunning;
  }

  public World getWorld() {
    return world;
  }

  public AudioInputManager getAudioInputManager() {
    return audioInManager;
  }

  public boolean keyDown(Character keyD) {
    return keysDown.contains(keyD);
  }

  public boolean prevKeyDown(Character keyD) {
    return prevKeysDown.contains(keyD);
  }
}

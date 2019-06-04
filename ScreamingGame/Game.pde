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

    backgrounds = Helper.loadImages(p, "gfx/backgrounds/plx-", ".png", 1, 1, 5);
    for (int i = 0; i < backgrounds.length; i++) {
      PImage img = backgrounds[i];
      backgrounds[i] = Helper.scaleImage(p, img, height/float(img.height));
    }

    Map<String, Animation> animations = new HashMap<String, Animation>();
    animations.put("idle", new Animation(Helper.loadImages(p, "gfx/character/idle/frame_", "_delay-0.1s.png", 0, 2, 12), 0.1));
    animations.put("run", new Animation(Helper.loadImages(p, "gfx/character/run/frame_", "_delay-0.1s.png", 0, 1, 8), 0.1));
    animations.put("jumpUp", new Animation(Helper.loadImages(p, "gfx/character/jump/jump-", ".png", 0, 2, 1), 0.1));
    animations.put("jumpDown", new Animation(Helper.loadImages(p, "gfx/character/jump/jump-", ".png", 3, 2, 1), 0.1));

    for (String animKey : animations.keySet()) {
      animations.get(animKey).resizeAnim(2);
    }

    //Player p = new Player(this, new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), animations, true);
    //Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(21, 0), new PVector(21, 35), new PVector(0, 35)), new PVector(width/2, height/2), animations, true);
    Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(42, 0), new PVector(42, 70), new PVector(0, 70)), new PVector(width/2, height/2), animations, false);
    world.setPlayer(p);

    init();
  }

  public void init() {

    frameRate(60);

    lastSecsRunning = 0;

    int numPlatforms = 20;

    //plat1 = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-50, 25)), new PVector(width/2, height/2), color(10, 22, 100));
    //plat2 = new Platform(world, new Polygon(new PVector(-60, 20), new PVector(90, 40), new PVector(75, 60), new PVector(-75, 75)), new PVector(width/2, height/2), color(120, 200, 100));

    for (int i = 0; i < numPlatforms; i++) {
      //Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      Map<String, Animation> brick = new HashMap<String, Animation>();
      brick.put("defult", new Animation(Helper.loadImages(p, "gfx/tiles/brick.png", "", 0, 0, 1), 1));
      for (String animKey : brick.keySet()) {
        brick.get(animKey).resizeAnim(2);
      }
      
      Map<String, Animation> crate = new HashMap<String, Animation>();
      crate.put("defult", new Animation(Helper.loadImages(p, "gfx/tiles/crate.png", "", 0, 0, 1), 1));
      for (String animKey : crate.keySet()) {
        crate.get(animKey).resizeAnim(2);
      }
      //Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), brick);
      
      Map<String, Animation> anim = crate;
      
      if (random(1) < 0.5) {
        anim = brick;
      } else {
        anim = crate;
      }
      
      Platform platform = new Platform(this, new Polygon(new PVector(0, 0), new PVector(160, 0), new PVector(160, 64), new PVector(0, 64)), new PVector(0 + 250 * i, height - 100), anim);
      world.addPlatform(platform);
    }

    baseBounds = new Polygon(new PVector(0, 0), new PVector(width, 0), new PVector(width, height), new PVector(0, height));

    //Platform platform = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225, height - 100), color(40, 90, 230));
    //world.addPlatform(platform);
  }

  public void runLoop() {
    float secsRunning = millis() / 1000.0;
    float dt = secsRunning-lastSecsRunning;

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

    world.getPlayer().setAcceleration(audioInManager.getAcceleration());
    //println(world.getPlayer().getPosition());

    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update(dt);
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

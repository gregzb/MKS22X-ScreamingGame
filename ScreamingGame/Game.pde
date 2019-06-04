public MousePointer mouse;

public PFont pixelArtFont;

public class Game {

  private AudioInputManager audioInManager;
  private World world;
  private Set<Character> keysDown;
  private Set<Character> prevKeysDown;

  private Polygon baseBounds;
  private Platform wall;

  private float lastSecsRunning;

  private String gameState;
  private String nextGameState;

  private float gameTimer = 0;

  PImage[] backgrounds = new PImage[5];

  PImage buttonImage;
  Button[] difficulties;

  private int highScore;
  private int scoreLastFrame;
  private float lerpFactor;

  private boolean paused;
  private float basePixelsPerSecond = 60;

  final boolean USING_KEYBOARD = true;

  public void setGameState(String gameState) {
    nextGameState = gameState;
  }

  public String getGameState() {
    return gameState;
  }

  public Game(Set<Character> keysDown) {
    audioInManager = new AudioInputManager(this);
    this.keysDown = keysDown;
    this.prevKeysDown = new HashSet<Character>(this.keysDown);

    mouse = new MousePointer(this);
    //https://www.1001fonts.com/arcadeclassic-font.html
    //https://www.dafont.com/arcade-ya.font
    pixelArtFont = createFont("ARCADE_N.TTF", 128);
    textFont(pixelArtFont);



    buttonImage = scaleImage(loadImage("gfx/button.png"), 6);
    difficulties = new Button[3];
    difficulties[0] = new Button(this, new Polygon(new PVector(0, 0), new PVector(buttonImage.width, 0), new PVector(buttonImage.width, buttonImage.height), new PVector(0, buttonImage.height)), new PVector(width/2 - (buttonImage.width/2), height/2 - (buttonImage.height/2) - 25), buttonImage, "Easy", 42, "easy");
    difficulties[1] = new Button(this, new Polygon(new PVector(0, 0), new PVector(buttonImage.width, 0), new PVector(buttonImage.width, buttonImage.height), new PVector(0, buttonImage.height)), new PVector(width/2 - (buttonImage.width/2), height/2 - (buttonImage.height/2) + 75), buttonImage, "Medium", 30, "medium");
    difficulties[2] = new Button(this, new Polygon(new PVector(0, 0), new PVector(buttonImage.width, 0), new PVector(buttonImage.width, buttonImage.height), new PVector(0, buttonImage.height)), new PVector(width/2 - (buttonImage.width/2), height/2 - (buttonImage.height/2) + 175), buttonImage, "Hard", 42, "hard");



    world = new World(0);

    backgrounds = loadImages("gfx/backgrounds/plx-", ".png", 1, 1, 5);
    for (int i = 0; i < backgrounds.length; i++) {
      PImage img = backgrounds[i];
      backgrounds[i] = scaleImage(img, height/float(img.height));
    }

    Map<String, Animation> animations = new HashMap<String, Animation>();
    animations.put("idle", new Animation(loadImages("gfx/character/idle/frame_", "_delay-0.1s.png", 0, 2, 12), 0.1));
    animations.put("run", new Animation(loadImages("gfx/character/run/frame_", "_delay-0.1s.png", 0, 1, 8), 0.1));
    animations.put("jumpUp", new Animation(loadImages("gfx/character/jump/jump-", ".png", 0, 2, 1), 0.1));
    animations.put("jumpDown", new Animation(loadImages("gfx/character/jump/jump-", ".png", 3, 2, 1), 0.1));

    for (String animKey : animations.keySet()) {
      animations.get(animKey).resizeAnim(2);
    }

    //Player p = new Player(this, new Polygon(new PVector(-10, -15), new PVector(10, -15), new PVector(10, 15), new PVector(-10, 15)), new PVector(width/2, height/2), animations, true);
    //Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(21, 0), new PVector(21, 35), new PVector(0, 35)), new PVector(width/2, height/2), animations, true);
    Player p = new Player(this, new Polygon(new PVector(0, 0), new PVector(42, 0), new PVector(42, 70), new PVector(0, 70)), new PVector(width/2, height/2), animations, USING_KEYBOARD);
    world.setPlayer(p);

    init();
  }

  public void setHighScore(int highScore) {
    this.highScore = min(999, max(0, highScore));
  }

  public int getHighScore() {
    return highScore;
  }

  public void init() {

    frameRate(60);

    gameState = "menu";
    nextGameState = gameState;

    lastSecsRunning = 0;

    baseBounds = new Polygon(new PVector(0, 0), new PVector(width + 10, 0), new PVector(width + 10, height), new PVector(0, height));

    wall = new Platform(this, new Polygon(new PVector(width, 0), new PVector(width + 100, 0), new PVector(width + 100, height), new PVector(width, height)), new PVector(0, 0), null);
    world.addPlatform(wall);

    int numPlatforms = 20;

    //plat1 = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-50, 25)), new PVector(width/2, height/2), color(10, 22, 100));
    //plat2 = new Platform(world, new Polygon(new PVector(-60, 20), new PVector(90, 40), new PVector(75, 60), new PVector(-75, 75)), new PVector(width/2, height/2), color(120, 200, 100));

    PImage[] brickImage = loadImages("gfx/tiles/brick.png", "", 0, 0, 1);
    brickImage[0] = scaleImage(brickImage[0], 2);

    PImage[] crateImage = loadImages("gfx/tiles/crate.png", "", 0, 0, 1);
    crateImage[0] = scaleImage(crateImage[0], 2);

    for (int i = 0; i < numPlatforms; i++) {

      //Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), color(40, 90, 230));
      Map<String, Animation> brick = new HashMap<String, Animation>();
      brick.put("defult", new Animation(brickImage, 1));

      Map<String, Animation> crate = new HashMap<String, Animation>();
      crate.put("defult", new Animation(crateImage, 1));
      //Platform platform = new Platform(this, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225 * i, height - 100), brick);

      Map<String, Animation> anim = crate;

      if (random(1) < 0.5) {
        anim = brick;
      }

      int l = ((int)(Math.random() * 3)) * 32 + 32;
      int r = -(((int)(Math.random() * 3)) * 32 + 32);
      Platform platform = new Platform(this, new Polygon(new PVector(r, -32), new PVector(l, -32), new PVector(l, 32), new PVector(r, 32)), new PVector(l - r + 225 * i, height - 100), anim);
      world.addPlatform(platform);
    }

    //Platform platform = new Platform(world, new Polygon(new PVector(-100, -25), new PVector(100, -25), new PVector(100, 25), new PVector(-100, 25)), new PVector(100 + 225, height - 100), color(40, 90, 230));

    //Platform platform = new Platform(world, new Polygon(new PVector(-75, -25), new PVector(75, -25), new PVector(75, 25), new PVector(-75, 25)), new PVector(100 + 225, height - 100), color(40, 90, 230));
    //world.addPlatform(platform);
  }

  public void runLoop() {
    float secsRunning = millis() / 1000.0;
    float dt = secsRunning-lastSecsRunning;

    if (gameState.equals("menu")) {
      menuLoop(secsRunning, dt);
    } else if (gameState.equals("game")) {
      gameLoop(secsRunning, dt);
    }

    this.prevKeysDown = new HashSet<Character>(this.keysDown);
    lastSecsRunning = secsRunning;
    gameState = nextGameState;

    //println(frameRate);
  }

  public void beginGame() {
    gameTimer = 0;
    setGameState("game");
    world.getPlayer().setPosition(new PVector(width/2, height/2));
    world.getPlayer().setAcceleration(new PVector(0, 0));
    world.getPlayer().setVelocity(new PVector(0, 0));
    paused = false;
  }

  public void buttonPressed(String buttonName) {
    if (buttonName.equals("easy")) {
      world.setDifficulty(0);
      beginGame();
    } else if (buttonName.equals("medium")) {
      world.setDifficulty(1);
      beginGame();
    } else if (buttonName.equals("hard")) {
      world.setDifficulty(2);
      beginGame();
    }
  }


  public void menuLoop(float secsRunning, float dt) {
    color col1 = color(102, 240, 242);
    color col2 = color(92, 162, 232);
    background(lerpColor(col1, col2, (sin(secsRunning) + 1) / 2));
    mouse.update(dt);
    
    fill(255);
    
    textSize(64);
    text("Urlando", width/2, 80);
    
    fill(0);
    textSize(40);
    text("High Score:", width/2, 150);

    textSize(50);
    text(leftPad(3, String.valueOf(getHighScore())), width/2, 200);

    textSize(20);
    fill(210, 0, 0);
    text("Made by group AAAAAAAAHHH", width/2, height - 40);
    //fill(0);
    text("Greg Zborovsky and Emma Choi", width/2, height - 15);

    //b.update(dt);
    //b.display();
    for (Button b : difficulties) {
      b.update(dt);
      b.display();
    }
  }

  public void gameLoop(float secsRunning, float dt) {

    if (keyDown('p') && !prevKeyDown('p')) {
      paused = !paused;
    }

    if (paused) {
      textSize(90);
      color col1 = color(180, 20, 0);
      color col2 = color(220, 0, 20);
      fill(lerpColor(col1, col2, (sin(secsRunning * 10) + 1) / 2));
      text("PAUSED", width/2, height/2);
      return;
    }
    
    float pixelsPerSecond = basePixelsPerSecond + (world.getDifficulty() * 50);

    gameTimer += dt;

    for (int i = 0; i < backgrounds.length; i++) {
      PImage img = backgrounds[i];
      pushMatrix();
      float translation = (i/4.0) * gameTimer * pixelsPerSecond;
      translate(-translation, 0);

      int baseNum = (int) (translation / img.width);

      image(img, img.width*baseNum, 0);
      image(img, img.width*(baseNum+1), 0);
      popMatrix();
    }

    lerpFactor -= dt * 2.3;

    int highScore = getHighScore();
    println(((world.getDifficulty() + 1) / 12.0 + 1));
    int score = (int) (((gameTimer * pixelsPerSecond) / 100) * ((world.getDifficulty() + 1) / 12.0 + 1));

    if (score != scoreLastFrame) {
      lerpFactor = 1.3;
    }

    scoreLastFrame = score;
    setHighScore(max(score, highScore));

    color regColor = color(0);
    color scoreUp = color(0, 160, 34);

    textSize(60);
    fill(lerpColor(regColor, scoreUp, constrain(lerpFactor, 0, 1)));
    text(leftPad(3, String.valueOf(score)), width/2, 75);

    pushMatrix();
    translate(-(gameTimer * pixelsPerSecond), 0);

    Polygon actualBounds = new Polygon(baseBounds, new PVector(gameTimer * pixelsPerSecond, 0));

    boolean playerInBounds = actualBounds.intersects(world.getPlayer().getTranslatedHitbox()).hasCollided();

    wall.setPosition(new PVector(gameTimer * pixelsPerSecond, 0));

    if (!playerInBounds) {
      System.out.println("PLAYER HAS DIED");
      setGameState("menu");
    }

    //SET PLAYER ACCELERATION BASED ON SOUND
    audioInManager.update();
    if (audioInManager.getAmplitude() >= .3) {
      println("Vol: " + audioInManager.getAmplitude() + ", Pitch: " + audioInManager.getPitch());
    }

    if (!USING_KEYBOARD) {
      world.getPlayer().setAcceleration(audioInManager.getAcceleration());
    }

    ArrayList<CollidableObject> cObjects = world.getCollidableObjects();
    for (CollidableObject cObject : cObjects) {
      cObject.update(dt);
    }
    for (CollidableObject cObject : cObjects) {
      cObject.display();
    }

    popMatrix();
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

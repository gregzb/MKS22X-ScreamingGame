public class Player extends CollidableObject {
  private PVector unstuckForce = null;
  private boolean useKeys;

  private int lastFacing = 1;

  public Player(Game game, Polygon hitbox, PVector position, Map<String, Animation> animations, boolean useKeys) {
    super(game, hitbox, position, animations);
    this.useKeys = useKeys;

    setMaxVelocity(new PVector(3, 9));
    setAcceleration(new PVector(0, getGame().getWorld().getGravity().y));

    playAnimation("idle");
  }

  public void update(float dt) {

    if (isOnGround()) {
      getVelocity().y = 0;
    }


    if (useKeys) {

      if (getGame().keyDown(' ') && !getGame().prevKeyDown(' ') && isOnGround()) {
        PVector currentAccel = getAcceleration();
        setAcceleration(new PVector(currentAccel.x, -25));
      } else {
        setAcceleration(new PVector(getAcceleration().x, getGame().getWorld().getGravity().y));
      }


      boolean movingHorizontal = false;

      if (getGame().keyDown('a') || getGame().keyDown('A')) {
        getAcceleration().x = -.2;
        movingHorizontal = true;
      }

      if (getGame().keyDown('d') || getGame().keyDown('D')) {
        getAcceleration().x = .2;
        movingHorizontal = true;
      }

      if (!movingHorizontal) {
        getAcceleration().x = 0;
        getVelocity().x *= isOnGround() ? .7 : .96;
      }
    } else {
      getVelocity().x *= isOnGround() ? .7 : .96;
    }
    
    if (abs(getAcceleration().x) > 0.02) {
      playAnimation("run");
    } else {
      playAnimation("idle");
    }
    
    if (!isOnGround()) {
      if (getVelocity().y < 0) {
        playAnimation("jumpUp");
      } else {
        playAnimation("jumpDown");
      }
    }


    applyAcceleration();
    applyVelocity();


    Polygon translatedHitbox = getTranslatedHitbox();

    unstuckForce = null;

    ArrayList<Platform> cObjects = getGame().getWorld().getPlatforms();
    for (CollidableObject cObject : cObjects) {
      if (cObject == this) continue;
      IntersectInfo intersection = translatedHitbox.intersects(cObject.getTranslatedHitbox());
      if (intersection.hasCollided()) {
        unstuckForce = intersection.getReverseForce();
      }
    }

    PVector pos = getPosition();
    if (unstuckForce != null) {
      setPosition(pos.copy().add(unstuckForce));
    }

    updateAnimation(dt);
  }

  public void display() {
    //getHitbox().setFill(c);
    //shape(getHitbox().getShape(), getPosition().x, getPosition().y);
    PImage currImage = getCurrentImage();
    PVector currAccel = getAcceleration();

    if (currAccel.x != 0) {
      lastFacing = (int) (currAccel.x / abs(currAccel.x));
    }

    pushMatrix();
    translate(getPosition().x-(currImage.width * ((lastFacing - 1) * 1/2.0)), getPosition().y);
    scale(lastFacing, 1); // You had it right!
    image(currImage, 0, 0);
    popMatrix();
  }

  public boolean isOnGround() {
    return unstuckForce != null && unstuckForce.y < 0;
  }
}

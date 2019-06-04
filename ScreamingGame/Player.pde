public class Player extends CollidableObject {
  private color c;
  private PVector unstuckForce = null;
  private boolean useKeys;

  public Player(Game game, Polygon hitbox, PVector position, color c, boolean useKeys) {
    super(game, hitbox, position);
    this.c = c;
    this.useKeys = useKeys;

    setMaxVelocity(new PVector(3, 9));
    setAcceleration(new PVector(0, getGame().getWorld().getGravity().y));
  }

  public void update() {

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
      //setAcceleration(new PVector(getAcceleration().x, getGame().getWorld().getGravity().y));
      getVelocity().x *= isOnGround() ? .7 : .96;
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
  }

  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);
  }

  public boolean isOnGround() {
    return unstuckForce != null && unstuckForce.y < 0;
  }
}

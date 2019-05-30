public class Player extends CollidableObject {
  private color c;
  private PVector unstuckForce = null;
  private boolean useKeys;

  Ray velocityRay;
  Ray[] groundRays;

  public Player(Game game, Polygon hitbox, PVector position, color c, boolean useKeys) {
    super(game, hitbox, position);
    this.c = c;
    this.useKeys = useKeys;

    PVector defaultDir = getVelocity().copy().normalize();
    if (defaultDir.mag() == 0) {
      defaultDir = new PVector(0, 1);
    }

    velocityRay = new Ray(hitbox.getCenter(), defaultDir, 30);

    Rect bounds = hitbox.getBounds();

    PVector left = new PVector(bounds.getBotLeft().x, bounds.getBotLeft().y);
    PVector right = new PVector(bounds.getTopRight().x, bounds.getBotLeft().y);

    groundRays = new Ray[2];
    groundRays[0] = new Ray(left, new PVector(0, 1), 1);
    groundRays[1] = new Ray(right, new PVector(0, 1), 1);

    setMaxVelocity(new PVector(3, 9));
    setAcceleration(new PVector(0, getGame().getWorld().getGravity().y));

    System.out.println(velocityRay);
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







      //PVector newVel = getVelocity().copy();

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

    //newVel.x = constrain(newVel.x, -3, 3);
    //setVelocity(newVel);








    applyAcceleration();
    
    velocityRay.setDest(getVelocity().copy(), 1000);
    
    ArrayList<Platform> cObjects = getGame().getWorld().getPlatforms();
    for (CollidableObject cObject : cObjects) {
      if (cObject == this) continue;
      ArrayList<RaycastInfo> rInfo = new Ray(velocityRay, getPosition()).raycast(cObject.getTranslatedHitbox());
      if (rInfo.size() > 1) {
        println(rInfo);
      }
      if (rInfo.size() > 0) {
        RaycastInfo info = rInfo.get(0);
        //setVelocity(geinfo.getT());
        //System.out.println(rInfo.size() + ", " + info.getT());
        getVelocity().mult(info.getT());
      }
    }
    
    applyVelocity();




    //PVector newVel = getVelocity().copy();
    //Polygon translatedHitbox = getTranslatedHitbox();

    //unstuckForce = null;

    //ArrayList<Platform> cObjects = getGame().getWorld().getPlatforms();
    //for (CollidableObject cObject : cObjects) {
    //  if (cObject == this) continue;
    //  IntersectInfo intersection = translatedHitbox.intersects(cObject.getTranslatedHitbox());
    //  if (intersection.hasCollided()) {
    //    unstuckForce = intersection.getReverseForce();
    //  }
    //}

    //PVector pos = getPosition();
    //if (unstuckForce != null) {
    //  setPosition(pos.copy().add(unstuckForce));
    //}






    //System.out.println("Pos: " + getPosition() + ", Vel: " + getVelocity() + ", Accel: " + getAcceleration());
  }

  public void display() {
    getHitbox().setFill(c);
    shape(getHitbox().getShape(), getPosition().x, getPosition().y);

    //line(0, 0, 1000, 1000);

    stroke(0, 255, 0);
    strokeWeight(3);
    //fill(0, 255, 255);
    new Ray(velocityRay, getPosition()).display();

    // println(isOnGround());

    for (Ray r : groundRays) {
      new Ray(r, getPosition()).display();
    }
  }

  public void moveRight() {
  }

  public void jump() {
  }

  public boolean old_isOnGround() {
    return unstuckForce != null && unstuckForce.y < 0;
  }

  public boolean isOnGround() {
    boolean intersects = false;
    Polygon translatedHitbox = getTranslatedHitbox();
    for (Ray r : groundRays) {
      ArrayList<Platform> cObjects = getGame().getWorld().getPlatforms();
      for (CollidableObject cObject : cObjects) {
        if (cObject == this) continue;
        ArrayList<RaycastInfo> infos = new Ray(r, getPosition()).raycast(cObject.getTranslatedHitbox());
        if (infos.size() > 0) intersects = true;
        //IntersectInfo intersection = translatedHitbox.intersects(cObject.getTranslatedHitbox());
        //if (intersection.hasCollided()) {
        //  unstuckForce = intersection.getReverseForce();
        //}
      }
    }
    return intersects;
  }
}

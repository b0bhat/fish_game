class Enemy {
  PVector pos, vel, dim;
  int currentFrame = 0;
  PImage[] animated = new PImage[4]; 
  float angle = random(0,2*PI);
  int dir = 3;
  int size = int(random(1,4));
  int i = 1;
  int timer = 0;
  
  Enemy(PVector pos) {
    this.pos = pos;
    vel = new PVector();
    dim = new PVector(60, 60);
    
    for (int i = 0; i < animated.length; i++) {
      animated[i] = loadImage("puffer" + i + ".png");
    }
  }
  
  boolean inWindow(Character c) {
    PVector diff = PVector.sub(c.pos, pos);
    PVector absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
  
  void update(Character c) {
    PVector diff = PVector.sub(c.pos, pos);
    PVector absDiff = new PVector(abs(diff.x), abs(diff.y));
    pos.add(vel);
    
    /* PLAYER TRACKING */
    
    if (absDiff.x < 250 && absDiff.y < 250 && !c.invis && timer < 1) {
      vel.set(PVector.fromAngle(atan2(c.pos.y- pos.y, c.pos.x-pos.x)).mult(5 + score.coins));
    } else {
      angle += 0.04 * dir; 
      if ( random(0, 16) < 1) {
        dir *= -1;
      }
      vel.set((10+3*score.coins)* cos(angle), (10+3*score.coins)* sin(angle));
    }
   
    if (frameCount % 1 == 0) {
      currentFrame++;
        if (currentFrame == animated.length) {
          currentFrame = 0;
        }
      }
  }
  
  /* COLLISIONS */
  
  boolean hitCharacter(Character other) {
    if (timer < 1 && !other.invis) {
      if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < 80) {
        timer = 30;
        if ( boing.position() == boing.length() ) boing.rewind();
        boing.play();
        return true;
      }
  } 
  timer += -1;
  return false;
  }
  
  void bump(Character other) {
      float ang = atan2(pos.y - other.pos.y, pos.x - other.pos.x);
      float avgSpeed = (vel.mag() + other.vel.mag())/2;
      vel.x = avgSpeed * 2*cos(ang);
      vel.y = avgSpeed * 2*sin(ang);
      other.vel.x = avgSpeed * 2*cos(ang - PI);
      other.vel.y = avgSpeed * 2*sin(ang - PI);
      angle += PI;
      score.life += -1;
  }
  
  void drawMe(Character c) {
    pushMatrix();
    if (size > 5) i = -1;
    if (size < 1) i = 1;
    size += i;
    translate( pos.x -c.pos.x + width/2, pos.y -c.pos.y + height/2);
    scale(0.9 + 0.02*size);
    PImage img = animated[currentFrame];
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
}

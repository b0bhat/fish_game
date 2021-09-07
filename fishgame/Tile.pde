class Tile {
  PVector pos, diff, absDiff;
  PImage img;
  boolean block;
  int type;
  float rotate;
  int timer;
  PImage old;
  
  Tile(String path, PVector pos, boolean block, int type) {
    img = loadImage(path);
    this.pos = pos;
    this.block = block;
    this.type = type;
    timer = 0;
    if (type != 1) rotate = random(0,3);
  }
  
  void popbubble() {
    if (type == 2) {
      if (timer > 300) {
        type = 1;
        img = old;
        block = true;
        timer = 0;
      } else if (timer == 0) {
          old = img;
          img = loadImage("popped.png");
          block = false;
          timer++;
      } else {
        timer++;
      }
    }
  }
  
  void collision(Character c) {
    if ( boing.position() == boing.length() ) boing.rewind();
    boing.play();
    diff = PVector.sub(c.pos, pos);
     c.pos.x += diff.x*0.02;
     c.pos.y += diff.y*0.02;
     float angle = atan2(pos.y - c.pos.y, pos.x - c.pos.x);
     float avgSpeed = c.vel.mag()*0.7;
     c.vel.x = avgSpeed * cos(angle - PI);
     c.vel.y = avgSpeed * sin(angle - PI);
    }
  
  boolean checkCollision(Character c) {
    diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    
    if (block && 
     absDiff.x < c.dim.x / 2 + img.width / 2 && 
     absDiff.y < c.dim.y / 2 + img.height / 2) {
       return true;
     } else {
       return false;}
  }
  
  boolean checkCollisionEnemy(Enemy c) {
    diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    
    if (block && type != 1 &&
     absDiff.x < c.dim.x / 2 + img.width / 2 && 
     absDiff.y < c.dim.y / 2 + img.height / 2) {
       return true;
     } else {
       return false;}
  }
  
  void collisionEnemy(Enemy c) {
    diff = PVector.sub(c.pos, pos);
     c.pos.x += diff.x*0.02;
     c.pos.y += diff.y*0.02;
     float angle = atan2(pos.y - c.pos.y, pos.x - c.pos.x);
     float avgSpeed = c.vel.mag()*0.7;
     c.vel.x = avgSpeed * cos(angle - PI);
     c.vel.y = avgSpeed * sin(angle - PI);
     c.angle += PI;
    }
  
  boolean inWindow(Character c) {
    diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
  
  void drawMe(Character c) {
    pushMatrix();
    translate( pos.x -c.pos.x + width/2, pos.y -c.pos.y + height/2);
    if (rotate < 1) rotate(PI/2);
    else if (rotate > 2) rotate(-PI/2);
    else if (1 < rotate && rotate < 2) rotate(0); 
    
    scale(1.04, 1.04);
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
  
}

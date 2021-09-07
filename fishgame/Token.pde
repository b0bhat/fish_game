class Token {
  PVector pos, diff, absDiff;
  PImage img;
  int currentFrame = 0;
  int timer;
  PImage[] animated = new PImage[3]; 
  
  Token(PVector pos) {
    this.pos = pos;
    timer = 0;
   
  }
  
  boolean inWindow() {
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
  
  void update() {
    timer++;
    if (frameCount % 2 == 0) {
      currentFrame++;
        if (currentFrame == animated.length) {
          currentFrame = 0;
        }
    }
  }
  
  void drawMe(Character c) {
    pushMatrix();
    translate( pos.x -c.pos.x + width/2, pos.y -c.pos.y + height/2);
    PImage img = animated[currentFrame];
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }
  
}

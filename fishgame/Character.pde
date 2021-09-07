class Character {
  PVector pos, vel, dim;
  int currentFrame = 0;
  PImage[] floating = new PImage[5]; 
  PImage[] frames;
  int tint = 0;
  boolean invis = false;
  
  Character(PVector pos) {
    this.pos = pos;
    vel = new PVector();
    frames = floating;
    dim = new PVector(50, 40);
    
    for (int i = 0; i < floating.length; i++) {
      floating[i] = loadImage("fishy" + i + ".png");
    }
  }
  
  void changeFrame(PImage[]list) {
    frames = list;
  }
  
  void move(PVector acc) {
    vel.add(acc);
  }
  
  void update() {
    vel.mult(0.95);
    vel.y += 0.2;
    pos.add(vel);
    if (invis && tint < 1) invis = false;
    if (frameCount % 1 == 0) {
      currentFrame++;
        if (currentFrame == floating.length) {
          currentFrame = 0;
        }
        changeFrame(floating);
      }
    }
    
  void drawMe() {
    pushMatrix();
      translate(width/2, height/2);
      if (vel.x > 0) {
          scale(-1, 1);
      }
      PImage img = frames[currentFrame];
      if (tint > 0) { // INVISIBILITY
        if (invis) tint(200,200,255, 100);
        else tint(255, 100);
        tint--;
      }
      image(img, -img.width/2, -img.height/2);
     popMatrix();
  }
}

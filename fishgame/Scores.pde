class Scores {
  int life;
  int keys;
  int coins;
  PImage img;
  int currentFrame = 0;
  PImage[] lifeicon = new PImage[3];
  PImage[] keysicon = new PImage[3];
  PImage[] coinsicon = new PImage[3];
  
  Scores() {
    life = 3;
    keys = 0;
    coins = 0;
    
    for (int i = 0; i < lifeicon.length; i++) {
      lifeicon[i] = loadImage("life" + i + ".png");
    }
    for (int i = 0; i < coinsicon.length; i++) {
      coinsicon[i] = loadImage("treasure" + i + ".png");
    }
    for (int i = 0; i < keysicon.length; i++) {
      keysicon[i] = loadImage("hook" + i + ".png");
    }
  }
  
  void update() {
    if (life < 1) {
        dead();
    }
    if (frameCount % 2 == 0) {
      currentFrame++;
        if (currentFrame == lifeicon.length) {
          currentFrame = 0;
        }
    }
  }
  
  void dead() {
      textSize(144);
      text("Game Over!", 80, height/2);
      if (frameCount % 13 == 0) while(true);
  }
  
  void draw() { 
    for (int i = 0; i < life; i++) {
      pushMatrix();
      translate(50+50*i, 50);
      PImage img = lifeicon[currentFrame];
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    } for (int i = 0; i < keys; i++) {
      pushMatrix();
      translate(50+20*i, 130);
      PImage img = keysicon[currentFrame];
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    }
      pushMatrix();
      translate(width-150, 50);
      textSize(64);
      text("x" + coins, 35,25);
      PImage img = coinsicon[currentFrame];
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    
  }
  
}

/*
Health tokens (starfish)
  - Are fairly common
  - Have a chance to generate when there are less than 6 on the map
  - Despawn quickly
*/

class TokenHealth extends Token {
  
  TokenHealth(PVector pos) {
    super(pos);
    for (int i = 0; i < animated.length; i++) {
      animated[i] = loadImage("biglife" + i + ".png");
    }
  }
  
  void collect(Character c) {
    if (dist(pos.x, pos.y, c.pos.x, c.pos.y) < 60) { 
      tokenhealths.remove(this);
      score.life += 1;
    }
  }
  
  boolean inWindow() {
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
  
  void update() {
    super.update();
    if (timer > (800)) {
      tokenhealths.remove(this);
    }
  }
  
  void drawMe(Character c) {
    super.drawMe(c);
  }
}

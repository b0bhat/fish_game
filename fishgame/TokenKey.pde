/*
Key tokens (hooks)
  - Will pop all bubbles for a short amount of time
  - Uncommon
  - Have a low chance to generate when there are less than 4 on the map
  - Take a very long time to despawn
*/
class TokenKey extends Token {
  
  TokenKey(PVector pos) {
    super(pos);
    for (int i = 0; i < animated.length; i++) {
      animated[i] = loadImage("hook" + i + ".png");
    }
  }
  
  void collect(Character c) {
    if (dist(pos.x, pos.y, c.pos.x, c.pos.y) < 60) { 
      tokenkeys.remove(this);
      score.keys += 1;
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
    if (timer > (2000)) {
      tokenkeys.remove(this);
    }
  }
  
  void drawMe(Character c) {
    super.drawMe(c);
  }
}

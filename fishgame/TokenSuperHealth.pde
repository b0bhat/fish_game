/* 
Super health tokens (clams)
  - Will heal 3 life and are rare
  - Have a low chance to generate when there are less than 3 on the map
  - Despawn after a little while
*/

class TokenSuperHealth extends Token {
  
  TokenSuperHealth(PVector pos) {
    super(pos);
    for (int i = 0; i < animated.length; i++) {
      animated[i] = loadImage("clam" + i + ".png");
    }
  }
  
  void collect(Character c) {
    if (dist(pos.x, pos.y, c.pos.x, c.pos.y) < 60) { 
      tokensuperhealths.remove(this);
      score.life += 3;
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
    if (timer > (1000)) {
      tokensuperhealths.remove(this);
    }
  }
  
  void drawMe(Character c) {
    super.drawMe(c);
  }
}

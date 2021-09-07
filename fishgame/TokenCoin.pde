/* 
Coin token (the shiny pearls) 
  - The most common
  - Have a large chance of generating when there are less than 8 on the map
  - Despawn after quite some time 
*/
class TokenCoin extends Token {
  
  TokenCoin(PVector pos) {
    super(pos);
    for (int i = 0; i < animated.length; i++) {
      animated[i] = loadImage("treasure" + i + ".png");
    }
  }
  
  void collect(Character c) {
    if (dist(pos.x, pos.y, c.pos.x, c.pos.y) < 60) { 
      tokencoins.remove(this);
      score.coins += 1;
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
    if (timer > (1200)) {
      tokencoins.remove(this);
    }
  }
  
  void drawMe(Character c) {
    super.drawMe(c);
  }
}

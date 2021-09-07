/*
Ryan Wu, IAT 167 D103
August 9th
*/

import ddf.minim.*;

/* INTIALIZATION */

int direction = 0;
boolean left, right, up, down;
int tileSize = 100;

AudioPlayer boing; 
Minim minim; 
Scores score;
Character fish;
ArrayList<TokenCoin> tokencoins = new ArrayList<TokenCoin>();
ArrayList<TokenHealth> tokenhealths = new ArrayList<TokenHealth>();
ArrayList<TokenSuperHealth> tokensuperhealths = new ArrayList<TokenSuperHealth>();
ArrayList<TokenKey> tokenkeys = new ArrayList<TokenKey>();
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bubbles> bubbles = new ArrayList<Bubbles>();

int[][] map = new int[32][32];

/* CONTROL */

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = true;
      direction = 0;
    } else if (keyCode == RIGHT) {
      right = true;
      direction = 1;
    } else if (keyCode == UP) {
      up = true;
    } else if (keyCode == DOWN) {
      down = true;
    } 
  }
  
  /* USING THE KEY */
  
  if (key == 'k') {
    if (score.keys > 0) {
      for (int i = 0; i< tiles.size(); i++) { 
        Tile t = tiles.get(i);
        if (t.type == 1) t.type = 2;
       } score.keys += -1;
     }
   }
  
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) left = false;
    else if (keyCode == RIGHT) right = false;
    else if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;
  }
  /* INVISIBILITY */
  if (key == ' ') {
    fish.invis = true;
    score.life--;
    fish.tint = 100;
   }
}

void setup() {
  size(1000,600);
  frameRate(60);
  score = new Scores();
  fish = new Character(new PVector(50,50));
  mapsetup();
  
  minim = new Minim (this); 
  boing = minim.loadFile("boing.mp3");
  
  /* ADDING PLAYER AND ENEMIES */
  
  for (int i = 0; i< tiles.size(); i++) { 
    Tile startTile = tiles.get(i);
    if (startTile.block==false && startTile.type != 1  && random(0,30) < 1) {
      enemies.add( new Enemy(new PVector(startTile.pos.x, startTile.pos.y)));
    } 
  }
  
  for (int i = 500; i< tiles.size(); i++) { 
    Tile startTile = tiles.get(i);
    if (startTile.block==false && startTile.type != 1) {
      fish = new Character(new PVector(startTile.pos.x, startTile.pos.y));
      break;
    } 
  }
}

/* MAP CREATION */

void mapsetup() {
  boolean block;
  int type;
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (i != 0 && j !=0 && i != map.length - 1 && j != map[i].length - 1) {
        if (random(0, 4) < 1) {
          if (random(0, 2) < 1) {
            map[i][j] = 10;
            type = 1;
          } else {
            map[i][j] = 9;
            type = 0;
          } block = true;
        } 
        else {
          map[i][j] = 0;
          if (random(0, 4) < 1) map[i][j] = int(random(0,7.9));
          block = false;
          type = 0;
        }
      } 
      else { //walls
        map[i][j] = 9;
        block = true;
        type = 0;
      }
      String path = "water" + map[i][j] + ".png";
      tiles.add(new Tile(path, new PVector(i * tileSize, j * tileSize), block, type));
    }
  }
}

/* ADDING TOKENS */

void tokenadd(int type) {
  for (int i = 0; i< tiles.size(); i++) { 
    Tile j = tiles.get(i);
    if (j.block==false && j.type != 2) {
      if ((random(0,300)<1) && (type == 1)) tokencoins.add(new TokenCoin(new PVector(j.pos.x, j.pos.y)));
      if ((random(0,500)<1) &&(type == 2)) tokenhealths.add(new TokenHealth(new PVector(j.pos.x, j.pos.y)));
      if ((random(0,800)<1) &&(type == 3)) tokensuperhealths.add(new TokenSuperHealth(new PVector(j.pos.x, j.pos.y)));
      if ((random(0,1000)<1) &&(type == 4)) tokenkeys.add(new TokenKey(new PVector(j.pos.x, j.pos.y)));
    }
  }
}

void draw() {
  background(255);
  
  /* FISH MOVEMENT */
  
  if (left) fish.move(new PVector(-1, 0));
  if (right) fish.move(new PVector(1, 0));
  if (up) fish.move(new PVector(0, -1));
  if (down) fish.move(new PVector(0, 1));
  
  fish.update();
  
  /* TILES */
  
 for (int i = 0; i < tiles.size(); i++) {
    Tile t = tiles.get(i);
    if (t.inWindow(fish)) {
      if (t.checkCollision(fish)) t.collision(fish);
      t.drawMe(fish);
      t.popbubble();
    }
    for (int j = 0; j < enemies.size(); j++) {
      Enemy e = enemies.get(j);
      if (t.checkCollisionEnemy(e)) t.collisionEnemy(e);
    }
  }
  
  /* TOKEN REPLACEMENT */
  
 if (tokencoins.size() < 8) tokenadd(1);
 for (int i = 0; i < tokencoins.size(); i++) {
   TokenCoin t = tokencoins.get(i);
   t.drawMe(fish);
   t.collect(fish);
   t.update();
 }
 if (tokenhealths.size() < 6) tokenadd(2);
 for (int i = 0; i < tokenhealths.size(); i++) {
   TokenHealth t = tokenhealths.get(i);
   t.drawMe(fish);
   t.collect(fish);
   t.update();
 }
 if (tokensuperhealths.size() < 3) tokenadd(3);
 for (int i = 0; i < tokensuperhealths.size(); i++) {
   TokenSuperHealth t = tokensuperhealths.get(i);
   t.drawMe(fish);
   t.collect(fish);
   t.update();
 }
 if (tokenkeys.size() < 4) tokenadd(4);
 for (int i = 0; i < tokenkeys.size(); i++) {
   TokenKey t = tokenkeys.get(i);
   t.drawMe(fish);
   t.collect(fish);
   t.update();
 }
 
 /* ENEMY */
 
  for (int i = 0; i < enemies.size(); i++) {
   Enemy e = enemies.get(i);
   if (e.inWindow(fish)) e.drawMe(fish);
   e.update(fish);
   if (e.hitCharacter(fish)) {
     e.bump(fish);
     fish.tint = 30;
     for (int j = 0; j < random(10,20); j++)
       bubbles.add(new Bubbles(new PVector(fish.pos.x, fish.pos.y), new PVector(random(-10,10), random(-10,10)), 1));
   }
 }
 
 /* BUBBLE EFFECTS */
 
  for (int i = 0; i < bubbles.size(); i++) {
   Bubbles b = bubbles.get(i);
   b.draw(fish);
  }
 
  if ((frameCount % 2 == 0)&&(random(0,(3/abs(fish.vel.x))) < 1)) bubbles.add(new Bubbles(new PVector(fish.pos.x, fish.pos.y), new PVector(random(-5,5), random(-5,5)), 0));
  
  /* FISH */
  
  fish.drawMe();
  noTint();
  score.update();
  score.draw();
}

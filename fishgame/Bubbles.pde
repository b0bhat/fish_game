class Bubbles {
  PVector pos, vel;
  float size;
  int life;
  int type;
  
  Bubbles(PVector pos, PVector vel, int type) {
    this.pos = pos;
    this.vel = vel;
    this.type = type;
    life = 50;
    size = random(10, 20);
  }
  
  void draw(Character c) {
    vel.mult(0.9);
    pos.add(vel);
    life--;
    pushMatrix();
    translate(pos.x -c.pos.x + width/2, pos.y -c.pos.y + height/2);
    noFill();
    strokeWeight(2);
    if (type == 0) stroke(120,240,255,life*5);
    if (type == 1) stroke(255,255,255,life*10);
    ellipse(0,0,size,size);
    popMatrix();
    if (life < 1) bubbles.remove(this);
    
  }
}

import fisica.*;

FWorld world;
PImage photo;
FBox g;
Nink nink;

void setup() {
  size(400, 400);
  imageMode(CENTER);
  rectMode(CENTER);
  
  //fisica initialization
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  world.setEdges();
  world.remove(world.top);
  world.remove(world.right);
  //bouncy edges
  //world.setEdgesRestitution(1);
  
  nink = new Nink();
  
  photo = loadImage("cruelty-squad.gif");
  photo.resize(50, 50);
  
  FBox f = new FBox(32, 32);
  f.setPosition(200, 0);
  f.setRotatable(false);
  world.add(f);
  g = new FBox(32, 32);
  
  world.add(g);
}

void draw() {
  background(255);
  image(photo, 200, 200);
  world.step();
  world.draw();
  nink.drawNink();
}

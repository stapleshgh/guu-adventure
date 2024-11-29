import fisica.*;

FWorld world;
PImage photo;

//create player object
Player player;

//create enemies
Nink nink;

void setup() {
  size(400, 400);
  imageMode(CENTER);
  rectMode(CENTER);
  
  //fisica initialization --------------------------------
  Fisica.init(this);
  
  
  //world init --------------------------------------------
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  world.setEdges();
  world.remove(world.top);
  world.remove(world.right);
  
  
  //init test nink ----------------------------------------------
  nink = new Nink();
  
  world.add(nink);
}

void draw() {
  background(255);
  world.step();
  world.draw();
  nink.drawNink();
}

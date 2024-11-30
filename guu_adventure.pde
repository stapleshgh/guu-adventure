import fisica.*;
import processing.sound.*;

//variable declaration --------------------------------------------
int gameState = 3;
FWorld world;
PImage menu;
PImage badEnd;
PImage goodEnd;
SoundFile menuMusic;
SoundFile badEndMusic;
SoundFile goodEndMusic;

//create player object ------------------------
Player player;

//create enemies ------------------------
ArrayList<Nink> ninks;
Nink nink;

Platform platform;

void setup() {
  size(400, 400);
  imageMode(CORNER);
  rectMode(CENTER);

  //load menu assets
  menu = loadImage("menuScreen.png");
  menuMusic = new SoundFile(this, "menuMusic.wav");
  menuMusic.amp(0.5);

  //load bad end assets
  badEnd = loadImage("badEnd.jpg");
  badEnd.resize(400, 400);
  badEndMusic = new SoundFile(this, "badEndMusic.mp3");

  //fisica initialization --------------------------------
  Fisica.init(this);



  //world init --------------------------------------------
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  world.setEdges();
  world.setEdgesFriction(20);
  world.remove(world.top);
  world.remove(world.right);

  platform = new Platform(400, 300, 1200, 20);

  //init test nink ----------------------------------------------
  nink = new Nink();
  player = new Player();

  world.add(nink);
  world.add(player);
  world.add(platform);
}


void draw() {
  background(255);

  //menu screen
  if (gameState == 0) {
    imageMode(CENTER);
    image(menu, 200, 200);
    if (!menuMusic.isPlaying()) {
      menuMusic.loop();
    }

    if (keyPressed) {
      //unload music
      menuMusic.pause();
      menuMusic.removeFromCache();
      gameState = 1;
      imageMode(CORNER);
    }
  }

  //game loop
  if (gameState == 1) {
    pushMatrix();
    translate(-player.getX() + width / 2, -player.getY() + height / 2);
    world.step();
    world.draw();

    popMatrix();


    nink.drawNink();
    player.drawPlayer();
    player.updatePlayer();
    platform.drawPlatform();
  }


  //you win! screen
  if (gameState == 2) {
    println("win");
  }

  //you lose! screen
  if (gameState == 3) {
    imageMode(CENTER);
    image(badEnd, 200, 200);
    if (!badEndMusic.isPlaying()) {
      badEndMusic.loop();
    }

    if (keyPressed) {
      //unload music
      badEndMusic.pause();
      badEndMusic.removeFromCache();
      gameState = 0;
      imageMode(CORNER);
    }
  }
}
